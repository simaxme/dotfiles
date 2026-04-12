#!/usr/bin/env bash

cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./global.gitignore ~/.gitignore


if ! uname -r | grep -q "microsoft"; then
  # MacOS or Linux (not WSL)
  cp -r ./kitty ~/.config/
  cp ./.ideavimrc ~/
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  :
else
  # Linux
  :

  if uname -r | grep -q "microsoft"; then
    # Linux (WSL)
    :
  else
    # Linux (Not WSL)
    cp -r ./pipewire ~/.config
  fi
fi
