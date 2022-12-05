""" Update all
":PlugUpgrade|:PlugUpdate|:VimspectorUpdate|:CocUpdate
"+--------------------------+
"| +----------------------+ |
"| |   General Settings   | |
"| +----------------------+ |
"+--------------------------+
filetype plugin on
syntax on

set encoding=utf-8

set shortmess=FI
set title

set nobackup
set nowritebackup
set noswapfile

set noshowmode
set laststatus=3

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

au FileType c,cpp,objc,objcpp,json set noexpandtab

"+-------------------------+
"| +---------------------+ |
"| |     Plugin List     | |
"| +---------------------+ |
"+-------------------------+
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
    """ Startify
    Plug 'mhinz/vim-startify'
    """ Code intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdcommenter'
    Plug 'frazrepo/vim-rainbow'
    Plug 'tpope/vim-surround'
    """ Debugging
    Plug 'puremourning/vimspector'
    """ File manager (NerdTree)
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    """ Finder (FZF)
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    """ Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    """ Cmake
    Plug 'cdelledonne/vim-cmake'
    """ Markdown preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
    """ Status bar
    Plug 'itchyny/lightline.vim'
    """ Themes
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'dracula/vim', { 'as': 'dracula' }
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
colorscheme tokyonight-moon
"colorscheme tokyonight
"colorscheme tokyonight-day
"colorscheme dracula
"colorscheme onedark

""" Startify
let g:startify_session_dir = '~/.config/nvim/session'
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
    \ { 'w': '~/.config/qtile/config.py' },
    \ { 'n': '~/.config/nvim/init.vim' },
    \ { 'd': '~/Documents/' },
    \ ]
let g:startify_commands = [
    \ {'h': ':checkhealth'},
    \ {'pu': ':PlugUpdate'},
    \ {'pd': ':PlugUpgrade'},
    \ {'cu': ':CocUpdate'},
    \ {'vu': ':VimspectorUpdate'},
    \ ]

""" Coc Extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-highlight',
  \ 'coc-json'
  \ ]

""" Vim-lightline
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '( ' . info['error'] . ')')
  endif
  if get(info, 'warning', 0)
    call add(msgs, '( ' . info['warning'] . ')')
  endif
  return join(msgs, ' '). '' . get(g:, 'coc_status', '')
endfunction
"\ 'colorscheme': 'one',
"\ 'colorscheme': 'dracula',
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'StatusDiagnostic',
      \ },
      \ }

""" RainBow Bracket
au FileType c,cpp,objc,objcpp,json,python call rainbow#load()
"let g:rainbow_active = 1

""" Turn off default mappings of NerdCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/* ','right': ' */' },
            \ 'cpp': { 'left': '/* ','right': ' */' },
            \ }

""" Vim-Cmake
let g:cmake_link_compile_commands = 1

""" FZF
let g:fzf_layout = { 'down': '40%' }

"+--------------------------+
"| +----------------------+ |
"| |       Mappings       | |
"| +----------------------+ |
"+--------------------------+
""" Leader Key
let mapleader = ","
nnoremap <leader>e :edit ~/.config/nvim/init.vim <CR>

""" Remap Esc to jk and jk
"inoremap jk <Esc>
"inoremap kj <Esc>

""" Built-in spell-check
map <F4> :setlocal spell! spelllang=en_us<CR>
""" Automatically fix misspelled word with the first suggestion
nnoremap <leader><F4> :normal! mz1z=`z<CR>

""" Check file in shellcheck
nmap <leader>s :!shellcheck -x %<CR>

""" Switch to V-mode and Ctrl-r to replace with new word
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

vnoremap < <gv-gv
vnoremap > >gv-gv

""" Use <space><Esc> to exit terminal-mode
tnoremap <C-x> <C-\><C-n>
""" Use ALT+{h,j,k,l} to navigate windows from any mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

""" Resize split window
noremap <C-Up>    <c-w>+
noremap <C-Down>  <c-w>-
noremap <C-Left>  <c-w><
noremap <C-Right> <c-w>>

imap <C-n> <ESC>:move .+1<CR>==gi
imap <C-p> <ESC>:move .-2<CR>==gi

nmap <C-n> :move .+1<CR>==
nmap <C-p> :move .-2<CR>==

vmap <C-n> :move '>+1<CR>gv-gv
vmap <C-p> :move '<-2<CR>gv-gv

""" Toggle horiz/vert
nmap <leader>th <C-w>t<C-w>H
nmap <leader>tk <C-w>t<C-w>K

""" Open terminal in vertically split window
nmap <leader>tt :vnew term://zsh<CR>

""" turn off highlighting
nmap <leader><leader> :nohlsearch<CR>

""" FZF
nmap <leader>z :Files<CR>
nmap L         :Buffers<CR>

""" Ctrl+x to delete buffer
nmap <C-x>     :bdelete<CR>

""" NerdTree
nmap <leader>n :NERDTreeToggle<CR>

""" NerdCommenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

""" Vimspector
nmap <leader>db     <Plug>VimspectorToggleBreakpoint
nmap <F9>           <Plug>VimspectorContinue
nmap <leader><F9>   <Plug>VimspectorRestart
nmap <F5>           <Plug>VimspectorStepOver
nmap <F6>           <Plug>VimspectorStepInto
nmap <F7>           <Plug>VimspectorStepOut
nmap <F8>           <Plug>VimspectorPause
nmap <leader><F8>   <Plug>VimspectorStop
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput

""" Vim-Cmake
nmap <leader>gg :CMakeGenerate<CR>
nmap <leader>bb :CMakeBuild<CR>
nmap <leader>cx :CMakeClose<CR>

""" Markdown preview
nmap <leader>mp :MarkdownPreviewToggle<CR>

"+-------------------------+
"| +---------------------+ |
"| |  CoC Configuration  | |
"| +---------------------+ |
"+-------------------------+
if isdirectory(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/coc"'))

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300
    
    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes
    
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    
    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    
    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif
    
    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    
    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    
    " Use K to show documentation in preview window.
    nnoremap <silent> K :call ShowDocumentation()<CR>
    
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction
    
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    
    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)
    
    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)
    
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    
    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)
    
    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
    
    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)
    
    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
    
    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif
    
    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)
    
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')
    
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
    
    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    
    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

endif
