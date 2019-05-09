#!/bin/bash

p4merge ~/.bash_profile ./bash_profiles/.bash_profile
p4merge ~/.bashrc ./bash_profiles/.bashrc
p4merge ~/.bash_aliases ./bash_profiles/.bash_aliases

read -p "Sync these changes to folder (y/N)? " -n 1 -r doSync
printf "\n"
if [[ $doSync =~ [Yy] ]]; then
    cp ~/.bash_profile ~/.bashrc ~/.bash_aliases bash_profiles
fi
