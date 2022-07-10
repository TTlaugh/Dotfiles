# Vifm
## General
- Copy [dracula.vifm](https://github.com/vifm/vifm-colors) to ***~/.vifm/colors/***
- Copy  ***gitbranch***, ***vifmrun*** and ***vifmimg*** to ***~/.vifm/scripts/***
  > NOTE: you must execute **vifmrun** script to use vifm with ueberzug support.
## Config in vifmrc
- Line 14: change "**vim**" to "**nvim**" (`set vicmd=nvim`).
- Line 62: change theme to "**dracula**" (`colorscheme dracula`).
- Line 132: change "**vim**" to "**nvim**" (`command! diff nvim -d %f %F`).
- Search for `gvim` and comment or delete these lines.
- General config:
  ```
  only
  set number
  set relativenumber
  map af za
  map <c-j> 5j
  map <c-k> 5k
  map <space>f /
  map f<space> /
  map q :q<CR>
  ```
- status line
  - Default format with add more colors:
    ```
    highlight User1 ctermfg=cyan
    highlight User2 ctermfg=yellow
    highlight User3 ctermfg=red
    highlight User4 ctermfg=green
    highlight User5 ctermfg=magenta
    set statusline="%1*%z%=    %2*%A %3*%10u:%-7g %4*%10s %5*%20d"
    ```
  - Add my git branch script:
    ```
    highlight User1 ctermfg=cyan
    highlight User2 ctermbg=cyan ctermfg=black
    highlight User3 ctermfg=yellow
    highlight User4 ctermfg=red
    highlight User5 ctermfg=green
    highlight User6 ctermfg=magenta
    set statusline="%1*%2*%{extcached('gitbranch', expand('%d'), 'gitbranch ' . expand('%d'))}%1*%*%=%3*%A %4*%10u:%-7g %5*%10s %6*%20d"
    ```
- Sxiv:
  ```
  command sxiv sxiv -ft .
  ```
- Feh:
  ```
  command feho feh -d -g 800x600 --scale-down . &
  command fehl feh -t . &
  command fehbg feh --bg-fill %c
  map <space>b :fehbg<CR>
  ```
- Atool:
  ```
  command extract atool -x -e %f
  command compressZ atool -a -F .zip -e %f
  command compressT atool -a -F .tar.xz -e %f
  map <space>e  :extract<CR>
  map <space>c  :compressZ<CR>
  map <space>ct :compressT<CR>
  ```
  > #### Now you can use:
  > - `:sxiv` to list all images in current directory.
  > - *space+e* to extract file.
  > - *space+c* to compress `.zip`.
  > - *space+c+t* to compress `.tar.xz`.
- Filextype and fileviewer config:
  - Images
    ```
    filextype {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
            \ {View in sxiv}
            \ sxiv %f &,
            \ {View in feh}
            \ feh -d -g 800x600 --scale-down %c &,
    fileviewer {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
            \ vifmimg draw %px %py %pw %ph %c
            \ %pc
            \ vifmimg clear
    ```
  - Videos
    > Use **mpv** as default.
    ```
    filextype {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
              \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
              \*.as[fx]},
             \<video/*>
            \ {View using mpv}
            \ mpv %f 2>/dev/null &,
            \ {View using ffplay}
            \ ffplay -fs -autoexit %f,
    fileviewer {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
               \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
               \*.as[fx]},
              \<video/*>
             \ vifmimg videopreview %px %py %pw %ph %c
             \ %pc
             \ vifmimg clear
    ```
  - Audio
    > Use **mpv** as default.
    ```
    filetype {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus},
            \<audio/*>
           \ {Play using mpv}
           \ mpv %f,
           \ {Play using ffplay}
           \ ffplay -nodisp -autoexit %c,
    ```
- Optional:
  - Preview with syntax highlighting using bat
    ```
    fileviewer *[^/],.*[^/] bat --color=always %c -pp
    ```
  - Preview directory using ls command
    ```
    fileviewer */,.*/ ls -1 --color=always %c
    ```
- Icons:
To display icons, add this after line `" filetype * start, explorer`:
```
" file types
set classify=' :dir:/, :exe:, :reg:, :link:'
" various file names
set classify+=' ::../::, ::*.sh::, ::*.[hc]pp::, ::*.[hc]::, ::/^copying|license$/::, ::.git/,,*.git/::, ::*.epub,,*.fb2,,*.djvu::, ::*.pdf::, ::*.htm,,*.html,,**.[sx]html,,*.xml::'
" archives
set classify+=' ::*.7z,,*.ace,,*.arj,,*.bz2,,*.cpio,,*.deb,,*.dz,,*.gz,,*.jar,,*.lzh,,*.lzma,,*.rar,,*.rpm,,*.rz,,*.tar,,*.taz,,*.tb2,,*.tbz,,*.tbz2,,*.tgz,,*.tlz,,*.trz,,*.txz,,*.tz,,*.tz2,,*.xz,,*.z,,*.zip,,*.zoo::'
" images
set classify+=' ::*.bmp,,*.gif,,*.jpeg,,*.jpg,,*.ico,,*.png,,*.ppm,,*.svg,,*.svgz,,*.tga,,*.tif,,*.tiff,,*.xbm,,*.xcf,,*.xpm,,*.xspf,,*.xwd::'
" audio
set classify+=' ::*.aac,,*.anx,,*.asf,,*.au,,*.axa,,*.flac,,*.m2a,,*.m4a,,*.mid,,*.midi,,*.mp3,,*.mpc,,*.oga,,*.ogg,,*.ogx,,*.ra,,*.ram,,*.rm,,*.spx,,*.wav,,*.wma,,*.ac3::'
" media
set classify+=' ::*.avi,,*.ts,,*.axv,,*.divx,,*.m2v,,*.m4p,,*.m4v,,.mka,,*.mkv,,*.mov,,*.mp4,,*.flv,,*.mp4v,,*.mpeg,,*.mpg,,*.nuv,,*.ogv,,*.pbm,,*.pgm,,*.qt,,*.vob,,*.wmv,,*.xvid::'
" office files
set classify+=' ::*.doc,,*.docx::, ::*.xls,,*.xls[mx]::, ::*.pptx,,*.ppt::'
```
