# History
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY APPEND_HISTORY

# Completion
autoload -Uz compinit
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

for f in aliases plugins prompt bindings fzf; do
  [[ -f "$ZDOTDIR/$f.zsh" ]] && source "$ZDOTDIR/$f.zsh"
done
eval "$(zoxide init zsh)"

# Machine-specific overrides (not in the repo), e.g. WSL helpers
[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"

. "$HOME/.local/share/../bin/env"
