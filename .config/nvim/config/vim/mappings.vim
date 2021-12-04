" Leader Key
let mapleader = ","

" Startify
nmap ~ :Startify<CR>

inoremap jk <Esc>
inoremap kj <Esc>
nmap <c-x> :q<CR>

nnoremap <S-j> 5j
vnoremap <S-j> 5j
nnoremap <S-k> 5k
vnoremap <S-k> 5k

" Chose the word to change V-mode and Ctrl-r to replace with new word
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Tab Action
nmap <leader><tab> :tabnext<CR>

" Buffers Action
nmap `n  :bnext<CR>
nmap `p  :bprevious<CR>
nmap `a  :badd 
nmap `d  :bdelete<CR>

" Move between split tab
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l

" Change size split tab
noremap <C-up>    <c-w>-
noremap <C-down>  <c-w>+
noremap <C-left>  <c-w><
noremap <C-right> <c-w>>

nmap <leader>, :nohlsearch<CR>

" Nerd Tree
nmap <F3> :NERDTreeToggle<CR>

" fzf
nmap <F4> :Files<CR>
nmap <F5> :Buffers<CR>
nmap <F6> :Rg<CR>

" Open st terminal or alacritty terminal
"nmap <F7> :!st -c vim-terminal &<CR>
"nmap <F7> :!alacritty --class vim-terminal,vim-terminal &<CR>

" NerdCommenter
vmap // <plug>NERDCommenterToggle
nmap // <plug>NERDCommenterToggle

" Vimspector
map <F8>           <Plug>VimspectorToggleBreakpoint
"map <leader><F8>   <Plug>VimspectorAddFunctionBreakpoint

map <F9>           <Plug>VimspectorContinue
map <leader><F9>   <Plug>VimspectorStop
map <leader>d<F9>  <Plug>VimspectorRestart

map <F12>          <Plug>VimspectorPause

map <F10>          <Plug>VimspectorStepOver
map <F11>          <Plug>VimspectorStepInto
map <leader><F11>  <Plug>VimspectorStepOut

nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput


" Vim-Cmake
nmap <leader>gg :CMakeGenerate<CR>
nmap <leader>bb :CMakeBuild<CR>
nmap <leader>cx :CMakeClose<CR>

