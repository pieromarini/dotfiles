vim.cmd [[
try
	colorscheme everblush
catch /^Vim\%((\a\+)\)\=:E185/
	set background=dark
	colorscheme default
endtry
]]
