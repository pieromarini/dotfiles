" Vim 8 Config file
" Last Edit: 20 Jul 2021
" Author: Piero Marini


""" Plugin List """ 

" Coc.Nvim (Auto-Complete)
" NerdTree (Directory Tree)
" Emmet-Vim (Html/Css Fast Typing)
" Vim-Fugitive (Git)
" Vim-Vue (Syntax Highlighting for .vue files)
" Vim-Tmux-Navigator
" Vim-GLSL
" Fzf.vim (Fuzzy search)
" VimTex

""" End Plugin List """

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set encoding=utf-8

set termguicolors

filetype plugin indent on
syntax on

let python_highlight_all=1

" Add Fzf to runtime path.
set rtp+=~/.fzf

set pyxversion=3

set updatetime=300

set shortmess+=c

set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set smartindent
set backspace=indent,eol,start
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

"""" END MAPPINGS """"

" grep uses ripgrep if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

nnoremap [g :cp<CR>
nnoremap ]g :cn<CR>

"""" FZF """"
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> <Leader>o    :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> <Leader>b    :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> <Leader>/    :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>

nnoremap          <Leader>g    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', ', 'g'), '/', '\\/', 'g')<CR>"

nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]gb    :<C-u>CocCommand fzf-preview.GitBranches<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>

nnoremap <silent> [fzf-p]gc    :<C-u>CocCommand fzf-preview.Changes<CR>

nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>

nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>"
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \	  fzf#vim#with_preview(), <bang>0)


let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

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

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Navigate diagnostics
nmap <silent> <Leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>m <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <Leader>t <Plug>(coc-definition)
nmap <silent> <Leader>d <Plug>(coc-type-definition)
nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>l <Plug>(coc-references)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

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
		return ' '.git
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
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}     " Current mode
set statusline+=%4*\ %{GitInfo()}						   " Git
set statusline+=%2*\ [%n]                                  " buffer
set statusline+=%2*\ %f\ %{ReadOnly()}\ %m\ %w\            " File+path

set statusline+=%2*\ %=                                    " Space

set statusline+=%5*\ %y                                    " FileType
set statusline+=%5*\ %{(&fenc!=''?&fenc:&enc)}             " Encoding & Fileformat
set statusline+=%5*\ %{StatusDiagnostic()}\ 			   " CocStatus
set statusline+=%5*%3p%%(%L)\                               " %(Total) 
set statusline+=%1*\ %l:\ %2c\ 			                   " Line: Col


" Colorscheme
let g:sonokai_style = 'andromeda'

let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1
let g:sonokai_current_word = 'bold'
let g:sonokai_diagnostic_line_highlight = 0
let g:sonokai_sign_column_background = 'none'

set background=dark

colorscheme sonokai


""" GLSL Syntax Highlightin """
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

""" EMMET VIM """
let g:user_emmet_leader_key= '<C-y>'
""" END EMMET VIM """

"""" CODE BOILERPLATES """"

autocmd FileType tex,plaintex nnoremap <Leader>0 :-1read $HOME/.vim/snippets/t.tex<CR>3jf{a
autocmd FileType make nnoremap <Leader>0 :-1read $HOME/.vim/snippets/Makefile<CR>
autocmd FileType html nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.html<CR>3jf>a
autocmd FileType python nnoremap <Leader>0 :-1read $HOME/.vim/snippets/main.py<CR>o
autocmd FileType cpp nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.cpp<CR>2jo
autocmd FileType c nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.c<CR>2jo

autocmd FileType vue nnoremap <Leader>0 :-1read $HOME/.vim/snippets/skeleton.vue<CR>7jf'a

"""" END CODE BOILERPLATES """"

"""" EXECUTE/COMPILE KeyBindings """"

autocmd FileType cpp nnoremap <F10> :w <bar> exec '!g++ -std=c++17 '.shellescape('%').' -g -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType c nnoremap <F10> :w <bar> exec '!gcc -lm '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

autocmd FileType python nnoremap <F9> :w <bar> :term python -i %<CR>
autocmd FileType python nnoremap <F10> :w <bar> :term python %<CR>

autocmd FileType sh nnoremap <F10> :w <bar> :term bash %<CR>

autocmd FileType tex,plaintex nnoremap <buffer> <F9> :exec '!pdflatex --shell-escape' shellescape(@%, 1)<CR>
autocmd FileType tex,plaintex nnoremap <buffer> <F10> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

if executable('grip')
  autocmd FileType markdown nnoremap <silent> <F10> :exec '!grip -b %'<CR>
endif

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
	let l:origft = &ft
	set ft=
	1s/<?xml .*?>//e
	0put ='<PrettyXML>'
	$put ='</PrettyXML>'
	silent %!xmllint --format -
	2d
	$d
	silent %<
	1
	exe "set ft=" . l:origft
	normal gg=G
endfunction

function! PrettyJSON()
	:%!python -c "import json, sys, ast; print( json.dumps(ast.literal_eval(''.join([x for x in sys.stdin])), indent=4) )"
endfunction

command! FormatXml call PrettyXML()
command! FormatJson call PrettyJSON() 
"""" END PRETTY OUTPUTS """"

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
