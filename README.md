# Installation
```sh
git clone https://github.com/henriquegogo/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/.vimrc ~/.vimrc                 # For Vim
ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim  # For NeoVim
```
# .tmux.conf
Changes prefix to C-a and set some colors and default settings

# .bash_aliases
Prompt config and bash functions
### google "Why the sky is blue"
Search in google using lynx terminal browser. Quotes are optional
### gitlog
Show git log in terminal with some format and colors
### gitsync
Update all repositories in a folder
### loadenv ./folder
Load folder into env variables. ./bin into $PATH, ./lib into $LD_LIBRARY_PATH and others. Auto add every ~/opt/* as default
### chrootstart ./folder
Mount dev, proc, sys, tmp, etc and start a chroot in folder

# .vimrc
Vim and NeoVim default settings, theme, commands and functions
- Netrw can be used as a file explorer :Lexplorer
- Default theme colors based on onedark theme
- Personalized statusline
- Buffers and tab navigation keymaps
- Insert chars in line beginning. Works in normal and visual mode. Good for comment line: \<Space\>0
- Surround keymaps: \<Space\>', \<Space\>", \<Space\>(, \<Space\>{, \<Space\>[
- Begining words and surround chars can be removed using double char: \<Space\>00, \<Space\>'' 
### :Find
Use shell "find" command to search file names recursively. Keymap: \<Leader\>e
### :Search
Use shell "rg" or "grep" command to search text in files recursively. Keymap: \<Leader\>/
### :PluginInstall, :PluginRemove, :PluginUpdate, :PluginList
Manage plugins into packages folder. PluginInstall can be used as "call PluginInstall('author/plugin') as well. Some default plugins are being installed

# Disclaimer
These are my personal settings. You can use them as you wish, but I use to change a lot sometimes
