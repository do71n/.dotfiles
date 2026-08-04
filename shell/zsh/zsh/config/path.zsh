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
