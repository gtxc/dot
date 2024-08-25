return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	dependencies = { "echasnovski/mini.icons", opts = {} },
	config = function()
		local oil = require("oil")
		oil.setup({
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
				case_insensitive = true,
			},
			keymaps = {
				["<C-d>"] = "actions.preview_scroll_down",
				["<C-u>"] = "actions.preview_scroll_up",
				["<C-y>"] = "actions.yank_entry",
				["<A-CR>"] = {
					desc = "Show size",
					callback = function()
						local path = vim.api.nvim_buf_get_name(0)
						local ce = oil.get_cursor_entry()
						if ce == nil then
							return
						end
						path = string.gsub(path, "oil://", "")
						local size = vim.fn.system("du -sh " .. path .. ce.name)
                        vim.notify(size, "info", { title = "Size" })
					end,
				},
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = "Open parent directory" })
	end,
}
