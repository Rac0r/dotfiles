# ---------- XDG base directories ---------
export ZDOTDIR="$HOME/.config/zsh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Rust -------------------------
. "$HOME/.cargo/env"

# ---------- Editor -----------------------
export EDITOR="nvim"
export VIsUAL="nvim"

# ---------- Starship ---------------------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
