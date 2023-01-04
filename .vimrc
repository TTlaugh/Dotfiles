""" Update all
":PlugUpgrade|:PlugUpdate|:VimspectorUpdate|:CocUpdate
"+--------------------------+
"| +----------------------+ |
"| |   General Settings   | |
"| +----------------------+ |
"+--------------------------+
set nocompatible
filetype plugin on
syntax on

set encoding=utf-8

set title

set wildmenu
set wildmode=longest:full,full
set wildoptions=pum

set nobackup
set nowritebackup
set noswapfile

set noshowmode
set laststatus=2

set ignorecase

set nowrap

set smarttab
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
set cursorline
set scrolloff=5
set sidescrolloff=5

set splitright
set splitbelow

set termguicolors
set background=dark

set clipboard=unnamedplus
set mouse=a

set list listchars=tab:\▏\ 

""" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType c,cpp,objc,objcpp,json set noexpandtab

if ! filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.vim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.vim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

"+-------------------------+
"| +---------------------+ |
"| |     Plugin List     | |
"| +---------------------+ |
"+-------------------------+
call plug#begin('~/.vim/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
    """ Status bar
    Plug 'itchyny/lightline.vim'
    """ Themes
    Plug 'joshdick/onedark.vim'
    """ Icons
    Plug 'ryanoasis/vim-devicons'
call plug#end()

"+----------------------------+
"| +------------------------+ |
"| |  Plugin Configuration  | |
"| +------------------------+ |
"+----------------------------+
""" Themes
colorscheme onedark

""" Startify
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_persistence = 1
let g:startify_custom_header =
    \ startify#center([
    \'╔╗╔╔═╗╔═╗╦  ╦╦╔╦╗',
    \'║║║║╣ ║ ║╚╗╔╝║║║║',
    \'╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩',
    \])
let g:startify_lists = [
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'commands',  'header': ['   Commands']       },
    \ ]
let g:startify_bookmarks = [
    \ { 'z': '~/.config/zsh/.zshrc' },
    \ { 'v': '~/.vimrc' },
    \ { 'd': '~/Documents/' },
    \ ]
let g:startify_commands = [
    \ {'pu': ':PlugUpdate'},
    \ {'pd': ':PlugUpgrade'},
    \ ]

""" Vim-lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

""" FZF
let g:fzf_layout = { 'down': '40%' }

"+--------------------------+
"| +----------------------+ |
"| |       Mappings       | |
"| +----------------------+ |
"+--------------------------+
""" Leader Key
let mapleader = ","
nmap <leader>e :edit ~/.vimrc <CR>

""" Remap Esc to jk and jk
"inoremap jk <Esc>
"inoremap kj <Esc>

""" Built-in spell-checker
map <F4> :setlocal spell! spelllang=en_us<CR>
""" Automatically fix misspelled word with the first suggestion
nmap <leader><F4> :normal! mz1z=`z<CR>

""" Switch to V-mode and Ctrl-r to replace with new word
vmap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

vmap <S-p> "_dP

vmap < <gv-gv
vmap > >gv-gv

""" Use ALT+{h,j,k,l} to navigate windows from any mode
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

""" Resize split window
noremap <C-Up>    <c-w>+
noremap <C-Down>  <c-w>-
noremap <C-Left>  <c-w><
noremap <C-Right> <c-w>>

vmap <C-j> :move '>+1<CR>gv-gv
vmap <C-k> :move '<-2<CR>gv-gv

""" Toggle horiz/vert
nmap <leader>th <C-w>t<C-w>H
nmap <leader>tk <C-w>t<C-w>K

""" turn off highlighting
nmap <leader><leader> :nohlsearch<CR>

""" FZF
nmap <leader>z :Files<CR>
nmap L         :Buffers<CR>

""" Ctrl+x to delete buffer
nmap <C-x>     :bdelete!<CR>

""" NerdTree
nmap <leader>n :NERDTreeToggle<CR>

""" Markdown preview
nmap <leader>mp :MarkdownPreviewToggle<CR>
