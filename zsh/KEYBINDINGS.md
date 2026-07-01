# Keybindings

Overview of every keybinding active in the zsh setup — split by where each one
comes from, since that matters if you ever want to change or remove one.

## Custom (`bindings.zsh`)

> **Load-order change:** `zsh-vi-mode` wipes all existing keybindings when it
> initializes, so plain `bindkey` calls sitting at the top level of
> `bindings.zsh` would get silently erased. To survive that, every custom
> binding now lives inside the `zvm_after_init()` hook, which `zsh-vi-mode`
> calls once its own init (and reset) is done. **Any new custom binding you
> add must go inside this function, not outside it**, or it'll get wiped.

| Key      | Action                                                              |
| -------- | ------------------------------------------------------------------- |
| `Ctrl+→` | Move forward one word                                               |
| `Ctrl+←` | Move backward one word                                              |
| `Ctrl+F` | Open fzf file picker, hidden files excluded (`_fzf_file_no_hidden`) |
| `Ctrl+\` | Toggle autosuggestions on/off (handy for screen recordings)         |
| `↑`      | History search backward, filtered by substring                      |
| `↓`      | History search forward, filtered by substring                       |

> ⚠️ **Check this:** `Ctrl+F` calls a widget named `_fzf_file_no_hidden`.
> That widget isn't defined anywhere in `fzf.zsh` as it stands (`fzf.zsh`
> only sets `FZF_CTRL_T_COMMAND`, `FZF_CTRL_T_OPTS`, and
> `FZF_ALT_C_COMMAND` — no custom widget function). If `Ctrl+F` doesn't do
> anything, that's why — you'll need to add something like:
>
> ```bash
> _fzf_file_no_hidden() {
>   local file
>   file=$(fd --type=f | fzf --preview 'bat --color=always {}')
>   [[ -n $file ]] && LBUFFER+="$file"
>   zle redisplay
> }
> zle -N _fzf_file_no_hidden
> ```
>
> to `fzf.zsh` (or wherever you keep zle widget definitions) for this to work.

Cursor shape and highlight styling are also configured here (not a
keybinding, but lives in the same file):

- Insert mode → beam cursor, Normal/Visual mode → block cursor
- Command-mode line highlighting is disabled (`ZVM_VI_HIGHLIGHT_*=none`)

## fzf (`fzf.zsh`)

| Key      | Action                                                                           |
| -------- | -------------------------------------------------------------------------------- |
| `Ctrl+R` | Fuzzy search command history                                                     |
| `Ctrl+T` | Fuzzy find files (including hidden, via `fd --hidden`) and insert path at cursor |
| `Alt+C`  | Fuzzy find a directory (including hidden) and `cd` into it                       |

All show a `bat`-powered preview pane as configured in `fzf.zsh`. `fzf.zsh`
still loads after `bindings.zsh` in `.zshrc`, so `Ctrl+R` here is the one
that wins if anything else ever tries to rebind it.

## History substring search

Now bound directly via `zvm_after_init()` in `bindings.zsh` (see above) —
`Ctrl+F`'s aside, `↑`/`↓` do substring-filtered history search instead of
zsh's plain prefix-only recall.

## Vi mode (`zsh-vi-mode` plugin)

The shell starts in **insert mode** (normal typing). Press `Esc` to drop into
**normal mode** for vi-style editing, same as vim:

| Key             | Mode            | Action                                                                                              |
| --------------- | --------------- | --------------------------------------------------------------------------------------------------- |
| `Esc`           | insert → normal | Switch to normal mode                                                                               |
| `i`             | normal → insert | Insert before cursor                                                                                |
| `a`             | normal → insert | Insert after cursor                                                                                 |
| `A`             | normal → insert | Insert at end of line                                                                               |
| `h` `j` `k` `l` | normal          | Move left / history-down / history-up / right _(j/k behavior depends on plugin config — see below)_ |
| `0` / `$`       | normal          | Jump to start / end of line                                                                         |
| `dd`            | normal          | Delete line                                                                                         |
| `dw`            | normal          | Delete word                                                                                         |
| `x`             | normal          | Delete character under cursor                                                                       |
| `.`             | normal          | Repeat last change                                                                                  |
| `v`             | normal          | Visual mode (select text)                                                                           |
| `/`             | normal          | Search command line buffer                                                                          |

> `zsh-vi-mode` mostly mirrors real vim's normal-mode bindings, so anything
> that feels muscle-memory from Neovim will likely work here too. Full list:
> <https://github.com/jeffreytse/zsh-vi-mode#key-bindings>

## Notes for future edits

- All custom bindings live in **`bindings.zsh`**, inside `zvm_after_init()`.
  Add new ones there with `bindkey '<key>' <widget-name>` — putting them
  outside the hook means `zsh-vi-mode` will wipe them on init.
- If you add a plugin that defines its own keybindings and something stops
  working, check **load order** in `.zshrc` first — whichever file sources
  last wins on a given key (e.g. `fzf.zsh` loading after `bindings.zsh` is
  why `Ctrl+R` ends up as the fzf widget, not anything set earlier).
- To find the escape sequence for a key you want to bind, run `cat -v` in the
  terminal and press the key combo — it'll print the raw sequence to map in
  `bindkey`.
- If you bind a key to a custom widget (like `Ctrl+F` above), remember it
  needs both a function definition **and** a `zle -N <widget-name>` line to
  register it with zle before `bindkey` can reference it.
