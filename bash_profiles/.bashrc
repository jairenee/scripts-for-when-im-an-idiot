# shellcheck source=/dev/null

stty -ixon

[[ -f /etc/bashrc ]] && . /etc/bashrc

if [ -f ~/.bash_settings  ]; then
    . ~/.bash_settings
else
    echo "====="
    echo "Initial settings options"
    echo "====="
    read -p "What is your development folder (~/Development)? " -r DEV_FOLDER
    read -p "What is your difftool (p4merge)? " -r DIFF_TOOL
    read -p "What is your email address? " -r USER_EMAIL
    echo "Your editor is vim. Fuck you."
    cat > ~/.bash_settings <<- EOS
export DEV_FOLDER=${DEV_FOLDER:-~/Development}
export DIFF_TOOL=${DIFF_TOOL:-p4merge}
export USER_EMAIL=${USER_EMAIL}
EOS
    . ~/.bash_settings
fi

[[ -f ~/.tfvarsrc ]] && . ~/.tfvarsrc

COLOR_RED="\e[0;31m"
COLOR_GREEN="\e[0;32m"
COLOR_YELLOW="\e[0;33m"
COLOR_BLUE="\e[0;34m"
COLOR_PINK="\e[01;35m"
COLOR_WHITE="\e[0;37m"
COLOR_RESET="\e[0m"

function git_display {
  local git_status display
  git_status="$(git status 2> /dev/null)"
  
  if [[ "$git_status" ]]; then
      local on_branch="On branch ([^${IFS}]*)"
      local on_commit="HEAD detached at ([^${IFS}]*)"

      if [[ ! $git_status =~ "working tree clean" ]]; then
        display="$COLOR_RED"
      elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        display="$COLOR_YELLOW"
      elif [[ $git_status =~ "nothing to commit" ]]; then
        display="$COLOR_GREEN"
      else
        display="$COLOR_BLUE"
      fi

      if [[ $git_status =~ $on_branch ]]; then
        display+="(${BASH_REMATCH[1]}) "
      elif [[ $git_status =~ $on_commit ]]; then
        display+="(${BASH_REMATCH[1]}) "
      fi
      echo -e "$display"
  fi
}

get_work_dir() {
    if [[ "$(pwd)" =~ "terraform" ]]; then
        local CURRENTFOLDER ABOVEFOLDER THREEUP
        CURRENTFOLDER="$(basename "$(pwd)")"
        ABOVEFOLDER="$(dirname "$(pwd)")"
        THREEUP="$(dirname "$ABOVEFOLDER")"
        if [[ "$CURRENTFOLDER" == "terraform" ]]; then
            echo "Terraform (base): $(basename "$ABOVEFOLDER")"
        elif [[ "$(basename "$ABOVEFOLDER")" == "terraform" ]]; then
            echo "Terraform ($CURRENTFOLDER): $(basename "$THREEUP")"
        fi
    else
        basename "$(pwd)"
    fi
}

function create_prompt {
    RETURN_VAL=$?
    local PROMPT INFO_LINE CD_LINE
    CD_LINE="╒═╣\[$COLOR_WHITE\]\d \A\[$COLOR_RESET\]╞═╣\[$COLOR_WHITE\]\w\[$COLOR_RESET\]╞══╕\n"
    INFO_LINE="╒══╣\[$COLOR_WHITE\]\$(get_work_dir)\[$COLOR_RESET\]╞══╕\n"
    if [[ $RETURN_VAL -eq 0 ]]; then
        RETURN_COLOR=$COLOR_GREEN
    else
        RETURN_COLOR=$COLOR_RED
    fi
    PROMPT="╞\[$COLOR_PINK\] \u \$(git_display)\[$RETURN_COLOR\]⪢\[$COLOR_RESET\] "

    if [[ $PROMPTSOURCED ]]; then
        PS1="$INFO_LINE$PROMPT"
    else
        PS1="$CD_LINE$PROMPT"
        PROMPTSOURCED=true
    fi
}

PROMPT_COMMAND=create_prompt
PS2="╞"

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
alias gcm="git pull && git add . && git commit && git push"
alias gcp="gc -p"
alias gp="git push"
alias gloce='git config --local user.email "$USER_EMAIL"'
alias eeegp="git add . && git commit -m 'This is an emergency commit because of a building evacuation or other sudden major event.' && git push"

testsh () {
    touch "$1"
    chmod +x "$1"
    vim "$1"
}

ghrepos () {
    unset user
    for user in "$@"; do :; done
    if [[ $user ]]; then
        echo "Repos for user $user:"
        repos=$(curl -s "https://api.github.com/users/$user/repos?page=1&per_page=100" |
                    grep -e 'git_url.+' |
                    cut -d \" -f 4)
        echo "${repos[@]}"
    else
        echo "Missing username"
    fi
}

ecrlog () {
    # shellcheck disable=SC2091
    $(aws ecr get-login --no-include-email --region us-east-1 --profile "$1")
}

mcd () {
    args=( "$@" )
    mk_dir="${args[-1]}"
    mkdir -p "$mk_dir"
    cd "$mk_dir" || return
    [[ "$1" == "-o" ]] && e
}

ex ()
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1"    ;;
      *.tar.gz)   tar xzf "$1"    ;;
      *.bz2)      bunzip2 "$1"    ;;
      *.rar)      unrar x "$1"    ;;
      *.gz)       gunzip "$1"     ;;
      *.tar)      tar xf "$1"     ;;
      *.tbz2)     tar xjf "$1"    ;;
      *.tgz)      tar xzf "$1"    ;;
      *.zip)      unzip "$1"      ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1"       ;;
      *)          echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Allows me to install to ~/usr/bin from rpms when I don't have sudo access.
# Takes files or urls. Don't pass anything and it'll read clipboard for urls.
rpmi() {
    local TEMPBIN=~/tempbin
    mkdir -p "$TEMPBIN"
    if [ -s "$1" ]; then
        if [[ "$1" == *.rpm ]]; then
            # Move it to the temp bin, install in ~ and pop back
            cp "$1" "$TEMPBIN"
            pushd "$HOME" || return 1
            rpm2cpio "$TEMPBIN/$1" | cpio -idv
            popd || return 1
        else
            echo "Not an rpm file."
            exit 1
        fi
    elif [ -z "$1" ]; then
        RPM="$(getclip)"
        if [[ "$RPM" == http*://*.rpm ]]; then
            pushd "$HOME" || return 1
            wget -O - "$RPM" | rpm2cpio - | cpio -idv
            popd "$HOME" || return 1
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
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        read -p "ARE YOU REALLY SURE? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            echo "One last confirmation for ENTIRELY DELETING THIS FOLDER ($(pwd)). THERE IS NO GOING BACK..."
            read -p "TYPE 'yes' EXACTLY. " -r
            if [[ "$REPLY" == yes ]]; then
                echo "Deleting $(pwd)"
                dir=$(pwd)
                cd ..
                /bin/rm -rf "$dir"
            fi
        fi
    fi
}

dockclean () {
    docker ps -a -q | while IFS='' read -r stoppedContainer
    do
        docker rm "$stoppedContainer"
    done

    docker images | grep "^<none>" | awk '{print $3}' \
        | while IFS='' read -r untaggedImage
    do
        docker rmi "$untaggedImage"
    done
}

gc () {
    [[ "$1" == -p ]] && url="$(getclip)" || url=$1
    if [[ "$url" == https://*.git ]] || [[ "$url" == git@*.git ]]; then
        dev
        git clone "$url"
        folder=$(basename "$url" ".git")
        cd "$folder" || return
        gstore
    else
        echo "Not a git link"
        exit 1
    fi
}

# Open remote in browser
gopen() {
    REMOTE=${1:-"origin"}
    xdg-open "$(git remote get-url "$REMOTE" | \
        sed 's/git@/http:\/\//' | sed -r 's/(com|local):/\1\//')" | \
        head -n1
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
[ -f "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . "$HOME"/bin/node/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

function join_path { local IFS=: ; echo "$*"; }

LOCAL_PATH=( "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/usr/bin" "$HOME/bin" "$HOME"/bin/*/ "$HOME"/bin/**/bin/ )

for dir in "${LOCAL_PATH[@]}"; do
    case ":$PATH:" in
        *":$dir:"*) :;;
        *) PATH="$dir:$PATH";;
    esac
done

export PATH

export TFPROMOTE_DIFFTOOL=$DIFF_TOOL

gpa () {
    # GPA_SIGINTHANDLE () {
        # ENDING=true
        # echo "ENDING GRACEFULLY..."
    # }
    # local ENDING=false
    if [[ -d $DEV_FOLDER ]]; then
        echo -ne "  ╚ ${COLOR_WHITE}Git pull projects in dev folder (y/N)? ${COLOR_RESET}"
        read -n 1 -r pull
        if [[ $pull =~ [Yy] ]]; then
            echo "Pulling all development repos. Please wait."
            pushd "$DEV_FOLDER" > /dev/null || return
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
                            pushd "${D}" || return
                            git pull
                            PULLSTATUS=$?
                            popd || return
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
            popd > /dev/null || return
            echo -e "\e[92mProcessed $count\e[0m"
        else
            echo -en "\e[1A"
            echo -e  "\e[0K  ║ Git pull projects in dev folder (y/N)? "
        fi
    else
        echo "${DEV_FOLDER:-\$DEV_FOLDER} is not a folder that exists"
    fi
}

if [[ -z $RCSOURCED ]]; then
    echo -e "╞═╦╣ ${COLOR_WHITE}Hello, ${USER}${COLOR_RESET}"
    echo -e "╰ ╠═ ${COLOR_WHITE}Dev Folder is ${COLOR_BLUE}$DEV_FOLDER${COLOR_RESET}"
    gpa
    if [[ $PWD == ~ ]]; then
        echo -ne "  ╚ ${COLOR_WHITE}Go to dev folder (Y/n)? ${COLOR_RESET}" 
        read -n 1 -r toDev
        echo -en "\e[1A"
        if [[ $toDev =~ [Yy] ]] || [[ -z $toDev ]]; then
           dev
        fi
        echo -e "\e[0K  ║ Go to dev folder (Y/n)? "
    fi
fi

export RCSOURCED=true
