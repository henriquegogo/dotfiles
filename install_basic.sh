echo "Copying files..."
cat .bashrc >> ~/.bashrc
cp -n .vimrc ~/.vimrc
cp -n .screenrc ~/.screenrc
cp -n .gitconfig ~/.gitconfig
cp -n .npmrc ~/.npmrc
echo; echo "Done!"
