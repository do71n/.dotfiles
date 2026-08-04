alias path="echo $PATH | tr ':' '\n'"

# ---- Eza (better ls) -----
alias ls="eza -l -lh --color=always --git --icons=auto --sort=extension"
alias lh="eza -l -lah --color=always --git --icons --sort=extension"
alias tree="eza --tree --icons"
compdef eza=ls

# ---- Eza (better ls) -----
alias grep="rg --color=auto"
alias diff="diff --color=auto"
alias df="df -h"

# thefuck alias
# eval $(thefuck --alias)
# eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

alias cat="bat"

# ---- yazi (file manager) ----
function fe() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
