-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local autocmd = vim.api.nvim_create_autocmd

-- Create group
local function augroup(name)
	return vim.api.nvim_create_augroup("gt_" .. name, { clear = true })
end

local general = augroup("general")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = general,
	callback = function() end,
	vim.highlight.on_yank(),
})

autocmd("BufEnter", {
	desc = "Disable New Line Comment",
	group = general,
	callback = function()
		vim.opt.formatoptions:remove({ "o" })
	end,
})

autocmd({ "BufEnter", "BufNewFile" }, {
	callback = function()
		vim.o.showtabline = 0
	end,
	group = general,
	desc = "Disable Tabline",
})

autocmd("ColorScheme", {
	desc = "Reverse Selection Color",
	group = general,
	callback = function()
		vim.api.nvim_set_hl(0, "Visual", { nil, nil, reverse = true })
	end,
})
