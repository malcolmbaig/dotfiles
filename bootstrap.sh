#! /usr/bin/sh

# Install paru https://github.com/Morganamilo/paru

paru stow
cd ~/dotfiles
stow aliases asdf ctags fzf git konsole nvim ripgrep starship tmux zsh
source ~/.aliases

paru asdf
paru bat
paru ctags
paru dropbox
paru fzf
paru git-delta
paru github
paru lazygit
paru neovim
paru ripgrep
paru starship
paru tmux
