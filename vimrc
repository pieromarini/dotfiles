" Piero Marini
" Last Edit: 12/7/17
" Vim 8 Config file

syntax on
filetype on
filetype plugin on
filetype indent on

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

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
nnoremap <C-v> "+p
nnoremap <C-c> "+y
nnoremap <Leader>p "*p
nnoremap <Leader>y "*y

" Remove trailing whitespace.
autocmd FileType c,cpp,cs,python,css,html,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e

"""" END MAPPINGS """"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8', 'autopep8'],
\}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1

let g:airline_theme='solarized'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#warning_symbol = '⚠ '
let g:airline#extensions#ale#error_symbol = '⚠ '
set background=dark
colorscheme solarized8_dark_high

hi Normal ctermbg=NONE

packloadall
silent! helptags ALL
