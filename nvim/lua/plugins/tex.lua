return {
  {
    "lervag/vimtex",
    init = function()
      -- WSLg: start Zathura under X11 so vimtex (via xdotool) can find its window
      if vim.env.WSL_DISTRO_NAME then
        vim.env.GDK_BACKEND = "x11"
      end

      vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura_simple"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_open_on_warning = 0 -- only pop up the error list on errors
    end,
  },
}
