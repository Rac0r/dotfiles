-- Vault locations differ per machine: list every candidate root here and only
-- the ones that exist on the current machine become workspaces.
local roots = {
  "~/Library/CloudStorage/OneDrive-Personal/Documents/Notes", -- macOS
  "/mnt/c/Users/" .. (vim.env.WIN_USER or "jonas") .. "/OneDrive/Documents/Notes", -- WSL
}

local workspaces = {}
for _, root in ipairs(roots) do
  local dir = vim.fn.expand(root)
  if vim.fn.isdirectory(dir) == 1 then
    for _, name in ipairs({ "personal", "work" }) do
      if vim.fn.isdirectory(dir .. "/" .. name) == 1 then
        table.insert(workspaces, { name = name, path = dir .. "/" .. name })
      end
    end
    break
  end
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  cond = #workspaces > 0, -- skip the plugin on machines without the vault
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    ui = {
      enable = false,
    },
    note_id_func = function(title)
      return title -- Dateiname = Titel
    end,
    workspaces = workspaces,
  },
}
