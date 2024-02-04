#!/bin/bash

# Root Check
#if [[ $(id -u) -ne 0 ]];
#  then echo "Run as root...";
#  exit 1;
#fi

# Vars
OSNAME=$(uname)
DOTFILES_REPO_URL="https://github.com/YenLegion/dot.git"
DOTFILES_BRANCH="main"

# Functions

# Read a single char from /dev/tty, prompting with "$*"
# Note: pressing enter will return a null string. Perhaps a version terminated with X and then remove it in caller?
# See https://unix.stackexchange.com/a/367880/143394 for dealing with multi-byte, etc.
function get_keypress {
  local REPLY IFS=
  >/dev/tty printf '%s' "$*"
  [[ $ZSH_VERSION ]] && read -rk1  # Use -u0 to read from STDIN
  # See https://unix.stackexchange.com/q/383197/143394 regarding '\n' -> ''
  [[ $BASH_VERSION ]] && </dev/tty read -rn1
  printf '%s' "$REPLY"
}

# Get a y/n from the user, return yes=0, no=1 enter=$2
# Prompt using $1.
# If set, return $2 on pressing enter, useful for cancel or defualting
function get_yes_keypress {
  local prompt="${1:-Are you sure [y/n]? }"
  local enter_return=$2
  local REPLY
  # [[ ! $prompt ]] && prompt="[y/n]? "
  while REPLY=$(get_keypress "$prompt"); do
    [[ $REPLY ]] && printf '\n' # $REPLY blank if user presses enter
    case "$REPLY" in
      Y|y)  return 0;;
      N|n)  return 1;;
      '')   [[ $enter_return ]] && return "$enter_return"
    esac
  done
}

# Credit: http://unix.stackexchange.com/a/14444/143394
# Prompt to confirm, defaulting to NO on <enter>
# Usage: confirm "Dangerous. Are you sure?" && rm *
function confirm {
  local prompt="${*:-Are you sure} [y/N]? "
  get_yes_keypress "$prompt" 1
}    

# Prompt to confirm, defaulting to YES on <enter>
function confirm_yes {
  local prompt="${*:-Are you sure} [Y/n]? "
  get_yes_keypress "$prompt" 0
}

bootstrap_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n[BOOTSTRAP] $fmt\n" "$@"
}



if [ ! -d "$HOME/source" ]; then
bootstrap_echo "Making our source folder"
mkdir "$HOME/source" 
fi

bootstrap_echo "Grabbing a few repos we like to use"

if [ ! -d "$HOME/source/rmtrash" ]; then 
git clone https://github.com/PhrozenByte/rmtrash.git "$HOME/source/rmtrash"
ln -s "$HOME/source/rmtrash/rmdirtrash" "$HOME/.local/bin/rmdirtrash"
ln -s "$HOME/source/rmtrash/rmtrash" "$HOME/.local/bin/rmtrash"
fi



bootstrap_echo "Complete"