sudo pacman -S base-devel
cd ~
mkdir code
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay bat
yay dropbox
yay fzf
yay git-delta
yay iosevka-fixed
yay neovim
yay rbenv
yay ripgrep
yay stow
yay tig
yay tmux

cd ~/.dotfiles
stow aliases ctags fzf git konsole nvim tig tmux zsh
