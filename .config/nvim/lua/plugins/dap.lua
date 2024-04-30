return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")

			local dapui = require("dapui")
			local dap_virtual_text_status = require("nvim-dap-virtual-text")

			local file = require("utils.file")
			local codelldb = require("utils.codelldb")

			dap_virtual_text_status.setup({
				enabled = true,                    -- enable this plugin (the default)
				enabled_commands = true,           -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false,  -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true,           -- show stop reason when stopped for exceptions
				commented = true,                  -- prefix virtual text with comment string
				only_first_definition = true,      -- only show virtual text at first definition (if there are multiple)
				all_references = false,            -- show virtual text on all all references of the variable (not only definitions)
				filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
				-- experimental features:
				virt_text_pos = "eol",             -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false,                -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false,                -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil,           -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			})

			dapui.setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = "",
				},
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.25,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "stacks",
								size = 0.25,
							},
							{
								id = "watches",
								size = 0.25,
							},
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.5,
							},
							{
								id = "console",
								size = 0.5,
							},
						},
						position = "bottom",
						size = 10,
					},
				},
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
				render = {
					indent = 1,
					max_value_lines = 100,
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb.codelldb_path,
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.cpp = {
				{
					type = "codelldb",
					request = "launch",
					name = "C++ Debug",
					program = function()
						local cwd = vim.fn.getcwd()
						if file.exists(cwd, "CMakeLists.txt") then
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						else
							local fileName = vim.fn.expand("%:t:r")
							os.execute("mkdir -p " .. "bin")
							local cmd = "!g++ -g % -o bin/" .. fileName
							vim.cmd(cmd)
							return "${fileDirname}/bin/" .. fileName
						end
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					runInTerminal = true,
					console = "integratedTerminal",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.c = {
				{
					type = "codelldb",
					request = "launch",
					name = "C Debug",
					program = function()
						local cwd = vim.fn.getcwd()
						if file.exists(cwd, "CMakeLists.txt") then
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						else
							local fileName = vim.fn.expand("%:t:r")
							os.execute("mkdir -p " .. "bin")
							local cmd = "!gcc -g % -o bin/" .. fileName
							vim.cmd(cmd)
							return "${fileDirname}/bin/" .. fileName
						end
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
}
