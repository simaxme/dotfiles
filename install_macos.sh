# Simple script that will install all the dotfiles in the appropriate directory
cp ./.ideavimrc ~/
cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./global.gitignore ~/.gitignore

# Kitty
cp -r ./kitty ~/.config/
