alias srczsh="source ~/.config/zsh/.zshrc"
alias path="echo $PATH | tr ':' '\n'"

# ---- utils ----
alias vpn="$HOME/tools/vpn.sh"

alias rm='rm -I'

# ---- Eza (better ls) -----
alias ls='eza -lh --icons --no-time --no-user --no-permissions'
alias ll="eza -lh --color --git --icons --sort=extension"
alias la="eza -lah --color --git --icons --sort=extension"
alias tree="eza --tree --icons"
compdef eza=ls

# ---- rg (better ripgrep) -----
alias grep="rg --color=auto"

# diff
alias diff="diff --color"
alias df="df -h"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- bat (better cat) ----
alias cat="bat"

# nvim and neovide
alias vim='nvim'
alias svim='sudo -E nvim'
alias nvid="(neovide > /dev/null 2>&1 &)"

# ---- yazi (file manager) ----
function fe() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ---- git ----
alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
