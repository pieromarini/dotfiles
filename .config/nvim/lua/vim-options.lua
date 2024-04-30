vim.g.mapleader = " "
vim.g.background = "dark"

vim.opt.number = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.hidden = true
vim.opt.hlsearch = true

vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.ruler = false
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoread = true

vim.wo.signcolumn = "yes"

vim.opt.updatetime = 150
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Move lines up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical :resize -2<CR>", { silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical :resize +2<CR>", { silent = true, desc = "Increase window width" })

-- Buffers navigate
vim.keymap.set("n", "<Tab>", ":bn<CR>", { silent = true, desc = "next tab" })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { silent = true, desc = "prev tab" })

-- Buffer delete
vim.keymap.set("n", "<leader>c", "<cmd>Bdelete<CR>", { desc = "Delete current buffer" })

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprev<CR>")
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist)

vim.keymap.set("n", "<F3>", ":ClangdSwitchSourceHeader<CR>", { silent = true })

-- DAP
vim.keymap.set({ "n", "t" }, "<F5>", function() require("dap").continue() end, { silent = true })
vim.keymap.set({ "n", "t" }, "<F6>", function() require("dap").step_over() end, { silent = true })
vim.keymap.set({ "n", "t" }, "<F7>", function() require("dap").step_into() end, { silent = true })
vim.keymap.set({ "n", "t" }, "<F8>", function() require("dap").step_out() end, { silent = true })
vim.keymap.set({ "n", "t" }, "<F11>", function() require("dap").toggle_breakpoint() end, { silent = true })

vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.up()<CR>", { desc = "Stack up" })
vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.down()<CR>", { desc = "Stack down" })
vim.keymap.set("n", "<leader>dn", "<cmd>lua require'dap'.run_to_cursor()<CR>", { desc = "Run To Cursor" })
vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Terminate" })
vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<CR>", { desc = "Stack frames" })
vim.keymap.set("n", "<leader>db", "<cmd>Telescope dap list_breakpoints<CR>", { desc = "All breakpoints" })
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>", { desc = "View current scope" })
