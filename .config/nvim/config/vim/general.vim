set nocompatible
filetype plugin on
"filetype indent on
syntax on
set encoding=utf-8

set shortmess+=c
set updatetime=300
set cmdheight=2
set hidden
set nobackup
set nowritebackup
set noswapfile
set nowrap
set history=50
set showcmd

set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

set laststatus=2
set noshowmode
set showtabline=2

set smarttab
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
set cursorline

"set nojoinspaces

set clipboard=unnamedplus
set mouse=a

set autoread
set autowrite

set termguicolors
set background=dark

set scrolloff=5
set sidescrolloff=5

set wildmenu

set splitright
set splitbelow

set list listchars=tab:\|\ 

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au FileType c,cpp,objc,objcpp,json set noexpandtab
