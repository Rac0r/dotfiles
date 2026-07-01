# History
HISTFILE="XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY APPEND_HISTORY

# Completion
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

for f in aliases plugins prompt bindings fzf; do
  [[ -f "$ZDOTDIR/$f.zsh" ]] && source "$ZDOTDIR/$f.zsh"
done
eval "$(zoxide init zsh)"
