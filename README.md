## Installation
```sh
git clone https://github.com/henriquegogo/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.vimrc ~/.vimrc                 # For Vim
ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim  # For NeoVim
```
## Loadenv and binaries
- Create a local folder ~/opt
- Download pre-built binaries to ~/opt
- They will be auto added to PATH and envvars
