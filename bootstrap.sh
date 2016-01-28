#!/bin/sh
set -e

DIR='/Users/mo/Dropbox/_dev-env/dotfiles'

# NVIM
# Move colorschemes manually
mkdir -p ~/.config/nvim
ln -sf "$DIR/nvim/init.vim" ~/.config/nvim/init.vim

# SSH
ln -sf "$DIR/ssh/config" ~/.ssh/config

# GIT
ln -sf "$DIR/git/gitignore-global" ~/.gitignore-global
ln -sf "$DIR/git/git-template" ~/.git-template
ln -sf "$DIR/git/gitmessage" ~/.gitmessage
ln -sf "$DIR/git/gitconfig" ~/.gitconfig

# ZSH
ln -sf "$DIR/zprezto/" ~/.zprezto
ln -sf ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -sf ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -sf ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/.zprezto/runcoms/zshenv ~/.zshenv
ln -sf ~/.zprezto/runcoms/zlogin ~/.zlogin

# Tmux
ln -sf "$DIR/tmux" ~/.tmux
ln -sf "$DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$DIR/tmux/tmuxline_snapshot" ~/.tmuxline_snapshot
