# VirtualBoxArch
Repository to build Arch Linux for Virtualbox automatically

# Installation
## Base
Start the iso file of Arch Linux on VirtualBox
Download the install_base.sh with: `curl -O https://raw.githubusercontent.com/DeadS3c/VirtualBoxArch/main/install_base.sh`
Give it permissions and execute it `chmod +x install_base.sh && ./install_base.sh`
## Environment and configuration
Once it ends the base installation inside the chroot download and execute the install_chroot.sh
`curl -O https://raw.githubusercontent.com/DeadS3c/VirtualBoxArch/main/install_chroot.sh`
`chmod +x install_chroot.sh && ./install_chroot.sh`
Outside the chroot execute the following to ends the installation process
`umount -R /mnt`
`poweroff`
