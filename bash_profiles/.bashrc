if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

printf "Git pull (Y/n)? "

read pull

pull="$(echo "$pull" | awk '{print tolower($0)}')"

if [ "$pull" == "y" ] || [ -z "$pull" ]; then
  printf "Pulling all development repos. Please wait.\n"
	
  pushd ~/Development > /dev/null
  count=0
  for D in */; do
    if [ -d "${D%?}/.git" ]; then
      (( count++ ))
      echo -n -e "\r\e[0K\e[93m\xE2\x98\x90 Pulling ${D%?}"
      {
        pushd "${D}"
        git pull
	PULLSTATUS=$?
        popd
      } &> /dev/null
      if [ $PULLSTATUS -eq 0 ]; then
      	echo -e "\r\e[0K\e[92m\xE2\x98\x91 Pulled ${D%?}!"
      else
    	echo -e "\r\e[0K\e[91m\xE2\x98\x92 Pull failed for ${D%?}!"
      fi
    fi
  done
  popd > /dev/null
  echo -e "\n\e[92mProcessed $count\e[0m"
  cd ~/Development
fi

alias ebr="vim ~/.bashrc"
alias ebp="vim ~/.bash_profile"
alias sbp="source ~/.bash_profile"

alias c="clear"
alias e="code ."

alias xclipb='xclip -selection clipboard'

alias dev="cd ~/Development"
alias pdev="pushd ~/Development"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias oops="cd $OLDPWD"
alias ll="ls -la"
alias ldev="ll ~/Development"
alias cstack="cd "$(dirs -l -0)" && dirs -c"
alias rm='/bin/rm -irv'
alias yrm='yes | rm'

alias ti="terraform init"
alias ta="terraform apply"
alias otf="cd terraform && e && cd dev"
alias proma="tfpromote -a"

alias gst="git status"
alias gstore="git config credential.helper store"
alias gcm="git pull && git add . && git commit && git push"
alias gcp="gc -p"
alias gp="git push"
alias gloce="git config --local user.email 'jaime.wissner@gmail.com'"
alias eeegp="git add . && git commit -m 'This is an emergency commit because of a building evacuation or other sudden major event.' && git push"

alias ecrlog='$(aws ecr get-login --no-include-email --region us-east-1 --profile jwissner)'

alias edex='nohup ~/Downloads/eDEX-UI.Linux.x86_64.AppImage &>/dev/null &'

mcd () {
  dirname=$1
  mkdir $1
  cd $1
}

mcde () {
  mcd $1
  e
}

effthis () {
  read -p "Are you sure you want to blow this up? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "ARE YOU REALLY SURE? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      dir=$(pwd)
      cd ..
      /bin/rm -rf $dir
    fi
  fi
}

dockclean () {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

ugtf () {
  olddir=$(pwd)
  cd ~/bin/Hashicorp
  python upgrade_terraform.py
  cd $olddir
}

gc () {
  url=$1
  if [ "$url" = "-p" ]; then
    url="$(xclip -o -selection clipboard)"
  fi
  dev
  git clone $url
  ending=${url##*/}
  folder=${ending%.*}
  cd ${folder}
  gstore
}

fgi () {
  git add . && git commit -m ".gitignore fix start"
  git rm -r --cached .
  git add . && git commit -m ".gitignore fix"
  git push
}