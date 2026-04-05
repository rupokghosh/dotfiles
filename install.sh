#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Dotfiles directory: $DOTFILES_DIR"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "==> Homebrew already installed"
fi

# --- Zsh ---
if ! command -v zsh &>/dev/null; then
  echo "==> Installing zsh..."
  brew install zsh
else
  echo "==> zsh already installed"
fi

# --- fzf ---
if ! command -v fzf &>/dev/null; then
  echo "==> Installing fzf..."
  brew install fzf
  # Run fzf install script for key bindings and completion (non-interactive)
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
else
  echo "==> fzf already installed"
fi

# --- Ghostty ---
if ! brew list --cask ghostty &>/dev/null 2>&1; then
  echo "==> Installing Ghostty..."
  brew install --cask ghostty
else
  echo "==> Ghostty already installed"
fi

# --- cmux ---
if ! brew list --cask cmux &>/dev/null 2>&1; then
  echo "==> Installing cmux..."
  brew install --cask cmux
else
  echo "==> cmux already installed"
fi

# --- Kitty ---
if ! brew list --cask kitty &>/dev/null 2>&1; then
  echo "==> Installing Kitty..."
  brew install --cask kitty
else
  echo "==> Kitty already installed"
fi

# --- Oh My Zsh ---
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
  echo "==> Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "==> Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}"

# --- zsh-autosuggestions plugin ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "==> Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "==> zsh-autosuggestions already installed"
fi

# --- zsh-syntax-highlighting plugin ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "==> Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "==> zsh-syntax-highlighting already installed"
fi

# --- Powerlevel10k theme ---
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "==> Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "==> Powerlevel10k already installed"
fi

# --- Symlinks ---
echo "==> Creating symlinks..."

# zsh
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/zsh/.fzf.zsh" "$HOME/.fzf.zsh"

# git
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# ghostty
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# kitty
mkdir -p "$HOME/.config/kitty"
ln -sf "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$DOTFILES_DIR/kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"
[ -f "$DOTFILES_DIR/kitty/dark-theme.auto.conf" ] && ln -sf "$DOTFILES_DIR/kitty/dark-theme.auto.conf" "$HOME/.config/kitty/dark-theme.auto.conf"
[ -f "$DOTFILES_DIR/kitty/1984 Dark.conf" ] && ln -sf "$DOTFILES_DIR/kitty/1984 Dark.conf" "$HOME/.config/kitty/1984 Dark.conf"

# cmux
mkdir -p "$HOME/.config/cmux"
ln -sf "$DOTFILES_DIR/cmux/settings.json" "$HOME/.config/cmux/settings.json"

echo "==> Done! Restart your shell or run: exec zsh"
