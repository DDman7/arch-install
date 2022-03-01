#!/bin/bash

timedatectl set-timezone Australia/Sydney # Set the time zone

hwclock --systohc # To generate /etc/adjtime

locale-gen # Generate locales

touch /etc/locale.conf # Create the locale.conf file
echo LANG=en_AU.UTF-8 >> /etc/locale.conf # Append the specified text to the specified file.
export LANG=en_AU.UTF-8 # No idea

echo david-danyal > /etc/hostname # Set my network hostname
touch /etc/hosts # Create the hosts file
echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 david-danyal" >> /etc/hosts # Append something I don't understand to this file.

(
echo 1999
echo 1999
) | passwd # Setting the root user password

pacman -S --noconfirm grub efibootmgr # Downloading and installing the boot loader

mkdir /boot/efi # Create a directory to mount the EFI partition onto
mount /dev/vda1 /boot/efi # Mount the EFI partition to the specified directory

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi # Install the grub boot loader
grub-mkconfig -o /boot/grub/grub.cfg # Create the grub config file

pacman -S --noconfirm xorg # Download and install the xorg display server
pacman -S --noconfirm xfce4 xfce4-goodies lxdm networkmanager # Download and install extra software

systemctl enable NetworkManager.service # Enable the networkmanager service with systemd
systemctl enable lxdm.service # Enable the lxdm display manager service with systemd

exit # Exit the chroot environment
