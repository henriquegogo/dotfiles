echo "Copying files..."
cat .bashrc >> ~/.bashrc
cp -n .vimrc ~/.vimrc
cp -n .screenrc ~/.screenrc
cp -n .gitconfig ~/.gitconfig
echo; echo "Done!"
