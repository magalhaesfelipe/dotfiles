#!/usr/bin/env bash
# Seamless installer for dotfiles/nvim (LazyVim + Treesitter + Mason LSPs + fff + blink.cmp + snacks.image)
# Supports: Arch/EndeavourOS (pacman), Debian/Ubuntu (apt), Fedora (dnf), macOS (brew)

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
NVIM_SOURCE_DIR="$SCRIPT_DIR"
NVIM_TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

DRY_RUN=false
SKIP_PACKAGES=false
SKIP_SYMLINK=false
SKIP_NVIM_SYNC=false

# Mason packages derived from lua/plugins/lsp.lua & lua/plugins/conform.lua
MASON_PACKAGES=(
  vtsls
  tailwindcss-language-server
  css-lsp
  html-lsp
  emmet-language-server
  eslint-lsp
  biome
  prettier
)

# Treesitter parsers derived from lua/plugins/treesitter.lua
TS_PARSERS=(
  typescript
  tsx
  javascript
  html
  css
  json
  lua
)

# -----------------------------------------------------------------------------
# Logging & Helpers
# -----------------------------------------------------------------------------
if [[ -t 1 ]]; then
  C_RESET='\033[0m'
  C_BOLD='\033[1m'
  C_BLUE='\033[34m'
  C_GREEN='\033[32m'
  C_YELLOW='\033[33m'
  C_RED='\033[31m'
else
  C_RESET='' C_BOLD='' C_BLUE='' C_GREEN='' C_YELLOW='' C_RED=''
fi

info()    { printf "${C_BLUE}[INFO]${C_RESET} %s\n" "$*"; }
success() { printf "${C_GREEN}[OK]${C_RESET}   %s\n" "$*"; }
warn()    { printf "${C_YELLOW}[WARN]${C_RESET} %s\n" "$*"; }
err()     { printf "${C_RED}[ERR]${C_RESET}  %s\n" "$*" >&2; }
section() { printf "\n${C_BOLD}==> %s${C_RESET}\n" "$*"; }

has_cmd() { command -v "$1" >/dev/null 2>&1; }

run_cmd() {
  if $DRY_RUN; then
    printf "${C_YELLOW}[DRY-RUN]${C_RESET} %s\n" "$*"
    return 0
  fi
  "$@"
}

run_sudo() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
    run_cmd "$@"
  else
    run_cmd sudo "$@"
  fi
}

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Installs system dependencies, symlinks dotfiles/nvim, and bootstraps LazyVim,
Mason LSPs/formatters, and Treesitter parsers.

Options:
  --dry-run          Print commands without executing them
  --skip-packages    Skip OS package manager & Rust/Cargo installations
  --skip-symlink     Skip linking $NVIM_SOURCE_DIR -> $NVIM_TARGET_DIR
  --skip-nvim        Skip headless Neovim plugin, Mason, and Treesitter sync
  -h, --help         Show this help message
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)        DRY_RUN=true ;;
      --skip-packages)  SKIP_PACKAGES=true ;;
      --skip-symlink)   SKIP_SYMLINK=true ;;
      --skip-nvim)      SKIP_NVIM_SYNC=true ;;
      -h|--help)        usage; exit 0 ;;
      *)                err "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
  done
}

detect_pkg_manager() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "brew"
  elif has_cmd pacman; then
    echo "pacman"
  elif has_cmd apt-get; then
    echo "apt"
  elif has_cmd dnf; then
    echo "dnf"
  else
    echo "unknown"
  fi
}

# -----------------------------------------------------------------------------
# Step 1: System Dependencies
# -----------------------------------------------------------------------------
install_rust_if_missing() {
  if has_cmd cargo && has_cmd rustc; then
    success "Rust toolchain already installed ($(rustc --version))"
    return 0
  fi

  local pm="$1"
  info "Installing Rust toolchain (needed for fff / blink.cmp fallback builds & tree-sitter-cli)..."
  case "$pm" in
    pacman)
      # Avoid conflicting with rustup if already installed via pacman
      if pacman -Qi rustup >/dev/null 2>&1; then
        info "rustup package found; ensuring default stable toolchain..."
        run_cmd rustup default stable
      else
        run_sudo pacman -S --needed --noconfirm rust
      fi
      ;;
    brew)
      run_cmd brew install rust
      ;;
    *)
      if has_cmd curl; then
        run_cmd bash -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y'
        export PATH="$HOME/.cargo/bin:$PATH"
      else
        warn "curl not found; skipping rustup installation."
      fi
      ;;
  esac
}

install_tree_sitter_cli_if_missing() {
  if has_cmd tree-sitter; then
    success "tree-sitter CLI already installed ($(tree-sitter --version))"
    return 0
  fi

  if has_cmd cargo; then
    info "Installing tree-sitter-cli via cargo..."
    run_cmd cargo install --locked tree-sitter-cli
  elif has_cmd npm; then
    warn "cargo not available; installing tree-sitter-cli globally via npm..."
    run_cmd npm install -g tree-sitter-cli
  else
    warn "Could not install tree-sitter-cli (neither cargo nor npm available)."
  fi
}

install_packages_pacman() {
  local pkgs=(
    # Core editor & archive/download tools
    neovim
    git
    curl
    tar
    gzip
    unzip
    # C/C++ compiler & build tools (nvim-treesitter parser compilation)
    base-devel
    tree-sitter-cli
    # Node.js / npm (Mason LSPs: vtsls, tailwindcss, cssls, html, emmet, eslint, biome, prettier)
    nodejs
    npm
    # Search & navigation CLI tools (grug-far, snacks picker, todo-comments, blink-cmp-dictionary)
    ripgrep
    fd
    fzf
    jq
    # Clipboard integration (options.lua: clipboard = "unnamedplus")
    wl-clipboard
    xclip
    # Image rendering (plugins/image.lua: snacks.image)
    imagemagick
    ghostscript
    poppler
    # Nerd Fonts (lualine, incline, oil, nvim-web-devicons, mini.icons)
    ttf-jetbrains-mono-nerd
    ttf-nerd-fonts-symbols
  )

  info "Installing packages via pacman..."
  run_sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  install_rust_if_missing pacman
  install_tree_sitter_cli_if_missing
}

install_packages_apt() {
  local pkgs=(
    neovim
    git
    curl
    tar
    gzip
    unzip
    build-essential
    nodejs
    npm
    ripgrep
    fd-find
    fzf
    jq
    wl-clipboard
    xclip
    imagemagick
    ghostscript
    poppler-utils
  )

  info "Installing packages via apt-get..."
  run_sudo apt-get update
  run_sudo apt-get install -y "${pkgs[@]}"

  # Debian/Ubuntu installs fd as fdfind; expose it as fd in ~/.local/bin
  if has_cmd fdfind && ! has_cmd fd; then
    info "Creating ~/.local/bin/fd symlink for fdfind..."
    run_cmd mkdir -p "$HOME/.local/bin"
    run_cmd ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
    export PATH="$HOME/.local/bin:$PATH"
  fi

  install_rust_if_missing apt
  install_tree_sitter_cli_if_missing

  warn "Nerd Font: install JetBrainsMono Nerd Font manually from https://www.nerdfonts.com/font-downloads"
  warn "Note: Debian/Ubuntu apt may ship an older Neovim; this config requires Neovim >= 0.11."
}

install_packages_dnf() {
  local pkgs=(
    neovim
    git
    curl
    tar
    gzip
    unzip
    gcc
    gcc-c++
    make
    nodejs
    npm
    ripgrep
    fd-find
    fzf
    jq
    wl-clipboard
    xclip
    ImageMagick
    ghostscript
    poppler-utils
  )

  info "Installing packages via dnf..."
  run_sudo dnf install -y "${pkgs[@]}"
  install_rust_if_missing dnf
  install_tree_sitter_cli_if_missing

  warn "Nerd Font: install JetBrainsMono Nerd Font manually from https://www.nerdfonts.com/font-downloads"
}

install_packages_brew() {
  if ! has_cmd brew; then
    err "Homebrew is not installed. Install it from https://brew.sh and re-run."
    exit 1
  fi

  local pkgs=(
    neovim
    git
    curl
    gnu-tar
    unzip
    node
    tree-sitter-cli
    ripgrep
    fd
    fzf
    jq
    imagemagick
    ghostscript
    poppler
  )

  info "Installing packages via Homebrew..."
  run_cmd brew install "${pkgs[@]}"
  run_cmd brew install --cask font-jetbrains-mono-nerd-font font-symbols-only-nerd-font || true
  install_rust_if_missing brew
  install_tree_sitter_cli_if_missing
}

install_system_packages() {
  section "Installing system packages"
  local pm
  pm="$(detect_pkg_manager)"
  info "Detected package manager: $pm"

  case "$pm" in
    pacman) install_packages_pacman ;;
    apt)    install_packages_apt ;;
    dnf)    install_packages_dnf ;;
    brew)   install_packages_brew ;;
    *)
      err "Unsupported package manager. Install dependencies manually and re-run with --skip-packages."
      exit 1
      ;;
  esac
}

# -----------------------------------------------------------------------------
# Step 2: Symlink Neovim Configuration
# -----------------------------------------------------------------------------
setup_symlink() {
  section "Linking Neovim configuration"
  local parent_dir
  parent_dir="$(dirname "$NVIM_TARGET_DIR")"

  if [[ -L "$NVIM_TARGET_DIR" ]]; then
    local current_target
    current_target="$(readlink -f "$NVIM_TARGET_DIR" || true)"
    if [[ "$current_target" == "$(readlink -f "$NVIM_SOURCE_DIR")" ]]; then
      success "Symlink already configured: $NVIM_TARGET_DIR -> $NVIM_SOURCE_DIR"
      return 0
    fi
  fi

  if [[ -e "$NVIM_TARGET_DIR" || -L "$NVIM_TARGET_DIR" ]]; then
    local backup="${NVIM_TARGET_DIR}.bak.$(date +%Y%m%d_%H%M%S)"
    warn "Existing config found at $NVIM_TARGET_DIR; backing up to $backup"
    run_cmd mv "$NVIM_TARGET_DIR" "$backup"
  fi

  run_cmd mkdir -p "$parent_dir"
  run_cmd ln -sfn "$NVIM_SOURCE_DIR" "$NVIM_TARGET_DIR"
  success "Linked $NVIM_TARGET_DIR -> $NVIM_SOURCE_DIR"
}

# -----------------------------------------------------------------------------
# Step 3: Headless Neovim Bootstrap (Lazy plugins, Mason tools, Treesitter)
# -----------------------------------------------------------------------------
check_nvim_version() {
  if ! has_cmd nvim; then
    err "nvim is not on PATH; cannot run headless bootstrap."
    return 1
  fi

  local ver major minor
  ver="$(nvim --version | head -n 1 | sed -E 's/^NVIM v([0-9]+\.[0-9]+).*/\1/')"
  major="${ver%%.*}"
  minor="${ver#*.}"
  if [[ "$major" -eq 0 && "$minor" -lt 11 ]]; then
    warn "Detected Neovim v$ver, but this config uses vim.lsp.config & virtual_lines (Neovim >= 0.11 required)."
  else
    success "Neovim version check passed (v$ver)"
  fi
}

bootstrap_neovim() {
  section "Bootstrapping Neovim (Lazy.nvim, Mason, Treesitter)"

  if $DRY_RUN; then
    info "[DRY-RUN] Would run: nvim --headless '+Lazy! sync' +qa"
    info "[DRY-RUN] Would install Mason packages: ${MASON_PACKAGES[*]}"
    info "[DRY-RUN] Would install Treesitter parsers: ${TS_PARSERS[*]}"
    return 0
  fi

  check_nvim_version

  info "Syncing plugins via lazy.nvim (includes fff binary download/build)..."
  nvim --headless "+Lazy! sync" +qa
  success "Plugins synced."

  info "Installing Mason LSP servers and formatters: ${MASON_PACKAGES[*]}..."
  local mason_lua_list
  mason_lua_list="$(printf '"%s",' "${MASON_PACKAGES[@]}")"
  nvim --headless -c "lua
    require('mason')
    local mr = require('mason-registry')
    local tools = { ${mason_lua_list} }
    local ready = false
    local pending = 0
    local failed = {}

    mr.refresh(function()
      for _, name in ipairs(tools) do
        local ok, pkg = pcall(mr.get_package, name)
        if not ok then
          table.insert(failed, name .. ' (not found)')
        elseif not pkg:is_installed() then
          pending = pending + 1
          pkg:once('install:success', function() pending = pending - 1 end)
          pkg:once('install:failed', function()
            table.insert(failed, name)
            pending = pending - 1
          end)
          pkg:install()
        end
      end
      ready = true
    end)

    local finished = vim.wait(300000, function() return ready and pending == 0 end, 200)
    if not finished then
      io.stderr:write('Timed out waiting for Mason installations.\n')
    end
    if #failed > 0 then
      io.stderr:write('Mason failed packages: ' .. table.concat(failed, ', ') .. '\n')
    end
  " +qa
  success "Mason packages installed."

  info "Installing Treesitter parsers: ${TS_PARSERS[*]}..."
  local ts_lua_list
  ts_lua_list="$(printf '"%s",' "${TS_PARSERS[@]}")"
  nvim --headless -c "lua
    local ok, ts = pcall(require, 'nvim-treesitter')
    if ok and ts.install then
      local task = ts.install({ ${ts_lua_list} })
      if task and task.wait then
        task:wait(300000)
      end
    end
  " +qa
  success "Treesitter parsers installed."
}

# -----------------------------------------------------------------------------
# Step 4: Verification Summary
# -----------------------------------------------------------------------------
verify_environment() {
  section "Verification summary"
  local tools=(nvim git curl gcc make node npm cargo tree-sitter rg fd fzf magick)
  local missing=0

  for cmd in "${tools[@]}"; do
    if has_cmd "$cmd"; then
      success "$(printf '%-13s -> %s' "$cmd" "$(command -v "$cmd")")"
    else
      warn "$(printf '%-13s -> NOT FOUND' "$cmd")"
      missing=$((missing + 1))
    fi
  done

  if has_cmd wl-copy || has_cmd xclip || has_cmd pbcopy; then
    success "Clipboard     -> available"
  else
    warn "Clipboard     -> no wl-copy/xclip/pbcopy found"
    missing=$((missing + 1))
  fi

  if [[ -L "$NVIM_TARGET_DIR" ]]; then
    success "Config link   -> $NVIM_TARGET_DIR -> $(readlink "$NVIM_TARGET_DIR")"
  else
    warn "Config link   -> $NVIM_TARGET_DIR is not a symlink"
  fi

  printf "\n"
  if [[ $missing -eq 0 ]]; then
    success "All checks passed! Launch Neovim with: nvim (run :checkhealth to double-check)"
  else
    warn "$missing item(s) missing. Review warnings above or run :checkhealth inside Neovim."
  fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
  parse_args "$@"

  if ! $SKIP_PACKAGES; then
    install_system_packages
  fi

  if ! $SKIP_SYMLINK; then
    setup_symlink
  fi

  if ! $SKIP_NVIM_SYNC; then
    bootstrap_neovim
  fi

  verify_environment
}

main "$@"
