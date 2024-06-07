#! /bin/bash

alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
git clone --bare git@github.com:sourabh-pisal/dotfiles.git $HOME/dotfiles
dotfiles switch -f mainline
dotfiles config --local status.showUntrackedFiles no
