# Tips: auto source all files with .zsh extension by *.zsh
# ZSH_CONFIG_DIR="$HOME/.config/zsh/config"
ZSH_CONFIG_DIR="$HOME/.dotfiles/shell/zsh/config"

export EDITOR="nvim"

source "$ZSH_CONFIG_DIR/path.zsh"
source "$ZSH_CONFIG_DIR/theme.zsh"
source "$ZSH_CONFIG_DIR/zplugin.zsh"
source "$ZSH_CONFIG_DIR/extra.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"

fastfetch
