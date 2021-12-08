call plug#begin('~/.config/nvim/plugins/bundle')

    Plug 'mhinz/vim-startify'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'puremourning/vimspector'
    Plug 'preservim/nerdcommenter'
    Plug 'frazrepo/vim-rainbow'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'cdelledonne/vim-cmake'
    Plug 'tpope/vim-fugitive'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'joshdick/onedark.vim'

    Plug 'ryanoasis/vim-devicons'

call plug#end()

