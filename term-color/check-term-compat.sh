<<<<<<< HEAD
#! /bin/zsh
=======
#!/bin/zsh

>>>>>>> 0cd2cb8969d679a45cdeac700d10eddb7c6ddfdb
if autoload -U is-at-least && is-at-least 5.7; then
  echo "ZSH $ZSH_VERSION: supports true color"
else
  echo "ZSH $ZSH_VERSION: does not support true color"
fi

if [[ $COLORTERM == (24bit|truecolor) || ${terminfo[colors]} -eq 16777216 ]]; then
  echo "Terminal supports true color"
else
  echo "Terminal does not support true color"
fi
