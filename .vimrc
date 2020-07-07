" Vim 8 Config file
" Last Edit: 01 Jul 2020
" Author: Piero Marini


""" Plugin List """ 

" Coc.Nvim (Auto-Complete)
" NerdTree (Directory Tree)
" Emmet-Vim (Html/Css Fast Typing)
" Vim-Fugitive (Git)
" Vim-Vue (Syntax Highlighting for .vue files)
" Vim-Tmux-Navigator (Integration for tmux panels with vim splits)
" Vim-GLSL
" Fzf
" UltiSnips

""" End Plugin List """

set encoding=utf-8

filetype on
filetype plugin on
filetype indent on
syntax on

let python_highlight_all=1

" Adding Fzf & UltiSnips to runtime path.
set rtp+=~/.fzf
set rtp+=~/.vim/pack/marini/start/ultisnips

set pyxversion=3

set updatetime=300

set shortmess+=c

set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set smartindent
set hidden

set scrolloff=6

set number
set cursorline

set foldenable
set foldmethod=indent
set foldlevel=99
set foldlevelstart=10
set foldnestmax=10

set hlsearch
set incsearch

set lazyredraw

set ruler
set showcmd

set splitbelow
set noswapfile

set wildmenu
set nowritebackup

" Terminal Mode
set termwinsize=12x191


"""" START Mappings """"

" NO.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nmap Q :wq<CR>

let mapleader = ","

" Splits Resizing.
nnoremap <silent> <Leader>= <C-w>=
nnoremap <silent> <Leader>+ :exe "resize +10"<CR>
nnoremap <silent> <Leader>- :exe "resize -10"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>> :exe "vertical resize -10"<CR>

nmap <C-N> :NERDTreeToggle<CR>

nmap <Leader><Space> :nohlsearch<CR>

" BOL / EOL swap. Also spanish keyboard '^' too far away.
" Normal Remap because I'll use this for other commands.
noremap $ ^
noremap & $
noremap ^ &

" Replace under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Copy Paste from system Clipboard
noremap <C-c> "+y
noremap <C-v> "+p
nnoremap <Leader>p "*p
nnoremap <Leader>y "*y

" Visual Block Select
nnoremap <Leader>v <C-v>

" FZF Keybindings
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :Commits<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>o :FZF<CR>

nnoremap <Leader>g :Grep 

"""" END MAPPINGS """"

" grep uses ripgrep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" custom command to populate and open the quickfix list (if results exist)
command! -bar -nargs=1 Grep silent grep <q-args> | redraw! | cw

nnoremap [g :cp<CR>
nnoremap ]g :cn<CR>

"""" UltiSnips """"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsListSnippets="<c-0>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir=$HOME . "/.vim/snippets/ultisnips"
let g:UltiSnipsSnippetDirectories=[$HOME . "/.vim/snippets/ultisnips"]

"""" FZF """"
let g:fzf_action = {
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-f': 'split',
  \ 'ctrl-t': 'tab split',
  \ 'return': 'e'}

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"""" CoC.nvim """"
" Use tab for trigger completion
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? "\<C-n>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif"

" Navigate diagnostics
nmap <silent> <Leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>m <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <Leader>t <Plug>(coc-definition)
nmap <silent> <Leader>d <Plug>(coc-type-definition)
nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>l <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
autocmd FileType c,cpp nnoremap <F4> :CocCommand clangd.switchSourceHeader<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" START StatusLine

let g:currentmode={
			\ 'n'  : 'Normal ',
			\ 'no' : 'N·Operator Pending ',
			\ 'v'  : 'Visual ',
			\ 'V'  : 'V·Line ',
			\ '' : 'V·Block ',
			\ 's'  : 'Select ',
			\ 'S'  : 'S·Line ',
			\ '' : 'S·Block ',
			\ 'i'  : 'Insert ',
			\ 'R'  : 'Replace ',
			\ 'Rv' : 'V·Replace ',
			\ 'c'  : 'Command ',
			\ 'cv' : 'Vim Ex ',
			\ 'ce' : 'Ex ',
			\ 'r'  : 'Prompt ',
			\ 'rm' : 'More ',
			\ 'r?' : 'Confirm ',
			\ '!'  : 'Shell ',
			\ 't'  : 'Terminal '
			\}

function! ReadOnly()
	if &readonly || !&modifiable
		return ''
	else
		return ''
endfunction

function! GitInfo()
	let git = fugitive#head()
	if git != ''
		return ' '.fugitive#head()
	else
		return ''
endfunction

" Automatically change the statusline color depending on mode
function! StatuslineUpdate()
	let m = mode()
	if (m =~# '\v(n|no)')
		exe 'hi! User1 ctermbg=39 ctermfg=231'
		exe 'hi! User7 ctermbg=246 ctermfg=39'
		exe 'hi! User9 ctermbg=8 ctermfg=39'
	elseif (m =~# '\v(v|V)' || g:currentmode[m] ==# 'V·Block ' || get(g:currentmode, m, '') ==# 't')
		exe 'hi! User1 ctermbg=125 ctermfg=231'
		exe 'hi! User7 ctermbg=246 ctermfg=125'
		exe 'hi! User9 ctermbg=8 ctermfg=125'
	elseif (m ==# 'i')
		exe 'hi! User1 ctermbg=136 ctermfg=231'
		exe 'hi! User7 ctermbg=246 ctermfg=136'
		exe 'hi! User9 ctermbg=8 ctermfg=136'
	else
		exe 'hi! User1 ctermbg=160 ctermfg=231'
		exe 'hi! User7 ctermbg=246 ctermfg=160'
		exe 'hi! User9 ctermbg=8 ctermfg=160'
	endif

	return ''
endfunction

function! StatusDiagnostic() abort
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
	let msgs = []
	if get(info, 'error', 0)
		call add(msgs, 'E' . info['error'])
	endif
	if get(info, 'warning', 0)
		call add(msgs, 'W' . info['warning'])
	endif
	return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

set laststatus=2
set statusline=
set statusline+=%{StatuslineUpdate()}                      " Changing the statusline color
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}%9* " Current mode
set statusline+=%4*\ %{GitInfo()}                          " Git
set statusline+=%2*\ [%n]                                  " buffer
set statusline+=%2*\ %f\ %{ReadOnly()}\ %m\ %w\            " File+path

set statusline+=%2*\ %=                                    " Space

set statusline+=%8*%5*\ %y                                " FileType
set statusline+=%5*\ %{(&fenc!=''?&fenc:&enc)}             " Encoding & Fileformat
set statusline+=%6*\ %{StatusDiagnostic()}\ 			   " CocStatus
set statusline+=%7*%1*%3p%%(%L)\ ☰\ %l:\ %2c\             " %(Total) Line: Col

set background=dark
colorscheme solarized

hi Normal ctermbg=NONE

hi User1 ctermfg=231 ctermbg=39 
hi User2 ctermfg=231 ctermbg=8
hi User4 ctermfg=160 ctermbg=8
hi User5 ctermfg=231 ctermbg=246
hi User6 ctermfg=160 ctermbg=246

" Used for rendering the separators correctly.
hi User7 ctermfg=39 ctermbg=246
hi User8 ctermfg=246 ctermbg=8
hi User9 ctermfg=39 ctermbg=8

" END STATUS LINE
"

""" GLSL Syntax Highlightin """
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl


""" EMMET VIM """
let g:user_emmet_leader_key= '<C-y>'

""" END EMMET VIM """

"""" SNIPPETS """"

autocmd FileType tex,plaintex nnoremap <Leader>0 :-1read $HOME/.vim/snippets/t.tex<CR>3jf{a
autocmd FileType make nnoremap <Leader>0 :-1read $HOME/.vim/snippets/Makefile<CR>
autocmd FileType html nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.html<CR>3jf>a
autocmd FileType python nnoremap <Leader>0 :-1read $HOME/.vim/snippets/main.py<CR>o
autocmd FileType cpp nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.cpp<CR>2jo
autocmd FileType c nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.c<CR>2jo

autocmd FileType vue nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.vue<CR>7jf'a

"""" END SNIPPETS """"

"""" EXECUTE/COMPILE KeyBindings """"

autocmd FileType cpp nnoremap <F10> :w <bar> exec '!g++ -std=c++17 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType c nnoremap <F10> :w <bar> exec '!gcc -lm '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

autocmd FileType python nnoremap <F9> :w <bar> :term python -i %<CR>
autocmd FileType python nnoremap <F10> :w <bar> :term python %<CR>

autocmd FileType sh nnoremap <F10> :w <bar> :term bash %<CR>

autocmd FileType tex,plaintex nnoremap <buffer> <F9> :exec '!pdflatex --shell-escape' shellescape(@%, 1)<CR>
autocmd FileType tex,plaintex nnoremap <buffer> <F10> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

autocmd FileType markdown nnoremap <F10> :w <bar> exec '!grip '. shellescape('%').' -b --quiet &'<CR>

"""" END SCRIPT EXECUTION/COMPILING """"


"""" SURROUND """"
nnoremap <Leader>s :<C-u>call SurroundWord()<CR>

function! SurroundWord()
	let c=nr2char(getchar())
	exec "normal viwo\ei".c.c."\eea".c.c."\e"
endf
"""" End SURROUND """"

"""" PRETTY OUTPUTS """"
function! PrettyXML()
	" save the filetype so we can restore it later
	let l:origft = &ft
	set ft=
	" delete the xml header if it exists. This will
	" permit us to surround the document with fake tags
	" without creating invalid xml.
	1s/<?xml .*?>//e
	" insert fake tags around the entire document.
	" This will permit us to pretty-format excerpts of
	" XML that may contain multiple top-level elements.
	0put ='<PrettyXML>'
	$put ='</PrettyXML>'
	silent %!xmllint --format -
	" xmllint will insert an <?xml?> header. it's easy enough to delete
	" if you don't want it.
	" delete the fake tags
	2d
	$d
	" restore the 'normal' indentation, which is one extra level
	" too deep due to the extra tags we wrapped around the document.
	silent %<
	" back to home
	1
	" restore the filetype
	exe "set ft=" . l:origft
	" Indent properly.
	normal gg=G
endfunction

function! PrettyJSON()
	:%!python -c "import json, sys, ast; print( json.dumps(ast.literal_eval(''.join([x for x in sys.stdin])), indent=4) )"
endfunction

command! FormatXml call PrettyXML()
command! FormatJson call PrettyJSON() 
"""" END PRETTY OUTPUTS """"

"""" C++ Better Highlighting. """"
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error = 1
let g:cpp_simple_highlight = 1

""" Auto Closing Brackets '[]' and Parenthesis '()' """
""" This doesn't write the closing character if it's already present. """
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"


""" Auto Closing Single and Double Quotes """
""" This doesn't write the closing character if it's already present. """
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap '' '
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? '<Right>' : '""<Left>'
inoremap "" "

""" Auto Closing for Braces '{}' """
""" Insert closing braces and check if it is the last character on the line. """
""" If TRUE it inserts the closing brace and positions you inside the braces. """
""" If FALSE it inserts the closing brace 2 lines below and positions you inside the code block. """
""" Doesn't insert brace if next character is a brace. """
function! ConditionalPairMap(open, close)
	let line = getline('.')
	let column = col('.')
	if column < col('$') || stridx(line, a:close, column + 1) != -1
		return a:open . a:close . "\<Left>"
	else
		return a:open ."\<CR>" . a:close . "\<Esc>\O"
	endif
endf

inoremap <expr> {<CR> ConditionalPairMap('{', '}')
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap { {}<Left>
inoremap {{ {

let g:vue_pre_processors = 'detect_on_enter'
""" Useful for Vue Template files. 
autocmd FileType vue inoremap {{<CR> {{ }}<Left><Left><Left>


""" Search for 'Last Edit:' and add the current date after. """
""" 'Last Edit:' can have up to 10 characters before (they are retained). """
""" Restores cursor and window position """
function! LastModified()
	if &modified
		let save_cursor = getpos(".")
		let n = min([10, line("$")])
		keepjumps exe '1,' . n . 's#^\(.\{,10}Last Edit: \).*#\1' .
					\ strftime('%d %b %Y') . '#e'
		call histdel('search', -1)
		call setpos('.', save_cursor)
	endif
endf

autocmd BufWritePre .vimrc,.tmux.conf,.zshrc call LastModified()

packloadall
silent! helptags ALL
