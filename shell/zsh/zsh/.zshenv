# symlink to home

# Centralizes config/cache/data locations
# build the required folders
# mkdir -p .local/state/zsh
# mkdir -p .cahce/zs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-${HOST}-${ZSH_VERSION}"

# Set default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Pager
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
fi

# GPG
export GPG_TTY=$(tty)

# ================== Path ==================
# # $path is tied to $PATH; -U drops duplicates automatically, so later
# prepends by cargo/zoxide/asdf etc. can't create dupes either.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.local/scripts"
  "$HOME/.cargo/bin"
  $path
)

if [[ "$OSTYPE" == darwin* ]]; then
  path=(
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
    "${ASDF_DATA_DIR:-$HOME/.asdf}/installs/python/3.13.3t/bin"
    "/Users/dontin/Documents/Personal/Game/love.app/Contents/MacOS"
    $path
  )
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


