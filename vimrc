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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:airline_theme='solarized'
set background=dark
colorscheme solarized8_dark_high

hi Normal ctermbg=NONE
