# VirtualBoxArch
Repository to build Arch Linux for Virtualbox automatically  
This is my main configuration and it makes use of a lot of vim keybindings, including the terminal.  
So if you are not comfortable with vim, maybe you should use another configuration

# Installation
**IMPORTANT**

The installation uses the following partition with the keymap es by default so it's important to have that minimum space

500Mb for the /boot  
20Gb for the /  
4Gb for the swap  
The rest for the /home  

## Base
Start the iso file of Arch Linux on VirtualBox and load your keymap

`loadkeys <keymap>`

Download the install_base.sh with: 

`curl -O https://raw.githubusercontent.com/DeadS3c/VirtualBoxArch/main/install_base.sh`

Give it permissions and execute it: 

`chmod +x install_base.sh && ./install_base.sh`

## Environment and configuration
Once it ends the base installation inside the chroot download and execute the install_chroot.sh

`curl -O https://raw.githubusercontent.com/DeadS3c/VirtualBoxArch/main/install_chroot.sh`

`chmod +x install_chroot.sh && ./install_chroot.sh`

Outside the chroot execute the following to end the installation process

`umount -R /mnt`

`poweroff`
