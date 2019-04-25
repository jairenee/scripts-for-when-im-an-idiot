#!/bin/bash

rsync -a --exclude='*/.git' --exclude='*.pack' --exclude='*.idx' ~/.vim_runtime ./vim
cp -r ~/.vimrc ~/vimwiki ~/.vim ./vim
rm -r vim/.vim/.VimballRecord vim/.vim/.netrwhist
