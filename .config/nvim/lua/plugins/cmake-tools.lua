return {
	"Civitasv/cmake-tools.nvim",
	opts = {
		cmake_command = "cmake",
		ctest_command = "ctest",
		cmake_regenerate_on_save = true,
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
		cmake_build_options = {},
		cmake_build_directory = "build/${variant:buildType}",
		cmake_soft_link_compile_commands = true,
		cmake_compile_commands_from_lsp = false,
		cmake_kits_path = nil,
		cmake_variants_message = {
			short = { show = true },
			long = { show = true, max_length = 40 },
		},
		cmake_dap_configuration = {
			name = "cpp",
			type = "lldb",
			request = "launch",
			stopOnEntry = false,
			runInTerminal = true,
			console = "integratedTerminal",
		},
		cmake_executor = {
			name = "toggleterm",
			opts = {},
			default_opts = {
				toggleterm = {
					direction = "float",
					close_on_exit = true,
					auto_scroll = true,
				},
			},
		},
		cmake_runner = {
			name = "overseer",
			opts = {},
			default_opts = {
				overseer = {
					new_task_opts = {
						strategy = {
							"toggleterm",
							direction = "float",
							auto_scroll = true,
							quit_on_exit = "success",
						},
					},
					on_new_task = function(task) end,
				},
			},
		},
		cmake_notifications = {
			runner = { enabled = true },
			executor = { enabled = true },
			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
			refresh_rate_ms = 100, -- how often to iterate icons
		},
	},
	init = function ()
		vim.keymap.set("n", "<F4>", ":CMakeRun<CR>")
	end
}
