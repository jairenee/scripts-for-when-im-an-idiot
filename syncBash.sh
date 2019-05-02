#!/bin/bash

p4merge ~/.bash_profile ./bash_profiles/.bash_profile
p4merge ~/.bashrc ./bash_profiles/.bashrc

read -p "Sync these changes to folder (y/N)? " -n 1 -r doSync
printf "\n"
if [[ $doSync =~ [Yy] ]]; then
    cp ~/.bash_profile ~/.bashrc bash_profiles
fi
