# dotfiles

My terminal and editor configs.

## What's in here

| Directory | Config |
|-----------|--------|
| `zsh/` | `.zshrc`, `.p10k.zsh` (Powerlevel10k), `.fzf.zsh` |
| `ghostty/` | Ghostty terminal config (zenwritten_dark theme) |
| `kitty/` | Kitty terminal config + themes |
| `cmux/` | cmux keyboard shortcut overrides |
| `git/` | `.gitconfig` |
| `vscode/` | VS Code settings + keybindings |

## Setup

```bash
git clone git@github.com:rupokghosh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

This will:
- Install Homebrew, zsh, fzf, Ghostty, and Kitty (if not already installed)
- Install Oh My Zsh with Powerlevel10k, zsh-autosuggestions, and zsh-syntax-highlighting
- Symlink all configs to the right locations
