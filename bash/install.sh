#!/bin/bash

# Root Check
#if [[ $(id -u) -ne 0 ]];
#  then echo "Run as root...";
#  exit 1;
#fi

# Vars
#OSNAME=$(uname)
#DOTFILES_REPO_URL="https://github.com/YenLegion/dot.git"
#DOTFILES_BRANCH="main"

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

# System Check
if [[ "$OSNAME" == 'Darwin' ]]; then
        bootstrap_echo "This is not a Mac"
        exit 1
elif [[ "$OSNAME" != 'Linux' ]]; then
        bootstrap_echo "This doesn't appear to be a supported OS"
        exit 1
fi

# Determine if plaform is Linux
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release ] || [ -d /etc/lsb-release.d ]; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        export DISTRO
    # Otherwise, use release i[<65;34;33Mnfo file
    else
        DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
        export DISTRO
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

if [[ "$DISTRO" == 'Ubuntu' ]]; then
bootstrap_echo "We have Ubuntu..."
fi

bootstrap_echo "We need to check for updates and install some packages."

sudo apt update -y
sudo apt upgrade -y

sudo apt -y install git micro bat yadm zsh ranger zoxide stow fzf exa \
ripgrep fd-find tig delta
# Additions#
# sudo apt -y install lazygit lazydocker
# trash-cli
sudo snap install --classic code
sudo snap install btop procs;

bootstrap_echo "ZSH Setup"

#if [[ -f "$HOME/.zshrc" ]]; then
#confirm_yes "$@" "We need to backup .zshrc"  
#mkdir "$HOME/dot-backup"
#mv ~/.zshrc ~/dot-backup/.zshrc
#fi

#if [ -d "$HOME/.local/share/yadm" ]; then
#  bootstrap_echo "A previous YADM repo was found."
#else
#  yadm clone https://github.com/YenLegion/dot.git
#fi

bootstrap_echo "Setting up ZSH"

# figure out test for password entry with chsh -s /bin/zsh

if [ ! -d "$HOME/.zsh/antidote" ]; then
git clone https://github.com/jandamm/zgenom.git ~/zgenom
fi

#if [ ! -d "$HOME/zsh-quickstart-kit" ]; then
#git clone https://github.com/unixorn/zsh-quickstart-kit.git ~/zsh-quickstart-kit
#stow --target="$HOME" ~/zsh-quickstart-kit/zsh
#cp ~/zsh-quickstart-kit/.zsh-quickstart-local-plugins-example ~/.zsh-quickstart-local-plugins
#fi

bootstrap_echo "Making our source folder"

if [ ! -d "$HOME/source" ]; then
mkdir "$HOME/source" 
fi

if [ ! -d "$HOME/.zsh/repos" ]; then
mkdir "$HOME/.zsh/repos" 
fi

if [ ! -d "$HOME/.zsh/plugins" ]; then


bootstrap_echo "Grabbing a few repos we like to use"

git clone https://github.com/PhrozenByte/rmtrash.git "$HOME/rmtrash"



bootstrap_echo "Complete"
