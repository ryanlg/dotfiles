#!/usr/bin/env bash

echo "Installing .dotfiles"

# Start linking
source install/link.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
source install/brew.sh  # Homebrew
source install.system.sh  # System settings
fi

# Switch to zsh
chsh -s /bin/zsh

# .gitignore_global
git config --global core.excludesfile ~/.gitignore_global 

echo "Done."
