sudo pacman -S base-devel
cd ~
mkdir code
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay dropbox
yay stow
yay fzf
yay tig
yay tmux
yay neovim
yay rbenv
yay git-delta
yay xsel
yay iosevka-fixed

cd ~/.dotfiles
stow aliases ctags fzf.linux git nvim tig tmux zsh konsole
