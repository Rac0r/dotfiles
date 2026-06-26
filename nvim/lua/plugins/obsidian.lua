return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    ui = {
      enable = false,
    }
    note_id_func = function(title)
      return title -- Dateiname = Titel
    end,
    workspaces = {
      {
        name = "personal",
        path = "~/Library/CloudStorage/OneDrive-Personal/Documents/Notes/personal",
      },
      {
        name = "work",
        path = "~/Library/CloudStorage/OneDrive-Personal/Documents/Notes/work",
      },
    },
  },
}
