echo "Copying files..."
cat .bashrc >> ~/.bashrc
cat .gitconfig >> ~/.gitconfig
cp -n .vimrc ~/.vimrc
cp -n .screenrc ~/.screenrc
echo; echo "Done!"
