#!/bin/bash

# Installation inside the chroot

# Adjust timezone
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
# Adjust clock
hwclock --systohc

# Change the language
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
locale-gen

# Change the language variable
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Change the keyboard map
echo "KEYMAP=es" > /etc/vconsole.conf

# Change the hostname
echo "Archy" > /etc/hostname

# Install grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Set root passwd
passwd

# Create a normal user to operate with
useradd -m -g users -G storage,video,optical,audio,wheel,power,scanner -s /bin/bash archy
passwd archy

# Edit the sudoers to give our user sudo permission
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Enable Network Manager
systemctl enable NetworkManager.service

# Change mirror list and choose the fastest 10
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
awk '/^## Country Name$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Update & Upgrade
## Blackarch
### Download the installation script
curl -O https://blackarch.org/strap.sh
### Execute the script
chmod +x strap.sh
./strap.sh
### Include multilib in our pacman (needed for blackarch)
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
### Update pacman
pacman -Syu --noconfirm
### Delete the instalation script
rm strap.sh

## Graphic server
pacman -S --noconfirm xorg-server xorg-xinit
## Display manager
pacman -S --noconfirm lightdm lightdm-gtk-greeter
## Window manager
pacman -S --noconfirm spectrwm
## Basic Tools
pacman -S --noconfirm git virtualbox-guest-utils xcompmgr rxvt-unicode \
    urxvt-perls feh unclutter nmap lynx tor qutebrowser dmenu xclip \
    ttf-jetbrains-mono-nerd ttf-joypixels xlockmore zsh openssh

# Configuracion
## Yay
su archy
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
#### Fonts yay
yay -Syu ttf-symbola
exit

## Display Manager
### Enable the service
systemctl enable lightdm.service
### Configure the service to autologin with our user
sed -i 's/#logind-check-graphical=true/logind-check-graphical=true/' /etc/lightdm/lightdm.conf
sed -i 's/#pam-service=lightdm/pam-service=lightdm/' /etc/lightdm/lightdm.conf
sed -i 's/#pam-autologin-service=lightdm-autologin/pam-autologin-service=lightdm-autologin/' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-guest=false/autologin-guest=false/' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-user=/autologin-user=archy/' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-user-timeout=0/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
sed -i 's/#autologin-session=/autologin-session=spectrwm/' /etc/lightdm/lightdm.conf
#### Change the user to be able to autologin without password
groupadd -r autologin
gpasswd -a archy autologin
groupadd -r nopasswdlogin
gpasswd -a archy nopasswdlogin
#### Modify pam to allow the user to autologin without password
sed '2i\auth      sufficient  pam_succeed_if.so user ingroup nopasswdlogin\' /etc/pam.d/lightdm

## Virtual Box
systemctl enable vboxservice.service
systemctl start vboxservice.service

## Spectrwm
### Configure spectrwm
su archy -
cd /tmp/
#### Clone the repo with the configuration
git clone https://github.com/DeadS3c/VirtualBoxArch
cd VirtualBoxArch/spectrwm
cp -R . ~/
### Configure the shell
chsh -s /usr/bin/zsh

# Exit the chroot and poweroff
exit
