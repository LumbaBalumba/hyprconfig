#!/bin/bash
# yay -S - <yay-packages
sudo cp tmux pypoetry i3 i3status alacritty nvim clangd qt5ct kitty ranger hypr mako neofetch swaync waybar wob wofi btop /home/i3alumba/.config -r
cp ./.zshrc /home/i3alumba/
cp ./.clang-format /home/i3alumba/
cp ./.p10k.zsh /home/i3alumba/
cp ./.latexmkrc /home/i3alumba/
sudo cp ./.oh-my-zsh /home/i3alumba/ -r
gsettings set org.gnome.desktop.interface gtk-theme Dracula
