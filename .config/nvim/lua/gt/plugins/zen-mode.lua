return {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
	config = function()
		require("zen-mode").setup({
			window = {
				width = 0.75,
			},
		})
		vim.keymap.set("n", "<leader>zz", "<CMD>ZenMode<CR>", { desc = "Zen mode" })
	end,
}
