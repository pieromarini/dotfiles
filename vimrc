" Vim 8 Config file
" Last Edit: 06 Apr 2018
" Author: Piero Marini


""" Plugin List """

" ALE (Async Linting) 
" YouCompleteMe (Auto-Complete)
" NerdTree (Directory Tree)
" Emmet-Vim (Html/Css Fast Typing)
" Vim-Fugitive (Git)
" Vim-Vue (Syntax Highlighting for .vue files)
" Vim-Tmux-Navigator (Integration for tmux panels with vim splits)

""" End Plugin List """

syntax on
filetype on
filetype plugin on
filetype indent on

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set hidden

set number
set cursorline
set foldlevelstart=10

set hlsearch
set incsearch

set laststatus=2
set lazyredraw

set ruler
set showcmd

set splitbelow
set noswapfile

set wildmenu
set nowritebackup


"""" START MAPPINGS """"
let mapleader = ","

map <C-N> :NERDTreeToggle<CR>
nmap <Leader>d :YcmShowDetailedDiagnostic<CR>

nmap <Leader><Space> :nohlsearch<CR>

" YCM C#
nmap <F5> :YcmCompleter ReloadSolution<CR>

" BOL / EOL swap. Also spanish keyboard '^' too far away.
nnoremap $ ^
nnoremap & $
nnoremap ^ &

" # of matches for a pattern
nnoremap <Leader>* *<C-O>:%s///gn<CR>

" Replace under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Copy Paste from system Clipboard
noremap <C-c> "+y
noremap <C-v> "+p
nnoremap <Leader>p "*p
nnoremap <Leader>y "*y

" Visual Block Select
nnoremap <Leader>v <C-v>

" Remove trailing whitespace.
" autocmd FileType c,cpp,cs,python,css,html,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e

"""" END MAPPINGS """"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_server_python_interpreter = '/usr/bin/python'

" Turn off YCM linter
let g:ycm_show_diagnostics_ui = 0

" ALE
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \   'css': ['prettier'],
            \   'python': ['autopep8'],
            \}
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'css': ['prettier'],
            \   'python': ['flake8', 'autopep8'],
            \}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1

" Unity Project
let g:ale_cs_mcsc_source = '/home/piero/Development/Unity3D/TheOriginOfEvil/Assets/'
" C# Assemblies for Unity
let g:ale_cs_mcsc_assemblies = ['/opt/Unity3D/Editor/Data/Managed/UnityEditor.dll', '/opt/Unity3D/Editor/Data/Managed/UnityEngine.dll', '/opt/Unity3D/Editor/Data/UnityExtensions/Unity/GUISystem/UnityEngine.UI.dll']


" START StatusLine

function! LinterStatus() abort
    let l:symbol = '●'
    let l:symbol_warning= '⚠'
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return printf(
                \   '%s %d %s %d',
                \   l:symbol,
                \   l:all_errors,
                \   l:symbol_warning,
                \   l:all_non_errors
                \)
endfunction

let g:currentmode={
            \ 'n'  : 'N ',
            \ 'no' : 'N·Operator Pending ',
            \ 'v'  : 'V ',
            \ 'V'  : 'V·Line ',
            \ '^V' : 'V·Block ',
            \ 's'  : 'Select ',
            \ 'S'  : 'S·Line ',
            \ '^S' : 'S·Block ',
            \ 'i'  : 'I ',
            \ 'R'  : 'R ',
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
    if (!has_key(g:currentmode, m))
        let g:currentmode[m] = 'V·Block '
    endif

    if (m =~# '\v(n|no)')
        exe 'hi! User1 ctermbg=102 ctermfg=231'
        exe 'hi! User9 ctermbg=8 ctermfg=102'
    elseif (m =~# '\v(v|V)' || g:currentmode[m] ==# 'V·Block ' || get(g:currentmode, m, '') ==# 't')
        exe 'hi! User1 ctermbg=125 ctermfg=231'
        exe 'hi! User9 ctermbg=8 ctermfg=125'
    elseif (m ==# 'i')
        exe 'hi! User1 ctermbg=136 ctermfg=231'
        exe 'hi! User9 ctermbg=8 ctermfg=136'
    else
        exe 'hi! User1 ctermbg=160 ctermfg=231'
        exe 'hi! User9 ctermbg=8 ctermfg=160'
    endif

    return ''
endfunction


set statusline=
set statusline+=%{StatuslineUpdate()}                       " Changing the statusline color
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}%9* " Current mode
set statusline+=%4*\ %{GitInfo()}                          " Git
set statusline+=%2*\ [%n]                                  " buffer
set statusline+=%2*\ %f\ %{ReadOnly()}\ %m\ %w\            " File+path
set statusline+=%2*\ %=                                    " Space
set statusline+=%8*%5*\ %y                                " FileType
set statusline+=%5*\ %{(&fenc!=''?&fenc:&enc)}             " Encoding & Fileformat
set statusline+=%6*\ %{LinterStatus()}\                    " ALE errors
set statusline+=%7*%1*%3p%%(%L)\ ☰\ %l:\ %2c\             " %(Total) Line: Col

colorscheme solarized8_dark_high

hi Normal ctermbg=NONE

hi User1 ctermfg=231 ctermbg=102
hi User2 ctermfg=231 ctermbg=8
hi User4 ctermfg=160 ctermbg=8
hi User5 ctermfg=231 ctermbg=246
hi User6 ctermfg=160 ctermbg=246

" Used for rendering the separators correctly.
hi User7 ctermfg=102 ctermbg=246
hi User8 ctermfg=246 ctermbg=8
hi User9 ctermfg=102 ctermbg=8

" END STATUS LINE


""" EMMET VIM """
let g:user_emmet_leader_key='<C-A>'

"""" SNIPPETS """"

"""" SNIPPETS """"

autocmd FileType html nnoremap <Leader>html :-1read $HOME/.vim/snippets/skeleton.html<CR>3jf>a
autocmd FileType python nnoremap <Leader>main :-1read $HOME/.vim/snippets/main.py<CR>o
autocmd FileType tex,plaintex nnoremap <Leader>tex :-1read $HOME/.vim/snippets/t.tex<CR>3jf{a

"""" END SNIPPETS """"


"""" SCRIPT EXECUTION/COMPILING """"

autocmd FileType python nnoremap <buffer> <F10> :exec '!python' shellescape(@%, 1)<CR>

" Compiles .tex files and opens its corresponding generated .pdf file.
autocmd FileType tex,plaintex nnoremap <buffer> <F9> :exec '!pdflatex' shellescape(@%, 1)<CR>
autocmd FileType tex,plaintex nnoremap <buffer> <F10> :exec '!xdg-open' shellescape(expand('%:r') . '.pdf', 1)<CR>

"""" END SCRIPT EXECUTION/COMPILING """"


"""" BETTER SEARCHING """"

"""" Grep Operator. SOURCE:'http://learnvimscriptthehardway.stevelosh.com/chapters/34.html'
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

"""" END BETTER SEARCHING """"

""" Auto Closing Brackets '[]' and Parenthesis '()' """
""" This doesn't write the closing character if it's already present. """
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

""" Auto Closing Single and Double Quotes """
""" This doesn't write the closing character if it's already present. """
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? '<Right>' : '""<Left>'

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

""" Automatic Signature for C# files """
autocmd FileType cs nnoremap <Leader>sig :-1read $HOME/.vim/snippets/cs_signature.txt<CR> 
            \ \| :g/File:.*/s//\=printf("File: %s", expand('%:t'))<CR>
            \ \| :g/Last Edit:.*/s//\=printf("Last Edit: %s", strftime('%d %b %Y'))<CR>
            \ \| :nohlsearch<CR>

autocmd FileType cs autocmd BufWritePre <buffer> call LastModified()
autocmd BufWritePre .vimrc,.tmux.conf,.bashrc call LastModified()


packloadall
silent! helptags ALL
