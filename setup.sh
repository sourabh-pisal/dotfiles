#! /bin/bash

rm -rf dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME/sourabh"
git clone --bare git@github.com:sourabh-pisal/dotfiles.git $HOME/dotfiles
dotfiles switch -f mainline
dotfiles config --local status.showUntrackedFiles no
rm setup.sh
