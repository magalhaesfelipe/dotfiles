#!/usr/bin/env bash
# Seamless installer for dotfiles/keyd + keyd-nav indicator overlay
# Installs keyd & GTK3/Wayland layer-shell dependencies (Arch / EndeavourOS),
# symlinks /etc/keyd/default.conf, configures the keyd group & system service,
# and installs/enables the keyd-nav-indicator user service for the nav mode HUD.

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

KEYD_CONF_SRC="$SCRIPT_DIR/default.conf"
KEYD_CONF_DST="/etc/keyd/default.conf"

NAV_SCRIPT_SRC="$DOTFILES_DIR/keyd-nav/.local/bin/keyd-nav-indicator"
NAV_SCRIPT_DST="$HOME/.local/bin/keyd-nav-indicator"

NAV_SERVICE_SRC="$DOTFILES_DIR/keyd-nav/.config/systemd/user/keyd-nav.service"
NAV_SERVICE_DST="$CONFIG_DIR/systemd/user/keyd-nav.service"

TARGET_USER="${SUDO_USER:-$USER}"

DRY_RUN=false
SKIP_PACKAGES=false
SKIP_SYMLINK=false
SKIP_SERVICES=false
NEEDS_RELOGIN=false

PACMAN_PACKAGES=(
  # Keyboard remapping daemon
  keyd

  # Nav mode indicator overlay (GTK3 + Wayland layer-shell + notifications)
  gtk3
  gtk-layer-shell
  python-gobject
  python-cairo
  libnotify
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

Installs keyd and keyd-nav-indicator dependencies, symlinks /etc/keyd/default.conf
and the nav mode indicator script/service, adds your user to the keyd group, and
enables both keyd.service and keyd-nav.service.

Options:
  --dry-run          Print commands without executing them
  --skip-packages    Skip pacman package installations
  --skip-symlink     Skip creating config/script/service symlinks
  --skip-services    Skip group setup and systemd service enable/start
  -h, --help         Show this help message
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)        DRY_RUN=true ;;
      --skip-packages)  SKIP_PACKAGES=true ;;
      --skip-symlink)   SKIP_SYMLINK=true ;;
      --skip-services)  SKIP_SERVICES=true ;;
      -h|--help)        usage; exit 0 ;;
      *)                err "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
  done
}

# -----------------------------------------------------------------------------
# Step 1: Packages
# -----------------------------------------------------------------------------
install_packages() {
  section "Installing keyd & nav indicator packages (pacman)"
  if ! has_cmd pacman; then
    warn "pacman not found; install manually: keyd, gtk3, gtk-layer-shell, python-gobject, python-cairo, libnotify"
    return 0
  fi

  run_sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"
}

# -----------------------------------------------------------------------------
# Step 2: Symlinks (keyd config + keyd-nav-indicator + systemd user unit)
# -----------------------------------------------------------------------------
link_path() {
  local src="$1"
  local dst="$2"
  local use_sudo="${3:-false}"

  if [[ ! -e "$src" ]]; then
    err "Source missing: $src"
    return 1
  fi

  if [[ -L "$dst" ]]; then
    local current
    current="$(readlink -f "$dst" || true)"
    if [[ "$current" == "$(readlink -f "$src")" ]]; then
      success "Already linked: $dst -> $src"
      return 0
    fi
  fi

  local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
  if [[ "$use_sudo" == "true" ]]; then
    if [[ -e "$dst" || -L "$dst" ]]; then
      warn "Existing path at $dst; backing up to $backup"
      run_sudo mv "$dst" "$backup"
    fi
    run_sudo mkdir -p "$(dirname "$dst")"
    run_sudo ln -sfn "$src" "$dst"
  else
    if [[ -e "$dst" || -L "$dst" ]]; then
      warn "Existing path at $dst; backing up to $backup"
      run_cmd mv "$dst" "$backup"
    fi
    run_cmd mkdir -p "$(dirname "$dst")"
    run_cmd ln -sfn "$src" "$dst"
  fi
  success "Linked $dst -> $src"
}

setup_symlinks() {
  section "Linking keyd config and nav mode indicator"
  link_path "$KEYD_CONF_SRC" "$KEYD_CONF_DST" true

  if [[ -f "$NAV_SCRIPT_SRC" && ! -x "$NAV_SCRIPT_SRC" ]]; then
    info "Making $NAV_SCRIPT_SRC executable"
    run_cmd chmod +x "$NAV_SCRIPT_SRC"
  fi

  link_path "$NAV_SCRIPT_SRC" "$NAV_SCRIPT_DST" false
  link_path "$NAV_SERVICE_SRC" "$NAV_SERVICE_DST" false
}

# -----------------------------------------------------------------------------
# Step 3: Group Permissions & Systemd Services
# -----------------------------------------------------------------------------
setup_keyd_group() {
  section "Configuring keyd group membership"
  if ! getent group keyd >/dev/null 2>&1; then
    info "Creating keyd group..."
    run_sudo groupadd --system keyd
  fi

  if id -nG "$TARGET_USER" 2>/dev/null | tr ' ' '\n' | grep -qx "keyd"; then
    success "User '$TARGET_USER' is already in the 'keyd' group"
  else
    info "Adding '$TARGET_USER' to 'keyd' group (required for 'keyd listen' socket access)..."
    run_sudo usermod -aG keyd "$TARGET_USER"
    NEEDS_RELOGIN=true
    warn "Added '$TARGET_USER' to 'keyd' group. Log out and back in (or reboot) for it to take effect."
  fi
}

setup_services() {
  section "Enabling keyd & keyd-nav services"

  if has_cmd keyd && [[ -f "$KEYD_CONF_SRC" ]]; then
    info "Validating keyd config ($KEYD_CONF_SRC)..."
    run_cmd keyd check "$KEYD_CONF_SRC"
  fi

  if ! has_cmd systemctl; then
    warn "systemctl not found; skipping service enable/start."
    return 0
  fi

  # System keyd daemon
  if [[ -d /run/systemd/system ]]; then
    run_sudo systemctl enable --now keyd.service
    if has_cmd keyd; then
      run_sudo keyd reload || true
    fi
    success "keyd.service enabled and running"
  else
    warn "Systemd system bus unavailable; run manually: sudo systemctl enable --now keyd.service"
  fi

  # User nav mode indicator daemon
  if systemctl --user show-environment >/dev/null 2>&1; then
    run_cmd systemctl --user daemon-reload
    run_cmd systemctl --user enable --now keyd-nav.service
    run_cmd systemctl --user restart keyd-nav.service
    success "keyd-nav.service enabled and started"
  else
    warn "User systemd session unavailable; run manually in your desktop session:"
    warn "  systemctl --user daemon-reload && systemctl --user enable --now keyd-nav.service"
  fi
}

# -----------------------------------------------------------------------------
# Step 4: Verification Summary
# -----------------------------------------------------------------------------
verify_setup() {
  section "Verification summary"
  local issues=0

  if has_cmd keyd; then
    success "keyd binary   -> $(command -v keyd) ($(keyd --version 2>/dev/null || echo 'installed'))"
  else
    warn "keyd binary   -> NOT FOUND"
    issues=$((issues + 1))
  fi

  if has_cmd stdbuf; then
    success "stdbuf binary -> $(command -v stdbuf)"
  else
    warn "stdbuf binary -> NOT FOUND (coreutils required)"
    issues=$((issues + 1))
  fi

  if python3 -c "import cairo, gi; gi.require_version('Gtk', '3.0'); from gi.repository import Gtk" >/dev/null 2>&1; then
    success "GTK3 / Cairo  -> available"
  else
    warn "GTK3 / Cairo  -> missing (install gtk3, python-gobject, python-cairo)"
    issues=$((issues + 1))
  fi

  if python3 -c "import gi; gi.require_version('GtkLayerShell', '0.1'); from gi.repository import GtkLayerShell" >/dev/null 2>&1; then
    success "GtkLayerShell -> available (Wayland overlay supported)"
  else
    warn "GtkLayerShell -> missing (Wayland overlay requires gtk-layer-shell)"
    issues=$((issues + 1))
  fi

  for pair in \
    "$KEYD_CONF_DST:$KEYD_CONF_SRC" \
    "$NAV_SCRIPT_DST:$NAV_SCRIPT_SRC" \
    "$NAV_SERVICE_DST:$NAV_SERVICE_SRC"; do
    local dst="${pair%%:*}"
    local src="${pair#*:}"
    if [[ -L "$dst" && "$(readlink -f "$dst" || true)" == "$(readlink -f "$src")" ]]; then
      success "Symlink       -> $dst"
    else
      warn "Symlink       -> $dst is not linked to $src"
      issues=$((issues + 1))
    fi
  done

  if getent group keyd 2>/dev/null | grep -Eq "(^|:|,)${TARGET_USER}(,|$)"; then
    if id -nG 2>/dev/null | tr ' ' '\n' | grep -qx "keyd"; then
      success "keyd group    -> '$TARGET_USER' active in current session"
    else
      warn "keyd group    -> '$TARGET_USER' is in /etc/group, but re-login is needed for current session"
      NEEDS_RELOGIN=true
    fi
  else
    warn "keyd group    -> '$TARGET_USER' is NOT in the 'keyd' group"
    issues=$((issues + 1))
  fi

  printf "\n"
  if $DRY_RUN; then
    info "Dry run complete."
  elif [[ $issues -eq 0 ]]; then
    success "keyd and nav mode indicator are configured!"
    if $NEEDS_RELOGIN; then
      warn "Log out and back in (or reboot) so keyd-nav-indicator can read the keyd socket."
    fi
  else
    warn "$issues check(s) need attention. Review the warnings above."
  fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
  parse_args "$@"

  if ! $SKIP_PACKAGES; then
    install_packages
  fi

  if ! $SKIP_SYMLINK; then
    setup_symlinks
  fi

  if ! $SKIP_SERVICES; then
    setup_keyd_group
    setup_services
  fi

  verify_setup
}

main "$@"
