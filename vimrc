" Piero Marini
" Last Edit: 12/5/17
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

map <C-N> :NERDTreeToggle<CR>
nnoremap ,d :YcmShowDetailedDiagnostic<CR>

nnoremap ,<Space> :nohlsearch<CR>

" Copy Paste
noremap <C-v> "+p
noremap <C-c> "+y
noremap ,p "*p
noremap ,y "*y

" YCM C#
nnoremap <F5> :YcmCompleter ReloadSolution<CR>

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
