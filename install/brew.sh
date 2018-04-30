#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="
brew install ack
brew install git
brew install hub
brew install fzf
brew install z
brew install wget
brew install curl
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
brew install highlight
brew install markdown
brew install diff-so-fancy
brew install zsh-syntax-highlighting
brew install neovim/neovim/neovim
brew install python3
echo "=============================="

exit 0
