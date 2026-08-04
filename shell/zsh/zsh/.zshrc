# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Shell behavior
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

#Load copletion system
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Modular Configuration
ZSH_CONFIG="$ZDOTDIR/config"

source "$ZSH_CONFIG/path.zsh"
source "$ZSH_CONFIG/theme.zsh"
source "$ZSH_CONFIG/zplugin.zsh"
source "$ZSH_CONFIG/extra.zsh"
source "$ZSH_CONFIG/aliases.zsh"

fastfetch
