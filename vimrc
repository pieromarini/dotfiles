" Piero Marini
" Last Edit: 12/19/17
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
" autocmd FileType c,cpp,cs,python,css,html,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e

"""" END MAPPINGS """"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_server_python_interpreter = '/usr/bin/python2'

" Turn off YCM linter
let g:ycm_show_diagnostics_ui = 0

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'python': ['autopep8'],
\}
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
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
" let g:ale_cs_mcsc_assembly_path = ['/opt/UnityBeta/Editor/Data/']
let g:ale_cs_mcsc_assemblies = ['/opt/UnityBeta/Editor/Data/Managed/UnityEditor.dll', '/opt/UnityBeta/Editor/Data/Managed/UnityEngine.dll', '/opt/UnityBeta/Editor/Data/UnityExtensions/Unity/GUISystem/UnityEngine.UI.dll']


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
function! StatulineUpdate()
  if (mode() =~# '\v(n|no)')
    exe 'hi! User1 ctermbg=102 ctermfg=231'
    exe 'hi! User9 ctermbg=8 ctermfg=102'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! User1 ctermbg=125 ctermfg=231'
    exe 'hi! User9 ctermbg=8 ctermfg=125'
  elseif (mode() ==# 'i')
    exe 'hi! User1 ctermbg=136 ctermfg=231'
    exe 'hi! User9 ctermbg=8 ctermfg=136'
  else
    exe 'hi! User1 ctermbg=160 ctermfg=231'
    exe 'hi! User9 ctermbg=8 ctermfg=160'
  endif

  return ''
endfunction


set statusline=
set statusline+=%{StatulineUpdate()}                       " Changing the statusline color
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}%9* " Current mode
set statusline+=%4*\ %{GitInfo()}                          " Git
set statusline+=%2*\ [%n]                                  " buffer
set statusline+=%2*\ %f\ %{ReadOnly()}\ %m\ %w\            " File+path
set statusline+=%2*\ %=                                    " Space
set statusline+=%8*%5*\ %y                                " FileType
set statusline+=%5*\ %{(&fenc!=''?&fenc:&enc)}             " Encoding & Fileformat
set statusline+=%6*\ %{LinterStatus()}\                    " ALE errors
set statusline+=%7*%1*%3p%%(%L)\ ☰\ %l:\ %2c\             " %(Total) Line: Col

" END STATUS LINE

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


packloadall
silent! helptags ALL
