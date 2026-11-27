#!/usr/bin/env bash
# Seamless dotfiles installer (Arch / EndeavourOS)
# Installs terminal/shell tools (ghostty, eza, zoxide, oh-my-posh), Neovim & all
# plugin dependencies (Rust for fff/blink, Node/npm for Mason LSPs, Treesitter, etc.),
# symlinks configs, and bootstraps Neovim headlessly.

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

DRY_RUN=false
SKIP_PACKAGES=false
SKIP_AUR=false
SKIP_SYMLINK=false
SKIP_NVIM=false

PACMAN_PACKAGES=(
  # Terminal & shell
  ghostty
  kitty
  tmux
  eza
  zoxide
  fastfetch

  # Neovim & core tools
  neovim
  git
  curl
  tar
  gzip
  unzip

  # C/C++ build toolchain & Treesitter CLI (nvim-treesitter main branch)
  base-devel
  tree-sitter-cli

  # Node.js / npm (Mason LSPs & formatters: vtsls, tailwind, css, html, emmet, eslint, biome, prettier)
  nodejs
  npm

  # Search & CLI utilities (grug-far, snacks picker, todo-comments, blink-cmp-dictionary)
  ripgrep
  fd
  fzf
  jq

  # Clipboard (unnamedplus) & image preview (snacks.image)
  wl-clipboard
  xclip
  imagemagick
  ghostscript
  poppler

  # Nerd Fonts (eza icons, oh-my-posh, lualine, oil, devicons)
  ttf-jetbrains-mono-nerd
  ttf-nerd-fonts-symbols
)

AUR_PACKAGES=(
  oh-my-posh-bin
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

Installs dotfiles dependencies (ghostty, eza, rust, neovim, etc.), symlinks
configs, and bootstraps Neovim plugins, Mason LSPs, and Treesitter parsers.

Options:
  --dry-run          Print commands without executing them
  --skip-packages    Skip pacman & Rust installations
  --skip-aur         Skip AUR package installations (oh-my-posh-bin)
  --skip-symlink     Skip creating config symlinks
  --skip-nvim        Skip headless Neovim bootstrap (Lazy/Mason/Treesitter)
  -h, --help         Show this help message
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)        DRY_RUN=true ;;
      --skip-packages)  SKIP_PACKAGES=true ;;
      --skip-aur)       SKIP_AUR=true ;;
      --skip-symlink)   SKIP_SYMLINK=true ;;
      --skip-nvim)      SKIP_NVIM=true ;;
      -h|--help)        usage; exit 0 ;;
      *)                err "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
  done
}

# -----------------------------------------------------------------------------
# Step 1: Official Arch Packages & Rust
# -----------------------------------------------------------------------------
install_rust_if_missing() {
  if has_cmd cargo && has_cmd rustc; then
    success "Rust toolchain already installed ($(rustc --version))"
    return 0
  fi

  info "Installing Rust toolchain (needed for fff.lua & blink.cmp native builds)..."
  if pacman -Qi rustup >/dev/null 2>&1; then
    run_cmd rustup default stable
  else
    run_sudo pacman -S --needed --noconfirm rust
  fi
}

install_packages() {
  section "Installing official packages (pacman)"
  if ! has_cmd pacman; then
    err "pacman not found. This script targets Arch / EndeavourOS (for Neovim on other OSes, use nvim/install.sh)."
    exit 1
  fi

  run_sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"
  install_rust_if_missing
}

# -----------------------------------------------------------------------------
# Step 2: AUR Packages
# -----------------------------------------------------------------------------
install_aur_packages() {
  section "Installing AUR packages"
  local aur_helper=""
  if has_cmd yay; then
    aur_helper="yay"
  elif has_cmd paru; then
    aur_helper="paru"
  else
    warn "No AUR helper (yay/paru) found; skipping: ${AUR_PACKAGES[*]}"
    return 0
  fi

  info "Using AUR helper: $aur_helper"
  run_cmd "$aur_helper" -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

# -----------------------------------------------------------------------------
# Step 3: Symlinks
# -----------------------------------------------------------------------------
link_path() {
  local src="$1"
  local dst="$2"

  if [[ ! -e "$src" ]]; then
    warn "Source missing, skipping link: $src"
    return 0
  fi

  if [[ -L "$dst" ]]; then
    local current
    current="$(readlink -f "$dst" || true)"
    if [[ "$current" == "$(readlink -f "$src")" ]]; then
      success "Already linked: $dst -> $src"
      return 0
    fi
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
    warn "Existing path at $dst; backing up to $backup"
    run_cmd mv "$dst" "$backup"
  fi

  run_cmd mkdir -p "$(dirname "$dst")"
  run_cmd ln -sfn "$src" "$dst"
  success "Linked $dst -> $src"
}

setup_symlinks() {
  section "Linking dotfiles"
  link_path "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

  for dir in nvim ghostty kitty fastfetch; do
    link_path "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
  done
}

# -----------------------------------------------------------------------------
# Step 4: Bootstrap Neovim (LazyVim, Mason LSPs/formatters, Treesitter)
# -----------------------------------------------------------------------------
bootstrap_nvim() {
  section "Bootstrapping Neovim"
  local nvim_script="$DOTFILES_DIR/nvim/install.sh"
  if [[ ! -x "$nvim_script" ]]; then
    warn "$nvim_script not found or not executable; skipping Neovim bootstrap."
    return 0
  fi

  local args=(--skip-packages --skip-symlink)
  if $DRY_RUN; then
    args+=(--dry-run)
  fi
  "$nvim_script" "${args[@]}"
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
  parse_args "$@"

  if ! $SKIP_PACKAGES; then
    install_packages
  fi

  if ! $SKIP_AUR; then
    install_aur_packages
  fi

  if ! $SKIP_SYMLINK; then
    setup_symlinks
  fi

  if ! $SKIP_NVIM; then
    bootstrap_nvim
  fi

  printf "\n"
  success "Done! Reload your shell with: source ~/.bashrc"
}

main "$@"
