#!/usr/bin/env bash

echo "Installing .dotfiles"

#Start linking
source install/link.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
#Homebrew
source install/brew.sh
fi

#Switch to zsh
chsh -s /bin/zsh

#.gitignore_global
git config --global core.excludesfile ~/.gitignore_global 

echo "Done."
