vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = args.buf })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { buffer = args.buf })
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = args.buf })
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true, noremap = true, desc = 'toggle signature' })

		vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = args.buf })
	end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Set proper filetype for GLSL extensions
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.frag,*.vert,*.comp,*.geo",
  command = "setlocal filetype=glsl",
})
