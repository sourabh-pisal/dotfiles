# Dotfiles management
alias dotfiles="/usr/bin/git --git-dir=$HOME/Workplace/dotfiles/ --work-tree=$HOME"
alias dtst='dotfiles status'
alias dts='dotfiles status'
alias dtco='dotfiles checkout'
alias dtcb='dotfiles checkout -b'
alias dtb='dotfiles branch'
alias dtd='dotfiles diff'
alias dtdc='dotfiles diff --cached'
alias dta='dotfiles add'
alias dtc='dotfiles commit -v'
alias dtcmsg='dotfiles commit -m'
alias dtlog='dotfiles log --oneline --decorate --graph'
alias dtp='dotfiles pull'
