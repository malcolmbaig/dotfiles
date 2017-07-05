#!/bin/sh
set -e

DIR='/Users/malcolm/Dropbox/_dev-env/dotfiles'

# Dev environment deps
# brew tap neovim/neovim
# brew install neovim tmux the_silver_searcher python3 fzf ack rbenv

# NVIM
mkdir -p ~/.config/nvim
ln -sf "$DIR/nvim/init.vim" ~/.config/nvim/init.vim
ln -sf "$DIR/nvim/spell" ~/.config/nvim/spell

# SSH
ln -sf "$DIR/ssh/config" ~/.ssh/config

# GIT
ln -sf "$DIR/git/gitignore-global" ~/.gitignore-global
ln -sf "$DIR/git/git-template" ~/.git-template
ln -sf "$DIR/git/gitmessage" ~/.gitmessage
ln -sf "$DIR/git/gitconfig" ~/.gitconfig

# Bundler
ln -sf "$DIR/bundler/config" ~/.bundle/config

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

# CTags
ln -sf "$DIR/ctags/ctag_config" ~/.ctags

