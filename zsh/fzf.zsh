source <(fzf --zsh)
export FZF_CTRL_T_COMMAND="fd --hidden --strip-cwd-prefix"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix"
