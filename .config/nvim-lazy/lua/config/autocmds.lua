-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

-- Create group
local function augroup(name)
  return vim.api.nvim_create_augroup("gt_" .. name, { clear = true })
end

local general = augroup("general")

-- autocmd({ "BufEnter", "BufNewFile" }, { callback = function()
--   end,
--     vim.o.showtabline = 0
--   group = general,
--   desc = "Disable Tabline",
-- })

autocmd("User", {
  callback = function()
    pcall(vim.cmd.AlphaRedraw)
  end,
  group = general,
  desc = "redraw alpha",
})

autocmd("ColorScheme", {
  desc = "Reverse Selection Color",
  group = general,
  callback = function()
    vim.api.nvim_set_hl(0, "Visual", { nil, nil, reverse = true })
  end,
})
