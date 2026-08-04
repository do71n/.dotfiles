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
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# GPG
export GPG_TTY=$(tty)

# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"

# Path
if [[ "$OSTYPE" = darwin* ]]; then
    #asdf config
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
    #Location: /Users/dontin/.asdf/installs/python/3.13.3t/lib/python3.13t/site-packages
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/installs/python/3.13.3t/bin:$PATH"
    #export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/installs/python/3.13.3t/lib/python3.13t/site-packages$PATH"

    #love executable
    export PATH="/Users/dontin/Documents/Personal/Game/love.app/Contents/MacOS:$PATH"
    #/Users/dontin/Documents/Personal/Game/love.app/Contents/MacOS/love
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/scripts:$PATH"

# Path to Doom Emacs Bin
export PATH="$HOME/.config/emacs/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/home/dt/.local/bin:$PATH"
