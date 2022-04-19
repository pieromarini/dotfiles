vim.cmd [[
try
	if has('termguicolors')
		set termguicolors
	endif

	let g:sonokai_style = 'andromeda'
	let g:sonokai_enable_italic = 0
	let g:sonokai_disable_italic_comment = 1
	let g:sonokai_transparent_background = 1
	let g:sonokai_current_word = 'bold'
	let g:sonokai_diagnostic_line_highlight = 0
	let g:sonokai_sign_column_background = 'none'

	set background=dark

	colorscheme sonokai
catch /^Vim\%((\a\+)\)\=:E185/
	set background=dark
	colorscheme default
endtry
]]
