
```shell
# shell script
printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
```

If your terminal **emulator does NOT display the word** `TRUECOLOR` in **red**, it does not support 24-bit color. 
If you don't want to switch to a different terminal emulator that supports 24-bit color, proceed to step 3. 
(After installation, the `g:onedark_termcolors` option may interest you.)

If your terminal **emulator displays the word** `TRUECOLOR` in **red**, it supports 24-bit color, 
and you should add the following lines to your `~/.vimrc` to enable 24-bit color terminal support inside Vim.


```Vim
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

```

# Reference
https://vimawesome.com/plugin/onedark-vim