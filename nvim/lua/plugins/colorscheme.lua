return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        keywords = { "italic" },
        types = { "italic" },
        parameters = { "italic" },
      },
      integrations = {
        bufferline = true,
        indent_blankline = { enabled = true },
        mini = { enabled = true },
        native_lsp = { enabled = true },
        notify = true,
        snacks = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
