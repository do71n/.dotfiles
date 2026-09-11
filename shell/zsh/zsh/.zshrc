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
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# Load completion system (handled by oh-my-zsh)
# Enable interactive completion meun selection (tab)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive

# ==== Load fzf completion system  ====
# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# MacOS (brew)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# Modular Configs (source)
ZSH_CONFIG="$ZDOTDIR/config"

source "$ZSH_CONFIG/options.zsh"
source "$ZSH_CONFIG/zplugin.zsh"
source "$ZSH_CONFIG/extra.zsh"
source "$ZSH_CONFIG/bindings.zsh"
source "$ZSH_CONFIG/aliases.zsh"
source "$ZSH_CONFIG/theme.zsh"

