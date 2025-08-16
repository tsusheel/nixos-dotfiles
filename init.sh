#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
echo $SHELL

ln -sf ~/Wallpapers/night_sky_island.jpg ~/.config/hypr/current-wallpaper
