" Startify
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_persistence = 1

let g:startify_custom_header =
    \ startify#center([
    \'███╗   ██╗██╗   ██╗██╗███╗   ███╗',
    \'████╗  ██║██║   ██║██║████╗ ████║',
    \'██╔██╗ ██║██║   ██║██║██╔████╔██║',
    \'██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    \'██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
    \'╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ NLTT',
    \])

let g:startify_lists = [
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'dir',       'header': ['   Dir '. getcwd()] },
    \ { 'type': 'files',     'header': ['   Recent files']   },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'commands',  'header': ['   Commands']       },
    \ ]

" Customize your bookmarks by a variable below
let g:startify_bookmarks = [
    \ { 'z': '~/.zshrc' },
    "\ { 'c': '~/.config/i3/config' },
    \ { 'n': '~/.config/nvim/' },
    \ { 'd': '~/Documents/' },
    "\ { 'm': '~/MyGitHub/' },
    "\ { '*': '~/tmp/' },
    \ ]

let g:startify_commands = [
    \ {'h': ':checkhealth'},
    \ {'pu': ':PlugUpdate'},
    \ {'pd': ':PlugUpgrade'},
    \ {'cu': ':CocUpdate'},
    \ {'vu': ':VimspectorUpdate'},
    \ ]

" Coc Extension
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-spell-checker',
  \ 'coc-highlight',
  \ 'coc-json'
  \ ]

" Vim theme 
colorscheme dracula
"colorscheme embark

" Vim-Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ' : '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.readonly = ' '
let g:airline_symbols.maxlinenr = ''
" Switch to your current theme
"let g:airline_theme = 'onedark'

" RainBow Bracket
au FileType c,cpp,objc,objcpp,json call rainbow#load()

" Vim-Cmake
let g:cmake_link_compile_commands = 1

" FZF
let g:fzf_layout = { 'down': '40%' }

" NerdTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'',
                \ 'Staged'    :'',
                \ 'Untracked' :'',
                \ 'Renamed'   :'',
                \ 'Unmerged'  :'',
                \ 'Deleted'   :'',
                \ 'Dirty'     :'',
                \ 'Ignored'   :'',
                \ 'Clean'     :'',
                \ 'Unknown'   :'',
                \ }
"                      
