""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration file for vim
""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""
" appearance
""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set ruler
set showmode
set showcmd
set cmdheight=1
set matchpairs+=<:>
colo cube
set number
set modelines=0
set nowrap
set colorcolumn=80

highlight SignColumn ctermfg=7 ctermbg=0
highlight SyntasticErrorSign ctermfg=15 ctermbg=0
highlight ColorColumn ctermbg=0
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=2 ctermbg=0
highlight ErrorMsg ctermfg=0 ctermbg=7
highlight Visual ctermfg=4 ctermbg=0
highlight SpellBad ctermbg=7 ctermfg=0
highlight SpellCap ctermbg=15 ctermfg=0
highlight Todo cterm=underline ctermbg=0 ctermfg=3
highlight Error ctermbg=7 ctermfg=0

""""""""""""""""""""""""""""""""""""""""""""""""
" formating
""""""""""""""""""""""""""""""""""""""""""""""""
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set smartindent
set ignorecase
set magic
set scrolloff=8
set backspace=indent,eol,start

" custom styling
au FileType c set sw=8

" Explicitly render different types of whitespaces differently
" and render trailing spaces.
set list listchars=tab:→\ ,nbsp:␣,trail:•

" close characters
":inoremap ( ()<Esc>i
":inoremap < <><Esc>i
":inoremap { {}<Esc>i
":inoremap [ []<Esc>i
":inoremap " ""<Esc>i
":inoremap ' ''<Esc>i
":inoremap ` ``<Esc>i

""""""""""""""""""""""""""""""""""""""""""""""""
" speed vim up
""""""""""""""""""""""""""""""""""""""""""""""""
set ttyfast
set lazyredraw
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" searching
""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set ignorecase
" misc.
set encoding=utf-8
" custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap U <c-r>
nnoremap W <c-w>
nnoremap J <c-d>
nnoremap K <c-u>
nnoremap m K
nmap ; :

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'

" disable arrow keys
""""""""""""""""""""""""""""""""""""""""""""""""
no <Up> <Nop>
no <Down> <Nop>
no <Left> <Nop>
no <Right> <Nop>
ino <Up> <Nop>
ino <Down> <Nop>
ino <Left> <Nop>
ino <Right> <Nop>

" statusline
""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
" [filetype] filename [unix]    <line:column> [%location]
set statusline+=%y 
set statusline+=\  
set statusline+=%F
set statusline+=\  
set statusline+=[%{&fileformat}]
"set statusline+=\%2*
set statusline+=%=
set statusline+=[%l:%c]
set statusline+=\  
set statusline+=[%P]
set statusline+=\  
set statusline+=[%L\ lines]

hi Statusline ctermfg=0 ctermbg=1
" reset colour when switching modes
if version >= 700
  au InsertEnter * hi Statusline ctermfg=0 ctermbg=2
  au InsertLeave * hi Statusline ctermfg=0 ctermbg=1
endif

set shell=/bin/zsh
set noautowrite
set hidden

" netrw 
""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 4
let g:netrw_list_hide = '.git,.jpg,.png,.svg'
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browser_split = 2
let g:netrw_winsize = 25
let mapleader = " "

" rg
"""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
    let g:rg_derive_root='true'
endif

" ctrlp
"""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --execlude-standard']
let g:ctrlp_use_caching = 0

" Plugins
" """"""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'kien/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
call plug#end()
