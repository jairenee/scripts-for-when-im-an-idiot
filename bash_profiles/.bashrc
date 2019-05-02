[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.tfvarsrc ]] && . ~/.tfvarsrc

if [ -f ~/.bash_settings  ]; then
    . ~/.bash_settings
else
    echo "====="
    echo "Initial settings options"
    echo "====="
    read -p "What is your development folder (~/Development)? " -r dev_folder
    read -p "What is your difftool (p4merge)? " -r diff_tool
    read -p "What is your email address? " -r user_email
    echo "Your editor is vim. Fuck you."
    cat > ~/.bash_settings <<- EOS
export DEV_FOLDER=${dev_folder:-~/Development}
export DIFFTOOL=${diff_tool:-p4merge}
export USER_EMAIL=${user_email}
EOS
    . ~/.bash_settings
fi

# Git pull all in dev folder

# vimx for when you can't build clipboard support from source
if hash vimx 2>/dev/null; then
    alias vim="vimx"
    export EDITOR=vimx
else
    export EDITOR=vim
fi

# I just prefer this to C-x->C-e
bind '"\C-e": edit-and-execute-command'

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

alias setclip='xclip -selection clipboard'
alias getclip='setclip -o'

alias dev="cd $DEV_FOLDER"
alias ldev="ll $DEV_FOLDER"
alias pdev="pushd $DEV_FOLDER"
alias cvr="cd ~/.vim_runtime"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# This NEEDS to be single quotes. Otherwise, the variable will interpolate on source instead of at runtime
alias oops='cd $OLDPWD'
alias ls="ls -a --color=auto"
alias ll="ls -l"
alias lg="ll | grep"
alias cstack="cd '$(dirs -l -0)' && dirs -c"
alias mcde="mcd -v"
alias rm='/bin/rm -irv'
alias yrm='yes | rm'/
alias cp="cp -i"
alias df="df -h"
alias free="free -m"

alias gst="git status"
alias gstore="git config credential.helper store"
alias gcm="git pull && git add . && git commit && git push"
alias gcp="gc -p"
alias gp="git push"
alias gloce="git config --local user.email '$USER_EMAIL'"
alias eeegp="git add . && git commit -m 'This is an emergency commit because of a building evacuation or other sudden major event.' && git push"

testsh () {
    touch $1
    chmod +x $1
    vim $1
}

ghrepos () {
    unset user
    for user in $@; do :; done
    if [[ $user ]]; then
        echo "Repos for user $user:"
        repos=$(curl -s "https://api.github.com/users/$user/repos?page=1&per_page=100" |
                    grep -e 'git_url*' |
                    cut -d \" -f 4)
        echo $repos[@]
    else
        echo "Missing username"
    fi
}

ecrlog () {
    $(aws ecr get-login --no-include-email --region us-east-1 --profile $1)
}

mcd () {
    mk_dir=${@: -1}
    mkdir -p $mk_dir
    cd $mk_dir
    [[ $1 == "-v" ]] && e
}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Allows me to install to ~/usr/bin from rpms when I don't have sudo access.
# Takes files or urls. Don't pass anything and it'll read clipboard for urls.
rpmi() {
    local TEMPBIN=~/tempbin
    mkdir -p $TEMPBIN
    if [ -s "$1" ]; then
        if [[ $1 == *.rpm ]]; then
            # Move it to the temp bin, install in ~ and pop back
            cp $1 $TEMPBIN
            pushd ~
            rpm2cpio $TEMPBIN/$1 | cpio -idv
            popd
        else
            echo "Not an rpm file."
            exit 1
        fi
    elif [ -z "$1" ]; then
        RPM="$(getclip)"
        if [[ $RPM == http*://*.rpm ]]; then
            pushd ~
            wget -O - $RPM | rpm2cpio - | cpio -idv
            popd
        else
            echo "No valid rpm specified"
            exit 1
        fi
    else
        echo "No valid rpm specified"
        exit 1
    fi
}

effthis () {
    read -p "Are you sure you want to blow this up? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "ARE YOU REALLY SURE? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "One last confirmation for ENTIRELY DELETING THIS FOLDER ($(pwd)). THERE IS NO GOING BACK..."
            read -p "TYPE 'yes' EXACTLY. " -r
            if [[ $REPLY == yes ]]; then
                echo "Deleting $(pwd)"
                dir=$(pwd)
                cd ..
                /bin/rm -rf $dir
            fi
        fi
    fi
}

dockclean () {
    docker rm $(docker ps -a -q)
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

gc () {
    [[ $1 == -p ]] && url="$(getclip)" || url=$1
    if [[ $url == https://*.git ]] || [[ $url == git@*.git ]]; then
        dev
        git clone $url
        folder=$(basename "$url" ".git")
        cd $folder
        gstore
    else
        echo "Not a git link"
        exit 1
    fi
}

# Open remote in browser
gopen() {
    REMOTE=${1:-"origin"}
    xdg-open `git remote get-url $REMOTE | sed 's/git@/http:\/\//' | sed -r 's/(com|local):/\1\//'` | head -n1
}

# Fix Git Ignore
fgi () {
    git add . && git commit -m ".gitignore fix start"
    git rm -r --cached .
    git add . && git commit -m ".gitignore fix"
    git push
}


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . $HOME/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

LOCAL_PATH=$HOME/.local/bin:$HOME/usr/bin:$HOME/bin:
HOMEBIN=($HOME/bin/*/)
HOMEBIN_PATH=$(printf "%s:" "${HOMEBIN[@]}")
HOMEBIN_BIN=($HOME/bin/**/bin)
HOMEBIN_BIN_PATH=$(printf "%s:" "${HOMEBIN_BIN[@]}")

PATH="${LOCAL_PATH}${HOMEBIN_PATH}${HOMEBIN_BIN_PATH}${PATH}"

export TFPROMOTE_DIFFTOOL=$DIFFTOOL
export PATH

gpa () {
    # GPA_SIGINTHANDLE () {
        # ENDING=true
        # echo "ENDING GRACEFULLY..."
    # }
    # local ENDING=false
    if [[ -d $DEV_FOLDER ]]; then
        read -p "Git pull all in $DEV_FOLDER (y/N)? " -n 1 -r pull
        if [[ $pull =~ [Yy] ]]; then
            echo "Pulling all development repos. Please wait."
            pushd $DEV_FOLDER > /dev/null
            count=0
            trap "GPA_SIGINTHANDLE" INT
            # For folder in $DEV_FOLDER
            for D in */; do
                # if [[ $ENDING != true ]]; then
                    # If /.git is a folder that exists inside of that folder
                    if [ -d "${D%?}/.git" ]; then
                        # Start pulling
                        (( count++ ))
                        # No new line in yellow (\e[93m) \xE2\x98\x90 = ☐
                        echo -n -e "\e[93m\xE2\x98\x90 Pulling ${D%?}"
                        # This block is strictly to surpress output
                        {
                            pushd "${D}"
                            git pull
                            PULLSTATUS=$?
                            popd
                        } &> /dev/null
                        # Overwrite = \r\e[0K
                        if [ $PULLSTATUS -eq 0 ]; then
                            # All good? Overwrite the line in green! \xE2\x98\x91 = ☑
                            echo -e "\r\e[0K\e[92m\xE2\x98\x91 Pulled ${D%?}!"
                        else
                            # Problem? Overwrite the line in red. \xE2\x98\x91 = ☒
                            echo -e "\r\e[0K\e[91m\xE2\x98\x92 Pull failed for ${D%?}!"
                        fi
                    fi
                # else
                    # echo -e "\e[92mProcessed $count, but ended early\e[0m"
                    # exit 2
                # fi
            done
            popd > /dev/null
            echo -e "\e[92mProcessed $count\e[0m"
        fi
    else
        echo "${DEV_FOLDER:-\$DEV_FOLDER} is not a folder that exists"
    fi
}

if [[ -z $RCSOURCED ]]; then
    gpa

    if [[ $PWD == ~ ]]; then
        read -p "To dev folder (Y/n)? " -n 1 -r toDev
        if [[ $toDev =~ [Yy] ]] || [[ -z $toDev ]]; then
           dev
        fi
    fi
fi

export RCSOURCED=true
