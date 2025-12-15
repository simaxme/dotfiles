# Initialize git
bash scripts/init_git_submodules.sh

# Simple script that will install all the dotfiles in the appropriate directory
cp ./.ideavimrc ~/
cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./global_gitignore ~/.gitignore

# Kitty
cp -r ./kitty ~/.config/
cp ./external_repos/catppuccin-kitty/themes/diff-mocha.conf ~/.config/kitty/theme.conf
cat ./external_repos/catppuccin-kitty/themes/mocha.conf >> ~/.config/kitty/theme.conf
