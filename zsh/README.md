# zsh config

Minimal, framework-free zsh setup. No Oh My Zsh, no plugin manager — everything
is plain shell files sourced from `.zshrc`, with plugins cloned directly from
GitHub by a small helper function.

## Layout

```
~/.zshenv                    # always loaded by zsh (even non-interactive).
                              # Sets ZDOTDIR to point zsh at the config below.
~/.config/zsh/
├── .zshrc                   # entry point — history, completion, sources everything else
├── aliases.zsh              # modern CLI tool aliases (eza, bat, fd, rg)
├── plugins.zsh              # clones + sources plugins (no plugin manager)
├── prompt.zsh                # prompt init (Starship or p10k)
├── bindings.zsh              # custom keybindings
├── fzf.zsh                   # fzf setup + preview config
└── plugins/                  # git clones live here (gitignored, not hand-edited)
```

`$ZDOTDIR` = `~/.config/zsh`, set in `~/.zshenv`. That's why all the other
files live there instead of directly in `$HOME`.

## Adding a plugin

Open `plugins.zsh` and add one line calling `_zplug`, then source it:

```bash
_zplug "author/repo-name" "local-folder-name" "entry-file.zsh"

source "$ZPLUGDIR/local-folder-name/entry-file.zsh"
```

- `author/repo-name` — the GitHub repo, as in `github.com/author/repo-name`
- `local-folder-name` — whatever you want it called under `plugins/`
- `entry-file.zsh` — the file inside the repo you actually `source`. Check the
  plugin's README for this if it's not obvious from the repo's top-level files.

**Ordering matters**: `fast-syntax-highlighting` (or any syntax-highlighting
plugin) must always be sourced **last**. It wraps widgets other plugins
define, so if something else loads after it, syntax highlighting silently
won't apply to that plugin's inserted text.

To remove a plugin: delete its `_zplug` line, delete its `source` line, and
`rm -rf ~/.config/zsh/plugins/local-folder-name`.

To force a plugin to re-clone (e.g. update to latest, or fix a broken clone):
```bash
rm -rf ~/.config/zsh/plugins/local-folder-name
exec zsh
```
`_zplug` checks for the entry file, not just the folder, so a missing or
partial clone will always retry automatically on next shell start — you don't
need to worry about this getting stuck in a broken state.

## Changing settings

| Want to change... | Edit this file |
|---|---|
| History size, completion behavior | `.zshrc` |
| `ls`/`cat`/`grep` style aliases | `aliases.zsh` |
| Prompt look/theme | `prompt.zsh` (and `starship.toml` if using Starship) |
| Keybindings (Ctrl+arrows, toggles, etc.) | `bindings.zsh` |
| fzf preview command, colors, fuzzy-find scope | `fzf.zsh` |
| Env vars, PATH | `~/.zshenv` |

## Swapping the prompt (Starship ↔ Powerlevel10k)

**Currently using:** Starship.

To switch to p10k, replace the contents of `prompt.zsh` with:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
```
and `brew install powerlevel10k` (and `brew uninstall starship` if you don't
need it elsewhere). To go back, restore:
```bash
eval "$(starship init zsh)"
```

## Dependencies

```bash
brew install zsh neovim eza bat fd fzf zoxide starship ripgrep
```

## Troubleshooting

- **`no such file or directory` on a plugin source line** → the clone didn't
  finish. Run `rm -rf ~/.config/zsh/plugins && exec zsh` to force a clean
  re-clone of everything.
- **`unhandled ZLE widget` warnings from fast-syntax-highlighting** → almost
  always means a completion plugin (like zsh-autocomplete) is defining custom
  widgets fast-syntax-highlighting doesn't know about. Cosmetic, not fatal —
  but if it bothers you, check what's loaded before it in `plugins.zsh`.
- **p10k config not sourcing / shell throws a math error on startup** → check
  for stray references to `ZSH_HIGHLIGHT_STYLES` (that's the
  `zsh-syntax-highlighting` array, not `fast-syntax-highlighting`'s). This
  config uses `FAST_HIGHLIGHT_STYLES` instead if you ever add style overrides.
