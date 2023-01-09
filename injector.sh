#!/usr/bin/bash

sudo apt install curl make gcc libx11-dev libxft-dev libxinerama-dev libxtst-dev libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev libxcb-res0-dev
sudo apt install fonts-font-awesome

chmod +x ./install_source-pro_font.sh

./install_source-pro_font.sh

cp ./vimrc ~/.vimrc

cd ./dwm-6.2

sudo make clean install

cd ../dmenu-5.0

sudo make clean install

cd ../dwmblocks-async

sudo make clean install

cd ../st-0.8.4

sudo make clean install

sudo cp ../dwm.desktop /usr/share/xsessions



