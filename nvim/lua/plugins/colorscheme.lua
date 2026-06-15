return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccinuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
