""" Coc Extension
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-spell-checker',
  \ 'coc-highlight',
  \ 'coc-json'
  \ ]

""" Vim themes
colorscheme dracula
"colorscheme onedark

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
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'StatusDiagnostic',
      \ },
      \ }

""" Vim-Airline config
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#tabline#fnamemod = ':t'
"if !exists('g:airline_symbols')
  "let g:airline_symbols = {}
"endif
"let g:airline_symbols.colnr = ' : '
"let g:airline_symbols.linenr = ' '
"let g:airline_symbols.readonly = ' '
"let g:airline_symbols.maxlinenr = ''

""" RainBow Bracket
au FileType c,cpp,objc,objcpp,json call rainbow#load()

""" Vim-Cmake
let g:cmake_link_compile_commands = 1

""" FZF
let g:fzf_layout = { 'down': '40%' }
