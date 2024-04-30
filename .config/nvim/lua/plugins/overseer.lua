return {
	"stevearc/overseer.nvim",
	opts = {},
	dependencies = {
		"rcarriga/nvim-notify",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local overseer = require("overseer")
		overseer.setup({
			strategy = "toggleterm"
		})
		-- Use overseer json decoder because it supports JSON5
		require("dap.ext.vscode").json_decode = require("overseer.json").decode
	end,
}
