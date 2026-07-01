ZPLUGDIR="$ZDOTDIR/plugins"
mkdir -p "$ZPLUGDIR"

# Clones a plugin repo if its entry-point file isn't present yet.
# Checking for the entry file (not just the directory) means a failed or
# partial clone gets retried on the next shell launch instead of leaving
# a permanently broken empty folder behind.
_zplug() {
  local repo=$1 name=$2 entry=$3
  if [[ ! -f "$ZPLUGDIR/$name/$entry" ]]; then
    rm -rf "$ZPLUGDIR/$name"
    git clone --depth=1 "https://github.com/$repo" "$ZPLUGDIR/$name"
  fi
}

_zplug "zsh-users/zsh-autosuggestions" "zsh-autosuggestions" "zsh-autosuggestions.zsh"
_zplug "zsh-users/zsh-history-substring-search" "zsh-history-substring-search" "zsh-history-substring-search.zsh"
_zplug "jeffreytse/zsh-vi-mode" "zsh-vi-mode" "zsh-vi-mode.plugin.zsh"
_zplug "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"

source "$ZPLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZPLUGDIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$ZPLUGDIR/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$ZPLUGDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"  # must load last
