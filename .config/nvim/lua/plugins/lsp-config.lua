local util = require("lspconfig.util")
local function get_typescript_server_path(root_dir)
	local global_ts = "/home/piero/.npm/lib/node_modules/typescript/lib"
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local lsp = require("utils.lsp")

			vim.diagnostic.config({
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "single",
					source = "always",
					header = "",
					prefix = "",
				},
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "single",
				focusable = true,
				relative = "cursor",
			})

			lspconfig.volar.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				on_new_config = function(new_config, new_root_dir)
					new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
				end,
			})

			local tsdk = require('mason-registry').get_package('typescript-language-server'):get_install_path() ..
											 '/node_modules/typescript/lib'

			lspconfig.tsserver.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							-- TODO: get current NVM version in use to create this path
							location = "/home/piero/.nvm/versions/node/v18.12.0/lib/node_modules/@vue/typescript-plugin",
							languages = { "javascript", "typescript", "vue" },
						},
					},
					tsserver = {
						path = tsdk
					}
				},
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
			})

			lspconfig.clangd.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
        on_new_config = function(new_config, _)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=bundled",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
			})

			lspconfig.lua_ls.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
							path = "$VIMRUNTIME/lua",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					})
				end,
			})

			lspconfig.cmake.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
			})

			lspconfig.eslint.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
			})

			lspconfig.pyright.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
			})

			lspconfig.glsl_analyzer.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				filetypes = { "glsl", "frag", "vert", "comp", "geom", "tesc", "tese" }
			})
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function() end,
		opts = {
			inlay_hints = {
				inline = false,
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				hint_enable = false,
				handler_opts = { border = "single" },
				max_width = 80,
			})
		end,
	},
}
