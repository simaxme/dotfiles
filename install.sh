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
    cp -r ./wireplumber ~/.config
    cp -r ./sway ~/.config
    cat ./sway/config | sed "s/%DISPLAY_NAME%/$(cat display.txt || echo DP-7)/g" > ~/.config/sway/config
    cp -r ./swaylock ~/.config
    cp -r ./swayidle ~/.config
    cp -r ./waybar ~/.config
    cp -r ./rofi ~/.config
    cp -r ./gtk-3.0 ~/.config
    cp -r ./dunst ~/.config
    cp -r ./spotify-launcher.conf ~/.config

    xdg-mime default "firefox.desktop" "application/pdf"
    xdg-mime default "thunar.desktop" "inode/directory"
  fi
fi
