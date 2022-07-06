# Neovim
## Installation
- neovim
- [vim-plug](https://github.com/junegunn/vim-plug)
- nodejs *lastest version*
- npm
- npm *provider*: `sudo npm install -g neovim`
- python, python-pip
- pynvim:
    ```
    python3 -m pip install --user --upgrade pynvim
    ```
- For python2 if needed (run `:checkhealth` for more infomations)
  <details>
    <summary>click here</summary>
  
    - python2, python2-pip
      > If you can't find the ***python2-pip*** package, see this [documentation](https://pip.pypa.io/en/latest/installation/).
      >> Remember to replace `python` with `python2` to install pip2.
    - pynvim:
        ```
        python2 -m pip install --user --upgrade pynvim 
        ```
  </details>

- ccls (for C/C++)
## Copy config folder
- Copy ***nvim*** folder to ***~/.config/***
## Finally
1. Open nvim (don't worry with some error message) and run `:PlugInstall` and wait to install plugins.
   > - You will get "**post-update hook for fzf...**" error message if you installed fzf with "`pacman -S fzf`".
   > - Press 'R' to retry.
2. You will see the CoC extension installation after all plugins are successfully installed.
3. Close nvim and open again, run `:VimspectorInstal vscode-cpptools` (for C/C++ debugging).
   > You can use *Tab* and choose adapter.
4. Done.
