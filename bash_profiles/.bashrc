# shellcheck source=/dev/null

stty -ixon

export JWIZ_RC_VERSION=0.2.2

[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.tfvarsrc ]] && . ~/.tfvarsrc

jwizbash_config() {
    reset
    USER_NAME="${JWIZ_USER_NAME:-$USER}"
    USER_EMAIL="${USER_EMAIL:-""}"
    DEV_FOLDER="${DEV_FOLDER:-"~/Development"}"
    DIFF_TOOL="${DIFF_TOOL:-"p4merge"}"
    DEV_FOLDER="${DEV_FOLDER:-"~/Development"}"
    CONFIG_MODE=${1:-"JWiz Bash"}
    echo $USER_EMAIL
    echo "====="
    echo "${CONFIG_MODE} Config Options"
    if [[ $CONFIG_MODE == "Upgrade" ]]; then
        echo "Version $JWIZ_SETTINGS_VERSION -> $JWIZ_RC_VERSION"
    elif [[ $CONFIG_MODE == "Initial" ]]; then
        echo "Welcome :)"
    fi
    echo "====="
    read -p "Hi! What should I call you ($USER_NAME)" -r USER_NAME_REPLY
    USER_NAME=${USER_NAME_REPLY:-$USER_NAME}
    read -p "What is your development folder ($DEV_FOLDER)? " -r DEV_FOLDER_REPLY
    DEV_FOLDER=${DEV_FOLDER_REPLY:-$DEV_FOLDER}
    read -p "What is your difftool ($DIFF_TOOL)? " -r DIFF_TOOL_REPLY
    DIFF_TOOL=${DIFF_TOOL_REPLY:-$DIFF_TOOL}
    read -p "What is your email address for git$(if [[ $USER_EMAIL ]]; then printf " (%s)" "${USER_EMAIL}"; fi)? " -r USER_EMAIL_REPLY
    USER_EMAIL=${USER_EMAIL_REPLY:-$USER_EMAIL}
    PS3="Choose a color for your username: "
    select color in RED GREEN YELLOW BLUE WHITE PINK; do
        USER_COLOR=$color
        break
    done
    PS3="Choose a prompt icon: "
    select icon in $ ⪢ ⧽ ⟫ ⯈ ⛥ ⨎ ‽ ☭; do
        USER_ICON=$icon
        break
    done
    echo "=== Startup options"
    read -p "Show splash screen (Y/n)? " -n 1 -r
    case $REPLY in 
        [Nn]  ) SPLASH_SCREEN=false ;;
        [Yy]|*) SPLASH_SCREEN=true  ;;
    esac
    if [[ $REPLY ]]; then echo; fi
    read -p "Ask to git pull dev folder (Y/n)? " -n 1 -r
    case $REPLY in 
        [Nn]  ) PULL_DEV=false ;;
        [Yy]|*) PULL_DEV=true  ;;
    esac
    if [[ $REPLY ]]; then echo; fi
    read -p "Ask to cd to dev folder (y/N)? " -n 1 -r
    case $REPLY in 
        [Yy]  ) GTD=true  ;;
        [Nn]|*) GTD=false ;;
    esac
    if [[ $REPLY ]]; then echo; fi
    echo "Your editor is vim. Fuck you."
    cat > ~/.bash_settings <<- EOS
JWIZ_SETTINGS_VERSION="${JWIZ_RC_VERSION}"
DEV_FOLDER=${DEV_FOLDER:-~/Development}
DIFF_TOOL="${DIFF_TOOL:-p4merge}"
USER_EMAIL=${USER_EMAIL}

JWIZ_PULL_DEV=${PULL_DEV}
JWIZ_GTD=${GTD}
JWIZ_SPLASH_SCREEN=${SPLASH_SCREEN}
JWIZ_ANIMATE=true
JWIZ_USER_NAME="${USER_NAME}"
JWIZ_USER_COLOR="${USER_COLOR}"
JWIZ_USER_ICON="${USER_ICON}"
EOS
    . ~/.bash_settings
    sleep 2
    reset
}

loadOrRunSettings() {
    if [[ -f ~/.bash_settings ]]; then 
        . ~/.bash_settings
        if [[ "${JWIZ_SETTINGS_VERSION}" != "${JWIZ_RC_VERSION}" ]]; then
            jwizbash_config Upgrade
        fi
    else
        jwizbash_config Initial
    fi
}

loadOrRunSettings

get_all_colors() {
    color(){
        for c; do
            printf '\e[48;5;%dm%03d' "$c" "$c"
        done
        printf '\e[0m \n'
    }

    IFS=$' \t\n'
    color {0..15}
    for ((i=0;i<6;i++)); do
        color $(seq $((i*36+16)) $((i*36+51)))
    done
    color {232..255}
}

declare -A COLORS
COLORS[RED]=$(tput setaf 1)
COLORS[GREEN]=$(tput setaf 34)
COLORS[YELLOW]=$(tput setaf 226)
COLORS[BLUE]=$(tput setaf 44)
COLORS[WHITE]=$(tput setaf 7)
COLORS[PINK]=$(tput setaf 200)
COLORS[RESET]=$(tput sgr0)
COLORS[BOLD]=$(tput bold)
COLORS[CLEAR]="\r\e[0K"
COLORS[UPONE]="\r\e[1A"
COLORS[UPTWO]="\r\e[2A"


function git_color {
    local git_status
    git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working tree clean" ]]; then
        echo "${COLORS[RED]}"
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo "${COLORS[YELLOW]}"
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo "${COLORS[GREEN]}"
    else
        echo "${COLORS[BLUE]}"
    fi
}

function run_pull_check {
    current_branch_info="$(git branch -vv | grep '\*')"
    current_branch="$(echo "$current_branch_info" | awk '{print $2}')"
    remote_for_branch="$(echo "$current_branch_info" \
        | awk '{print $4}' | sed 's/\// /g' \
        | awk '{print $1}' | sed 's/\[//g')"
    git_remote="$(git remote show "$remote_for_branch" 2> /dev/null)"
    branch_status="${current_branch} pushes to .+local out of date"
    if [[ $git_remote =~ $branch_status ]]; then
        echo -e "${COLORS[UPONE]}│\n│ $(basename "$(pwd)")'s $current_branch branch has new data from $remote_for_branch"
        echo -n "╰ Git pull (y/N)? " 
        read -r GIT_PULL
        if [[ $GIT_PULL =~ [Yy] ]]; then
            git pull
        fi
    fi
}

function git_display {
    local git_status marker=""
    git_status="$(git status 2> /dev/null)"
    git_remote="$(git remote show origin 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"
    if [[ $git_remote =~ "local out of date" ]]; then
        marker="*"
    fi

    if [[ $git_status =~ $on_branch ]]; then
        echo "(${BASH_REMATCH[1]}${marker}) "
    elif [[ $git_status =~ $on_commit ]]; then
        echo "(${BASH_REMATCH[1]}${marker}) "
    fi
}

get_work_dir() {
    if [[ "$(pwd)" =~ "terraform" ]]; then
        local CURRENTFOLDER ABOVEFOLDER THREEUP
        CURRENTFOLDER="$(basename "$(pwd)")"
        ABOVEFOLDER="$(dirname "$(pwd)")"
        THREEUP="$(dirname "$ABOVEFOLDER")"
        if [[ "$CURRENTFOLDER" == "terraform" ]]; then
            echo "TF (base): $(basename "$ABOVEFOLDER")"
        elif [[ "$(basename "$ABOVEFOLDER")" == "terraform" ]]; then
            case $CURRENTFOLDER in
                *"dev"*)
                    CURRENTFOLDER="${COLORS[BLUE]}$CURRENTFOLDER${COLORS[WHITE]}"
                    ;;
                *"stage"*)
                    CURRENTFOLDER="${COLORS[YELLOW]}$CURRENTFOLDER${COLORS[WHITE]}"
                    ;;
                *"prod"*)
                    CURRENTFOLDER="${COLORS[RED]}$BOLD$CURRENTFOLDER${COLORS[WHITE]}"
                    ;;
            esac
            echo "TF ($CURRENTFOLDER): $(basename "$THREEUP")"
        fi
    else
        basename "$(dirs)"
    fi
}

function create_prompt {
    RETURN_VAL=$?
    tput civis
    local PROMPT INFO_LINE CD_LINE INFO_DIR
    if [[ "$(pwd)" =~ "terraform" ]]; then
        INFO_DIR="\$(get_work_dir)"
    else
        INFO_DIR="\w"
    fi
    CD_LINE="╒═╣\[${COLORS[WHITE]}\] \d \A \[${COLORS[RESET]}\]╞═╣\[${COLORS[WHITE]}\] \[${INFO_DIR}\] \[${COLORS[RESET]}\]╞══╕\n"
    INFO_LINE="╒═╣\[${COLORS[WHITE]}\] \[\$(get_work_dir)\] \[${COLORS[RESET]}\]╞══╕\n"
    if [[ $RETURN_VAL -eq 0 ]]; then
        RETURN_COLOR=${COLORS[GREEN]}
    else
        RETURN_COLOR=${COLORS[RED]}
    fi
    PROMPT="╰\[${COLORS["$JWIZ_USER_COLOR"]}\] \u \[\$(git_color)\]\$(git_display)\[$RETURN_COLOR\]$JWIZ_USER_ICON\[${COLORS[RESET]}\] "

    if [[ $PROMPTSOURCED ]]; then
        PS1="$INFO_LINE$PROMPT"
    else
        if [[ -d ".git" ]]; then
            run_pull_check
        fi
        PS1="$CD_LINE$PROMPT"
        PROMPTSOURCED=true
    fi
    tput cnorm
}

PROMPT_COMMAND=create_prompt
PS2="${COLORS[UPONE]}│\n╰ "
PS4="${0} Line:${LINENO}+- "

# vimx for when you can't build clipboard support from source
if hash vimx 2>/dev/null; then
    alias vim="vimx"
    export EDITOR=vimx
else
    export EDITOR=vim
fi

# I just prefer this to C-x->C-e
bind '"\C-e": edit-and-execute-command'

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

touchsh () {
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
export CDPATH=".:~:${DEV_FOLDER}"

export TFPROMOTE_DIFFTOOL=${DIFF_TOOL}

gpa () {
    if [[ -d ${DEV_FOLDER} ]]; then
        echo -ne "  ╚ ${COLORS[WHITE]}Git pull projects in dev folder (y/N)? ${COLORS[RESET]}"
        read -n 1 -r pull
        if [[ $pull =~ [Yy] ]]; then
            echo -e  "${COLORS[CLEAR]}  ╠ ${COLORS[GREEN]}Git pull projects in dev folder (${COLORS[BOLD]}y${COLORS[RESET]}${COLORS[GREEN]}/N)? ${COLORS[RESET]}"
            echo "  ╨ Pulling all development repos. Please wait."
            pushd "${DEV_FOLDER}" > /dev/null || return
            count=0
            # For folder in $DEV_FOLDER
            for D in */; do
                # If /.git is a folder that exists inside of that folder
                if [ -d "${D%?}/.git" ]; then
                    # Start pulling
                    (( count++ ))
                    # No new line in yellow \xE2\x98\x90 = ☐
                    echo -en "${COLORS[YELLOW]}☐ Pulling ${D%?}"
                    # This block is strictly to surpress output
                    {
                        pushd "${D}" || return
                        git pull
                        PULLSTATUS=$?
                        popd || return
                    } &> /dev/null
                    if [ ${PULLSTATUS} -eq 0 ]; then
                        # All good? Overwrite the line in green! \xE2\x98\x91 = ☑
                        echo -e "${COLORS[CLEAR]}${COLORS[GREEN]}☑ Pulled ${D%?}!"
                    else
                        # Problem? Overwrite the line in red. \xE2\x98\x91 = ☒
                        echo -e "${COLORS[CLEAR]}${COLORS[RED]}☒ Pull failed for ${D%?}!"
                    fi
                fi
            done
            popd > /dev/null || return
            echo -e "${COLORS[GREEN]}Processed $count${COLORS[RESET]}"
        else
            if [[ -z $pull ]]; then
                echo -en "${COLORS[UPONE]}"
            else
                echo -en "${COLORS[CLEAR]}"
            fi
            echo -e  "  ╠ ${COLORS[RED]}Git pull projects in dev folder (y/${COLORS[BOLD]}N${COLORS[RESET]}${COLORS[RED]})? ${COLORS[RESET]}"
        fi
    else
        echo "${DEV_FOLDER:-\$DEV_FOLDER} is not a folder that exists"
    fi
} 

gtd() {
    echo -ne "  ╚ ${COLORS[WHITE]}Go to dev folder (Y/n)? ${COLORS[RESET]}" 
    read -n 1 -r toDev
    if [[ ${toDev} =~ [Yy] ]] || [[ -z ${toDev} ]]; then
        if [[ -z ${toDev} ]]; then
            echo -en "${COLORS[UPONE]}"
        else
            echo -en "${COLORS[CLEAR]}"
        fi
        echo -e "  ╠ ${COLORS[GREEN]}Go to dev folder (${COLORS[BOLD]}Y${COLORS[RESET]}${COLORS[GREEN]}/n)? ${COLORS[RESET]}"
        dev
    else
        echo -e "  ╠ ${COLORS[RED]}Go to dev folder (Y/${COLORS[BOLD]}n${COLORS[RESET]}${COLORS[RED]})? ${COLORS[RESET]}"
    fi
}

function blinkInPlace() {
    local MSG=$1 SPD=$2 TIMES=$3 BACKSP OVERLINE
    BACKSP=$(printf '\b%.0s' $(seq 1 ${#MSG}))
    OVERLINE=$(printf ' %.0s' $(seq 1 ${#MSG}))

    printf "%s" "${MSG}"

    for i in $(seq 1 "${TIMES}"); do
        sleep "$SPD"
        printf "%s%s" "${BACKSP}" "${OVERLINE}"
        sleep "$SPD"
        printf "%s%s" "${BACKSP}" "${MSG}"
    done
    printf "%s\n" "${COLORS[RESET]}"
}

function blinkTwoLines() {
    local LINE1=$1 LINE2=$2 SPD=$3 OVERLINE
    OVERLINE=$(printf ' %.0s' $(seq 1 ${#LINE2}))

    echo -e   "$LINE1"
    echo -en  "$LINE2"
    sleep "$SPD"
    echo -en "${COLORS[UPONE]}"

    echo -e   "${COLORS[CLEAR]}"
    echo -en  "${COLORS[CLEAR]}$OVERLINE"
    sleep "$(echo "$SPD"/2 | bc -l)"
    echo -en "${COLORS[UPONE]}"
}

function writeOut() {
    local LINE=$1 SPD=$2
    for i in $(seq 1 ${#LINE}); do
        printf "%s" "${LINE:i-1:1}"
        sleep "$SPD"
    done
}

function writeNameDate() {
    local LINE1=$1 LINE2=$2 LINE1A=$3 LINE1B=$4 SPD=$5 current_date current_dirs long_str
    current_date=$(date +"%a %b %d %H:%M")
    current_dirs=$(dirs)
    [[ ${#current_dirs} -gt ${#current_date} ]] && long_str=${#current_dirs} || long_str=${#current_date}
    echo -e  "$LINE1"
    echo -en "$LINE2${COLORS[UPONE]}"
    for i in $(seq 1 "$long_str"); do
        echo -en "${COLORS[CLEAR]}$LINE1 ${COLORS[WHITE]}${current_date:0:i}${COLORS[RESET]} $LINE1A ${COLORS[WHITE]}${current_dirs:0:i}${COLORS[RESET]} $LINE1B"
        sleep "$SPD"
    done
    echo -en "\n${COLORS[CLEAR]}$LINE2${COLORS["$JWIZ_USER_COLOR"]}"
    writeOut "$USER" "$SPD"
    tput civis
    echo -en "${COLORS[UPONE]}${COLORS[RESET]}"
    # echo -e  "${COLORS[CLEAR]}"
    # echo -en "${COLORS[CLEAR]}"
    # echo -en "${COLORS[UPONE]}"
}

drawSplash() {
    local LINE1=$1 SPD=$2 WIDTH HEIGHT LENGTH
    WIDTH=$(tput cols)
    HEIGHT=$(tput lines)
    LENGTH=${#LINE1}
    clear
    BLOCK="█"
    for i in $(seq 1 "$LENGTH"); do
        tput cup $((HEIGHT / 2)) $(((WIDTH / 2) - (i / 2 + 1)))
        printf "%s" "${LINE1:0:i}"
        sleep "$SPD"
    done
    blinkInPlace "$BLOCK" 0.4 3
}

hideinput() {
  if [ -t 0 ]; then
     stty -echo -icanon time 0 min 0
  fi
}

cleanup() {
  if [ -t 0 ]; then
    stty sane
  fi
}

if [[ -z $BPRSOURCED ]]; then
    hideinput
    LINESPEED=0.04
    if [[ $JWIZ_SPLASH_SCREEN == "true" ]]; then
        SPLASH_STRING="I didn't think this through."
        tput civis
        drawSplash "$SPLASH_STRING" "$LINESPEED"
        reset
        tput cnorm
    fi
    greetings=( "Hello" "Howdy" "Welcome" )
    timenow=$(date +%s)
    if [[ $timenow -lt $(date --date="12:00" +%s) ]]; then
        GREETING="Good Morning,"
    elif [[ $timenow -gt $(date --date="17:00" +%s) ]]; then
        GREETING="It's after hours. Go home,"
    else
        rand=$((RANDOM % ${#greetings[@]}))
        GREETING=${greetings[$rand]}
    fi
    LINE1="${GREETING} ${COLORS["$JWIZ_USER_COLOR"]}${JWIZ_USER_NAME}${COLORS[RESET]}"
    LINE2="Dev Folder is ${COLORS[BLUE]}"
    echo -e  "╞═╦╣ "
    echo -en "╰ ╚═ "
    echo -en "${COLORS[UPTWO]:2}"
    echo -en "${COLORS[WHITE]}"
    writeOut "$LINE1" $LINESPEED
    echo -en "${COLORS[RESET]}\n╰ ╚═ ${COLORS[WHITE]}"
    writeOut "$LINE2" $LINESPEED
    blinkInPlace "${DEV_FOLDER}" 0.4 1
    echo -en "    "
    sleep 0.2
    echo -e "${COLORS[UPONE]}╰ ╠" 
    cleanup
    $JWIZ_PULL_DEV && gpa
    $JWIZ_GTD      && gtd
    hideinput
    LINE1="╒═╣" 
    LINE1A="╞═╣"
    LINE1B="╞══╕"
    LINE2="╰ "

    blinkTwoLines "$LINE1" "$LINE2" 0.4
    blinkTwoLines "$LINE1" "$LINE2" 0.6
    writeNameDate "$LINE1" "$LINE2" "$LINE1A" "$LINE1B" $LINESPEED

    tput cnorm
    cleanup
fi
