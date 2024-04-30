return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
    vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
		vim.keymap.set("n", "<leader>gj", "<cmd>:Gitsigns next_hunk<CR>", { desc = "Next Hunk" })
		vim.keymap.set("n", "<leader>gk", "<cmd>:Gitsigns prev_hunk<CR>", { desc = "Prev Hunk" })
		vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
		vim.keymap.set("n", "<leader>gr", "<cmd>:Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
		vim.keymap.set("n", "<leader>gR", "<cmd>:Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })
		vim.keymap.set("n", "<leader>gs", "<cmd>:Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
		vim.keymap.set("n", "<leader>gu", "<cmd>:Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage Hunk" })
  end,
}
