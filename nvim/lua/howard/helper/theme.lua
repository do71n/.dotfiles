local M = {}

M.themes = {
  { name = "rose-pine",  label = "Rose Pine" },
  { name = "tokyonight", label = "Tokyo Night" },
  { name = "catppuccin", label = "Catppuccin" },
}

M.current = nil

function M.apply(color)
  M.current = color or "rose-pine"
  vim.cmd.colorscheme(M.current)
end

function M.random()
  local candidates = {}
  for _, t in ipairs(M.themes) do
    if t.name ~= M.current then table.insert(candidates, t) end
  end
  if #candidates == 0 then
    vim.notify("No other themes available", vim.log.levels.WARN)
    return
  end
  local choice = candidates[math.random(#candidates)]
  M.apply(choice.name)
  vim.notify("Theme: " .. choice.name, vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_user_command("Cthm", M.random,
    { nargs = 0, desc = "Randomly switch to a different colorscheme" })
end

return M
