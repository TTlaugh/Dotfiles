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

autocmd FileType c,cpp,objc,objcpp,json,java set noexpandtab

let nvim_path = system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim.vim/"')

"+-------------------------+
"| +---------------------+ |
"| |     Plugin List     | |
"| +---------------------+ |
"+-------------------------+
if ! filereadable(nvim_path . 'autoload/plug.vim')
    let $autoload_path = g:nvim_path . "autoload/"
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p $autoload_path
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $autoload_path/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(nvim_path . 'plugged')
    """ Startify
    Plug 'mhinz/vim-startify'
    """ Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    """ Editing
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'frazrepo/vim-rainbow'
    """ Debugging
    Plug 'puremourning/vimspector'
    """ File manager (NerdTree)
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    """ Finder (FZF)
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    """ Git
    "Plug 'tpope/vim-fugitive'
    "Plug 'airblade/vim-gitgutter'
    """ Status bar
    Plug 'itchyny/lightline.vim'
    """ Themes
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    "Plug 'dracula/vim', { 'as': 'dracula' }
    "Plug 'joshdick/onedark.vim'
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
let g:startify_session_dir = nvim_path . 'session'
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
    \ { 'n': nvim_path . 'init.vim' },
    \ { 'z': '~/.config/zsh/.zshrc' },
    \ { 'd': '~/Dev/' },
    \ ]
let g:startify_commands = [
    \ {'h': ':checkhealth'},
    \ {'pu': ':PlugUpdate'},
    \ {'pd': ':PlugUpgrade'},
    \ {'cu': ':CocUpdate'},
    \ {'vu': ':VimspectorUpdate'},
    \ ]

""" Coc
let g:coc_data_home = nvim_path . 'coc'
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-highlight',
  \ 'coc-json',
  \ 'coc-java',
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
autocmd FileType c,cpp,objc,objcpp,json,python,java call rainbow#load()
"let g:rainbow_active = 1

""" Turn off default mappings of NerdCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '// ','right': '' },
            \ 'cpp': { 'left': '// ','right': '' },
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
nmap <leader>e :execute 'edit ' . nvim_path . 'init.vim' <CR>

""" Remap Esc to jk and jk
"inoremap jk <Esc>
"inoremap kj <Esc>

""" Built-in spell-checker
map <F4> :setlocal spell! spelllang=en_us<CR>
""" Automatically fix misspelled word with the first suggestion
nmap <leader><F4> :normal! mz1z=`z<CR>

""" Check file in shellcheck
nmap <leader>s :!shellcheck -x %<CR>

""" Switch to V-mode and Ctrl-r to replace with new word
vmap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

vmap <S-p> "_dP

vmap < <gv-gv
vmap > >gv-gv

""" Exit terminal-mode
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

vmap <C-j> :move '>+1<CR>gv-gv
vmap <C-k> :move '<-2<CR>gv-gv

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
vmap \  <plug>NERDCommenterToggle
nmap \\ <plug>NERDCommenterToggle

""" Custom mappings for C/C++ auto comment
autocmd FileType c,cpp,objc,objcpp nmap <C-/> i/***/<left><left><cr><cr><up>
autocmd FileType c,cpp,objc,objcpp vmap <C-/> I<CR><up>/**<ESC>gv<ESC>o*/<ESC>0

""" Vimspector
nmap <leader>db      <Plug>VimspectorToggleBreakpoint
nmap <A-Left>        <Plug>VimspectorContinue
nmap <A-Right>       <Plug>VimspectorStepOver
nmap <A-Down>        <Plug>VimspectorStepInto
nmap <A-Up>          <Plug>VimspectorStepOut
nmap <leader><Left>  <Plug>VimspectorRestart
nmap <leader>dp      <Plug>VimspectorPause
nmap <leader>ds      <Plug>VimspectorStop
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

    " May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
    " utf-8 byte sequence
    set encoding=utf-8
    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
    " delays and poor user experience
    set updatetime=300

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config
    inoremap <silent><expr> <TAB>
                \ coc#pum#visible() ? coc#pum#next(1) :
                \ CheckBackspace() ? "\<Tab>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion
    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s)
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying code actions to the selected code block
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying code actions at the cursor position
    nmap <leader>ac  <Plug>(coc-codeaction-cursor)
    " Remap keys for apply code actions affect whole buffer
    nmap <leader>as  <Plug>(coc-codeaction-source)
    " Apply the most preferred quickfix action to fix diagnostic on the current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Remap keys for applying refactor code actions
    nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
    xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
    nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

    " Run the Code Lens action on the current line
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> to scroll float windows/popups
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges
    " Requires 'textDocument/selectionRange' support of language server
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings for CoCList
    " Show all diagnostics
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

endif
