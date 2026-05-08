#!/usr/bin/env bash
# Idempotent setup script for mac-config dotfiles.
# Safe to run multiple times — skips links that already exist and backs up
# any regular files that would be overwritten.
#
# Usage:
#   ./setup.sh              # apply changes
#   ./setup.sh --dry-run    # preview what would change without touching anything
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false

for arg in "$@"; do
  case "$arg" in
    --dry-run|-n) DRY_RUN=true ;;
    *) printf 'Unknown argument: %s\nUsage: %s [--dry-run]\n' "$arg" "$0" >&2; exit 1 ;;
  esac
done

if $DRY_RUN; then
  printf '\033[0;33m[DRY RUN] No changes will be made.\033[0m\n\n'
fi

# ── helpers ──────────────────────────────────────────────────────────────────

green()  { printf '\033[0;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[0;33m%s\033[0m\n' "$*"; }
blue()   { printf '\033[0;34m%s\033[0m\n' "$*"; }

# Create a symlink from $1 (repo source) to $2 (target on disk).
# If $2 is already the correct symlink: skip.
# If $2 is a different symlink or a regular file: back it up, then relink.
link() {
  local src="$1" dst="$2"

  if [ -L "$dst" ]; then
    local existing_target
    existing_target="$(readlink "$dst")"
    if [ "$existing_target" = "$src" ]; then
      green "  ✓ already linked: $dst"
      return
    fi
    if $DRY_RUN; then
      blue "  ~ [dry run] would replace symlink: $dst  ($existing_target → $src)"
    else
      yellow "  ~ replacing symlink: $dst  ($existing_target → $src)"
      rm "$dst"
      mkdir -p "$(dirname "$dst")"
      ln -s "$src" "$dst"
    fi
  elif [ -e "$dst" ]; then
    if $DRY_RUN; then
      blue "  ~ [dry run] would back up and replace: $dst → $src"
    else
      yellow "  ~ backing up existing file: $dst → $BACKUP_DIR/"
      mkdir -p "$BACKUP_DIR"
      cp -r "$dst" "$BACKUP_DIR/"
      rm -rf "$dst"
      mkdir -p "$(dirname "$dst")"
      ln -s "$src" "$dst"
      green "  + linked: $dst → $src"
    fi
  else
    if $DRY_RUN; then
      blue "  + [dry run] would create: $dst → $src"
    else
      mkdir -p "$(dirname "$dst")"
      ln -s "$src" "$dst"
      green "  + linked: $dst → $src"
    fi
  fi
}

# Returns 0 if the named app is installed in /Applications or ~/Applications.
app_installed() {
  local name="$1"
  [ -d "/Applications/$name.app" ] || [ -d "$HOME/Applications/$name.app" ]
}

# ── git submodules ────────────────────────────────────────────────────────────

echo ""
echo "==> Initialising git submodules"
if $DRY_RUN; then
  blue "  ~ [dry run] would run: git submodule update --init --recursive"
else
  git -C "$REPO_DIR" submodule update --init --recursive
  green "  ✓ submodules up to date"
fi

# ── zsh ──────────────────────────────────────────────────────────────────────
# ~/.zshrc is not symlinked directly — it sources the repo's .zshrc and can
# hold machine-local overrides. We add a source line only if it isn't there yet.

echo ""
echo "==> Zsh"
ZSHRC="$HOME/.zshrc"
SOURCE_LINE="source $REPO_DIR/zsh/.zshrc"
if [ -f "$ZSHRC" ] && grep -qF "mac-config/zsh/.zshrc" "$ZSHRC"; then
  green "  ✓ ~/.zshrc already sources repo zshrc"
elif $DRY_RUN; then
  blue "  + [dry run] would append source line to ~/.zshrc"
else
  printf '\n# mac-config\n%s\n' "$SOURCE_LINE" >> "$ZSHRC"
  green "  + added source line to ~/.zshrc"
fi

# ── karabiner ────────────────────────────────────────────────────────────────

echo ""
echo "==> Karabiner"
if app_installed "Karabiner-Elements"; then
  link "$REPO_DIR/karabiner" "$HOME/.config/karabiner"
else
  yellow "  ! Karabiner-Elements not installed — skipping"
fi

# ── macOS key bindings ───────────────────────────────────────────────────────

echo ""
echo "==> macOS KeyBindings"
link "$REPO_DIR/macoskeybindings/DefaultKeyBinding.dict" \
     "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"

# ── VS Code ──────────────────────────────────────────────────────────────────

echo ""
echo "==> VS Code"
if app_installed "Visual Studio Code"; then
  VSCODE_USER="$HOME/Library/Application Support/Code/User"
  link "$REPO_DIR/vscode/settings.json"               "$VSCODE_USER/settings.json"
  link "$REPO_DIR/vscode/keybindings.json"            "$VSCODE_USER/keybindings.json"
  link "$REPO_DIR/vscode/snippets"                    "$VSCODE_USER/snippets"
  link "$REPO_DIR/vscode/vs_code_extensions_list.txt" "$VSCODE_USER/vs_code_extensions_list.txt"
else
  yellow "  ! VS Code not installed — skipping"
fi

# ── Cursor ───────────────────────────────────────────────────────────────────

echo ""
echo "==> Cursor"
if app_installed "Cursor"; then
  CURSOR_USER="$HOME/Library/Application Support/Cursor/User"
  link "$REPO_DIR/vscode/settings.json"    "$CURSOR_USER/settings.json"
  link "$REPO_DIR/vscode/keybindings.json" "$CURSOR_USER/keybindings.json"
  link "$REPO_DIR/vscode/snippets"         "$CURSOR_USER/snippets"
else
  yellow "  ! Cursor not installed — skipping"
fi

# ── Firefox ──────────────────────────────────────────────────────────────────
# The profile directory name is unique per install; find it automatically.

echo ""
echo "==> Firefox"
if app_installed "Firefox"; then
  FF_PROFILES_DIR="$HOME/Library/Application Support/Firefox/Profiles"
  if [ -d "$FF_PROFILES_DIR" ]; then
    PROFILE_DIR=$(find "$FF_PROFILES_DIR" -maxdepth 1 -type d \
      \( -name "*.default-release" -o -name "*.default" \) | head -1)
    if [ -n "$PROFILE_DIR" ]; then
      link "$REPO_DIR/firefox/userChrome.css" "$PROFILE_DIR/chrome/userChrome.css"
      yellow "  ! Remember: set toolkit.legacyUserProfileCustomizations.stylesheets=true in about:config"
    else
      yellow "  ! No Firefox profile found in $FF_PROFILES_DIR — skipping"
    fi
  else
    yellow "  ! Firefox installed but no profile directory found yet — skipping"
  fi
else
  yellow "  ! Firefox not installed — skipping"
fi

# ── iTerm2 ───────────────────────────────────────────────────────────────────

echo ""
echo "==> iTerm2"
if app_installed "iTerm"; then
  yellow "  ! iTerm2 preferences must be loaded manually:"
  yellow "    iTerm2 > Preferences > General > Preferences"
  yellow "    > Load preferences from a custom folder or URL"
  yellow "    Point it to: $REPO_DIR/iterm2"
else
  yellow "  ! iTerm2 not installed — skipping"
fi

# ── done ─────────────────────────────────────────────────────────────────────

echo ""
if $DRY_RUN; then
  yellow "Dry run complete. Run without --dry-run to apply changes."
else
  green "Setup complete."
  if [ -d "$BACKUP_DIR" ]; then
    yellow "Backed-up files are in: $BACKUP_DIR"
  fi
fi
echo ""
