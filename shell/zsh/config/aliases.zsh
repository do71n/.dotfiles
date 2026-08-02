alias vim="nvim"
alias lg="lazygit"
alias path="echo $PATH | tr ':' '\n'"

# ---- Eza (better ls) -----
alias ls="eza -l --color=always --git --icons=auto --sort=extension"

# thefuck alias
# eval $(thefuck --alias)
# eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- yazi (file manager) ----
function fe() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
