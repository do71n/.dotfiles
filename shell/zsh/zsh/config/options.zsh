# treat - as _ in completion
HYPHEN_INSENSITIVE="true"

# update behavior
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f" # or set to true for the default red dots.

# HIST_STAMPS="mm/dd/yyyy"

# Default ZSH_CUTSTOM is set to ~/.oh-my-zsh/custom
# ZSH_CUSTOM=/path/to/new-custom-folder

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
