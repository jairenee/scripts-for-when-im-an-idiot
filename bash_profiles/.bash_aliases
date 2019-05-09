alias ebr="vim ~/.bashrc"
alias ebp="vim ~/.bash_profile"
alias sbp="source ~/.bash_profile"
alias evr="vim ~/.vimrc"
alias evc="vim ~/.vim_runtime/config.vim"
alias evpc="vim ~/.vim_runtime/vimrcs/plugins_config.vim"
alias ei3="vim ~/.i3/config"
alias eis="vim ~/.i3status.conf"

alias c="clear"
alias e="vim"

alias chx="chmod +x"

alias path='echo $PATH | tr -s ":" "\n"'

alias setclip='xclip -selection clipboard'
alias getclip='setclip -o'

alias cd='unset PROMPTSOURCED && cd'
alias dev='cd $DEV_FOLDER'
alias ldev='ll $DEV_FOLDER'
alias pdev='pushd $DEV_FOLDER'
alias cvr="cd ~/.vim_runtime"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias oops='cd $OLDPWD'
alias ls="ls -a --color=auto"
alias ll="ls -l"
alias lg="ll | grep"
alias cstack='cd "$(dirs -l -0)" && dirs -c'
alias mcde="mcd -o"
alias rm='/bin/rm -irv'
alias yrm='yes | rm'/
alias cp="cp -i"
alias df="df -h"
alias free="free -m"

alias gst="git status"
alias gstore="git config credential.helper store"
alias pull="git pull"
alias gcm="git pull && git add . && git commit && git push"
alias gcp="gc -p"
alias gp="git push"
alias gloce='git config --local user.email "$USER_EMAIL"'
alias eeegp="git add . && git commit -m 'This is an emergency commit because of a building evacuation or other sudden major event.' && git push"
