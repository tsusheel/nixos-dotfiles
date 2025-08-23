# .config symlinks
ln -s $config_path/alacritty $HOME/.config/alacritty
ln -s $config_path/hypr $HOME/.config/hypr
ln -s $config_path/imv $HOME/.config/imv
ln -s $config_path/rofi $HOME/.config/rofi
ln -s $config_path/swaync $HOME/.config/swaync
ln -s $config_path/waybar $HOME/.config/waybar

# .local symlink for the pwa
ln -s $local_path/share/applications $HOME/.local/share/applications

# Symlink for the default wallpaper
ln -sf $HOME/$project_name/Wallpapers/night_sky_island.jpg $config_path/hypr/current-wallpaper
