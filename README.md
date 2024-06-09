##To setup dotfiles run following command

```
rm -rf dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
git clone --bare git@github.com:sourabh-pisal/dotfiles.git $HOME/dotfiles
dotfiles switch -f mainline
dotfiles config --local status.showUntrackedFiles no
dotfiles branch --set-upstream orgin mainline
rm setup.sh
rm README.md
```
