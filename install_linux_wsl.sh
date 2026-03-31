# Initialize git
bash scripts/init_git_submodules.sh

# Simple script that will install all the dotfiles in the appropriate directory
cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./global.gitignore ~/.gitignore
