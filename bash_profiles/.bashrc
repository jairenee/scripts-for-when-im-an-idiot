# .bashrc

# Source global definitions
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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias dev="cd ~/Development"
alias pdev="pushd ~/Development"
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ll="ls -la"
alias pdev="pushd ~/Development"
alias ldev="ls -la ~/Development"

alias sshjenk="ssh -i ~/.ssh/jenkins_master.pem centos@10.17.4.116"
alias sshslaved="ssh -i ~/.ssh/btdev-ec2-keypair.pem centos@10.12.40.95"
alias sshslaver="ssh -i ~/.ssh/jenkins-release.pem centos@10.12.39.22"
alias sshslavede="ssh -i ~/.ssh/btdev-ec2-keypair.pem centos@10.12.46.89"
alias sshslaves="ssh -i ~/.ssh/jenkins-stage.pem centos@10.16.109.242"
alias sshslavese="ssh -i ~/.ssh/jenkins-stage.pem ec2-user@10.16.111.66"
alias sshslavep="ssh -i ~/.ssh/jenkins-prod.pem centos@10.12.161.147"
alias sshslavepe="ssh -i ~/.ssh/jenkins-prod.pem centos@10.12.175.11"

alias ebr="vi ~/.bashrc"
alias ebp="vi ~/.bash_profile"
alias ebh="vi ~/docs/ahelp.txt"
alias sbp="source ~/.bash_profile"

alias ti="cppv && terraform init"
alias ta="terraform apply"
alias tpl="terraform plan"
alias tfd="cd terraform/dev"
alias tfs="cd terraform/stage"
alias tfp="cd terraform/prod"
alias otf="cd terraform && e && cd dev"

alias c="clear"
alias e="code ."

dockclean () {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

mcd () {
  dirname=$1
  mkdir $1
  cd $1
}

mke () {
  mcd $1
  e
}

alias proma="tfpromote -a"

alias gst="git status"
alias gstore="git config credential.helper store"
alias gcm="git pull && git add . && git commit && git push"
alias gcp="gc -p"
alias gp="git push"

alias eeegp="git add . && git commit -m 'This is an emergency commit because of a building evacuation or other sudden major event.' && git push"
alias ahelp="cat ~/docs/ahelp.txt"
alias ehelp="vi ~/docs/ahelp.txt"

alias ecrd='$(aws ecr get-login --no-include-email --region us-east-1 --profile btdev-jwissner)'
alias ecrs='$(aws ecr get-login --no-include-email --region us-east-1 --profile btstage-jwissner)'
alias ecrp='$(aws ecr get-login --no-include-email --region us-east-1 --profile btprod-jwissner)'

alias xclipb='xclip -selection clipboard'

alias edex='nohup ~/Downloads/eDEX-UI.Linux.x86_64.AppImage &>/dev/null &'

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

alias remove='/bin/rm -irv'

function rm () {
  echo "rm is disabled. Use remove instead."
}

ugtf () {
  olddir=$(pwd)
  cd ~/bin/Hashicorp
  python upgrade.py
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

svars () {
  pushd ~/Development/envvars && git pull
  popd && cp ~/Development/envvars/tfvars/stage.auto.tfvars .
}

pvars () {
  pushd ~/Development/envvars && git pull
  popd && cp ~/Development/envvars/tfvars/prod.auto.tfvars .  
}

dvars () {
  pushd ~/Development/terraform && git pull
  popd
  cp --verbose ~/Development/terraform/dev/dev-us-east-1/dev-provider.tf .;
  cp --verbose ~/Development/terraform/dev/dev-us-east-1/dev.auto.tfvars .; 
}

source ~/cppv.sh
