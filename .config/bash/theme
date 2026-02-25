# robbyrussell-inspired bash prompt
__git_info() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || \
    branch=$(git rev-parse --short HEAD 2>/dev/null) || return

    local dirty=""
    git diff --quiet 2>/dev/null || dirty=" ✗"

    echo -e " \e[34mgit:(\e[31m${branch}\e[34m)\e[0m${dirty}"
}

build_prompt() {
    local EXIT=$?
    local ARROW_COLOR="\e[32m"
    [ $EXIT -ne 0 ] && ARROW_COLOR="\e[31m"

    PS1="\[${ARROW_COLOR}\]➜  \[\e[36m\]\W\[\e[0m\]$(  __git_info)\[\e[0m\] "
}

PROMPT_COMMAND=build_prompt
