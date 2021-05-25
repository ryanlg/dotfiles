#!/bin/sh

# Check if we have brew already
if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="
brew install ack
brew install git
brew install fzf
brew install z
brew install wget
brew install curl
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
brew install starship
brew install neovim/neovim/neovim
brew install python3
echo "=============================="

exit 0
