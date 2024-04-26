return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", "telescope-fzf-native.nvim" },
		config = function()
			local ts = require("telescope")
			ts.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					}
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>o", builtin.find_files, {})
			vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>s", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>m", builtin.marks, {})
			vim.keymap.set("n", "<leader>i", builtin.quickfix, {})

			ts.load_extension("ui-select")
			ts.load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
	},
}
