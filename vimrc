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
noremap <C-c> "+y
noremap <C-v> "+p
nnoremap <Leader>p "*p
nnoremap <Leader>y "*y

" Visual Block Select
nnoremap <Leader>v <C-v>

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

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermbg=8 ctermfg=2'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermbg=8 ctermfg=5'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermbg=8 ctermfg=20'
  else
    exe 'hi! StatusLine ctermbg=2 ctermfg=160'
  endif

  return ''
endfunction

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

set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%#warningmsg#
set statusline+=\ %{GitInfo()}                           " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%8*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%#warningmsg#
set statusline+=%{LinterStatus()}                        " ALE errors
set statusline+=%8*\ %3p%%(%L)\ \ %l:\ %2c\             " Rownumber/total (%)

hi User1 ctermbg=8 ctermfg=2
" END STATUS LINE "

colorscheme solarized8_dark_high

hi Normal ctermbg=NONE
hi StatusLine ctermfg=2 ctermbg=8 

packloadall
silent! helptags ALL
