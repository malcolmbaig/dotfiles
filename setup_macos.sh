#! /bin/sh

# Install XCode and brew before running

brew install --cask 1password
brew install --cask dropbox
brew install --cask ghostty
brew install --cask obsidian
brew install --cask rectangle
brew install --cask zen-browser

brew install asdf
brew install bat
brew install coreutils
brew install ctags
brew install delta
brew install eza
brew install fzf
brew install lazygit
brew install neovim
brew install ripgrep
brew install starship
brew install stow
brew install tmux
brew install tmuxp
brew install zsh

cd ~/dotfiles
stow aliases asdf ctags fzf ghostty git nvim ripgrep starship tmux zsh
