# =========================================================
# FZF Integration & Defaults
# =========================================================

# 1. Initialize FZF native Zsh bindings & completion
eval "$(fzf --zsh)"

# 2. Global Default Engine & Appearance (Applies to all fzf commands)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt="🔍 "
  --pointer="➜ "
  --preview-window=right:65%:wrap:border-left
'

# 3. File Preview Settings (CTRL+T)
export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# 4. Custom History Search Override (CTRL+R)
# Overrides global height/border specifically for History view
export FZF_CTRL_R_OPTS="
  --height=45%
  --border=sharp
  --header='[ 📜 Cmd History ]'
  --prompt='🔍 Search: '
"

# =========================================================
# Custom Widget: Files Excluding Hidden (CTRL+F)
# =========================================================
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"
  zle reset-prompt
}
zle -N _fzf_file_no_hidden
bindkey '^F' _fzf_file_no_hidden
