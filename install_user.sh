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

## Tools
### Enum
#### ffuf
go install github.com/ffuf/ffuf/v2@latest
#### Nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
#### Katana
go install github.com/projectdiscovery/katana/cmd/katana@latest
#### Subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
#### Httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
#### Waybackurls
go install github.com/tomnomnom/waybackurls@latest
#### Unfurl
go install github.com/tomnomnom/unfurl@latest
#### anew
go install -v github.com/tomnomnom/anew@latest

### Dicctionaries
cd ~/
mkdir -p tools/dictionaries
cd tools/dictionaries
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/six2dez/OneListForAll.git

exit
