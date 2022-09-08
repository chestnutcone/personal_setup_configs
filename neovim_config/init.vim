if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.vim/plugged'
endif
" Plugins List
call plug#begin(g:plugged_home)
  " UI related
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Better Visual Guide
  Plug 'Yggdroot/indentLine'
  " syntax check
  Plug 'w0rp/ale'
  " Autocomplete
  " Plug 'ncm2/ncm2'
  " Plug 'roxma/nvim-yarp'
  " Plug 'ncm2/ncm2-bufword'
  " Plug 'ncm2/ncm2-path'
  " Plug 'ncm2/ncm2-jedi'
  " Formater
  Plug 'Chiel92/vim-autoformat'
  " tpope
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " c# stuff
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()
filetype plugin indent on
" Configurations Part
" UI configuration
syntax on
syntax enable
" colorscheme
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard
set background=dark
" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif
set number
set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw
" Turn off backup
set nobackup
set noswapfile
set nowritebackup
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4
" vim-autoformat
noremap <F3> :Autoformat<CR>
" NCM2
" augroup NCM2
"   autocmd!
"   " enable ncm2 for all buffers
"   autocmd BufEnter * call ncm2#enable_for_buffer()
"   " :help Ncm2PopupOpen for more information
"   set completeopt=noinsert,menuone,noselect
"   " When the <Enter> key is pressed while the popup menu is visible, it only
"   " hides the menu. Use this mapping to close the menu and also start a new line.
"   inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"   " uncomment this block if you use vimtex for LaTex
"   " autocmd Filetype tex call ncm2#register_source({
"   "           \ 'name': 'vimtex',
"   "           \ 'priority': 8,
"   "           \ 'scope': ['tex'],
"   "           \ 'mark': 'tex',
"   "           \ 'word_pattern': '\w+',
"   "           \ 'complete_pattern': g:vimtex#re#ncm2,
"   "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"   "           \ })
" augroup END
" Ale
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint'], 'cs': ['OmniSharp']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1
" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
" omnisharp
let g:OmniSharp_server_use_net6 = 1
" asyncomplete
let g:asyncomplete_auto_popup = 1
" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" indentation
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
" disable default auto comment insertion
autocmd FileType * setlocal formatoptions-=cro
" no delay when changing mode
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=1000
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
" disable word suggestion

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" search visual block with //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap \E :ALEDetail<CR>
inoremap FileType cs {<CR> <CR>{<CR>}<ESC>O
inoremap FileType cs {;<CR> <CR>{<CR>};<ESC>O

" set yank to system clipboard (linux)
set clipboard=unnamedplus
