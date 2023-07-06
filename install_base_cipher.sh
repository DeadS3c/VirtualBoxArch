#!/bin/bash
loadkeys es # Change the keyboard
fdisk -l # Check the disks
# Make the partitions
parted /dev/sda mklabel msdos 
parted /dev/sda mkpart primary ext4 1MiB 500MiB 
parted /dev/sda set 1 boot on 
parted /dev/sda mkpart primary ext4 500MiB 100%
# Check if everything goes right
parted /dev/sda align-check optimal 1

# Cipher
## Create container with the password
cryptsetup luksFormat /dev/sda2
## Open container
cryptsetup open /dev/sda2 cryptlvm
## Create physical volume
pvcreate /dev/mapper/cryptlvm
## Create a volume group
vgcreate CryptVolume /dev/mapper/cryptlvm
### Create all the partitions on the volume group
#### SWAP
lvcreate -L 4G CryptVolume -n swap
#### Root Partition
lvcreate -L 20G CryptVolume -n root
#### Home Partition
lvcreate -l 100%FREE CryptVolume -n home
### Format the file system
mkfs.ext4 /dev/CryptVolume/root
mkfs.ext4 /dev/CryptVolume/home
mkswap /dev/CryptVolume/swap

# Format boot
mkfs.ext4 /dev/sda1

# Mount the system
mount /dev/CryptVolume/root /mnt
mount --mkdir /dev/CryptVolume/home /mnt/home
swapon /dev/CryptVolume/swap
## Boot
mount --mkdir /dev/sda1 /mnt/boot

# Install base packages to work with
pacstrap -K /mnt base linux linux-firmware git vim base-devel grub \
    networkmanager xdg-user-dirs dhcpcd pacman-contrib lvm2

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Enter chroot
arch-chroot /mnt
