#!/bin/bash

# Installation & configuration of the user
## Yay
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
#### Fonts yay
yay -Syu --noconfirm ttf-symbola
cd /tmp


## Spectrwm
### Configure spectrwm
#### Clone the repo with the configuration
git clone https://github.com/DeadS3c/VirtualBoxArch
cd VirtualBoxArch/spectrwm
cp -R . ~/
### Configure the shell
chsh -s /usr/bin/zsh
cd /tmp

exit
