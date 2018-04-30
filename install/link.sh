#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles
echo -e "\n\n=============================="
echo -e "Creating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
		echo "Done."
    fi
done
echo "=============================="


echo -e "\n\n=============================="
echo -e "installing to ~/.config"
echo "=============================="
if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
	echo "Done."
else
	echo "~/.config already exists... Skipping."
fi
echo "=============================="

echo -e "\n\n=============================="
echo -e "copying .config/nvim"
echo "=============================="
if [ -d $HOME/.config/nvim/ ]; then
	echo ".config/nvim already exists... Skipping."
else
	echo "Copying..."
	ln -s ~/.dotfiles/nvim $HOME/.config/nvim
	echo "Done."
fi
echo "=============================="

echo "Link creator exiting..."
