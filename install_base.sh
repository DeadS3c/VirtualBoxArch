#!/bin/bash
loadkeys es # Change the keyboard
fdisk -l # Check the disks
# Make the partitions
parted /dev/sda mklabel msdos 
parted /dev/sda mkpart primary ext4 1MiB 500MiB 
parted /dev/sda set 1 boot on 
parted /dev/sda mkpart primary ext4 500MiB 20GiB
parted /dev/sda mkpart primary linux-swap 20GiB 24GiB
parted /dev/sda mkpart primary ext4 25GiB 100%
# Check if everything goes right
parted /dev/sda align-check optimal 1

# Format partitions
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4
mkswap /dev/sda3

# Mount the system
swapon /dev/sda3 # SWAP
mount --mkdir /dev/sda1 /mnt/boot # Boot
mount --mkdir /dev/sda2 /mnt # Root
mount --mkdir /dev/sda4 /mnt/home

# Install base packages to work with
pacstrap -K /mnt base linux linux-firmware git vim base-devel grub networkmanager xdg-user-dirs dhcpcd pacman-contrib

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Enter chroot
arch-chroot /mnt
