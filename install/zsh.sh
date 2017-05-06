#!/usr/bin/env bash

#Get oh-my-zsh from github

#Deleting the thing by omz
rm ~/.zshrc

#Replace it by mine
ln -s zsh/zshrc.delayedsymlink ~/.zshrc
