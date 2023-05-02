#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update package index and upgrade packages
apt update -y
apt upgrade -y

# Install necessary packages
apt install -y git zsh vim curl wget htop tree tmux

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install nvm (Node.js Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install Docker
apt install -y docker.io docker-compose

# Add current user to Docker group
usermod -aG docker $USER

# Install Python
apt install -y python3 python3-pip

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Rust components
source $HOME/.cargo/env
rustup component add rustfmt clippy

# Install JetBrains Mono font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.fonts
fc-cache -fv

# Install VS Code
apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt update -y
apt install -y code

# Install Go
wget -c https://golang.org/dl/go1.16.3.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

# Set environment variables for Go
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bashrc

# Install Go tools
go get -u github.com/golang/dep/cmd/dep
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/nsf/gocode
go get -u golang.org/x/lint/golint
go get -u github.com/kisielk/errcheck

# Clean up
apt autoremove -y
