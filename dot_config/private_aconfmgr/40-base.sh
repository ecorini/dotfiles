# core packages
AddPackage base
AddPackage base-devel

# localization
echo "LANG=$LOCALE" >"$(CreateFile /etc/locale.conf)"
echo "KEYMAP=$KEYMAP" >"$(CreateFile /etc/vconsole.conf)"

sed -i -e "s/^#\($LOCALE\)/\1/g" \
  -e "s/^#\(it_IT.UTF-8 UTF-8\)/\1/g" \
  $(GetPackageOriginalFile glibc /etc/locale.gen)

CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Rome
CreateLink /etc/os-release ../usr/lib/os-release

# kernel
AddPackage linux
AddPackage linux-firmware
CopyFile /etc/modprobe.d/nobeep.conf
CopyFile /etc/mkinitcpio.d/linux.preset
CopyFile /etc/mkinitcpio.conf

# filesystem
AddPackage ntfs-3g
AddPackage exfat-utils
AddPackage lvm2
AddPackage fuse3
CopyFile /etc/fstab

# systemd-boot
AddPackage efibootmgr

# editors
AddPackage nano

# package manager
AddPackage pacman-contrib
AddPackage --foreign yay-bin
AddPackage reflector
CopyFile /etc/xdg/reflector/reflector.conf
SystemdEnable reflector /usr/lib/systemd/system/reflector.timer

# utilities
AddPackage man-db
AddPackage p7zip
AddPackage btop
AddPackage perf
AddPackage wget
AddPackage inotify-tools
AddPackage lsb-release
AddPackage unarchiver # unar and lsar: Objective-C tools for uncompressing archive files

AddPackage --foreign backrest
SystemdEnable --name backrest@$USER_NAME.service backrest /usr/lib/systemd/system/backrest@.service

AddPackage dmidecode # Desktop Management Interface table related utilities

SystemdEnable util-linux /usr/lib/systemd/system/fstrim.timer

# disk management
AddPackage hdparm
AddPackage sdparm
AddPackage udisks2
AddPackage zram-generator
CopyFile /etc/systemd/zram-generator.conf

# bluetooth
AddPackage bluez
AddPackage bluez-hid2hci
AddPackage bluez-utils
AddPackage --foreign bluetui-bin
SystemdEnable bluez /usr/lib/systemd/system/bluetooth.service

# shell
AddPackage zsh

# power management
AddPackage acpid
AddPackage tlp # Linux Advanced Power Management
AddPackage thermald # The Linux Thermal Daemon program from 01.org
SystemdEnable thermald /usr/lib/systemd/system/thermald.service

# drivers
AddPackage intel-ucode

# usb
AddPackage usbutils

# java
AddPackage jre8-openjdk
CreateLink /usr/lib/jvm/default java-8-openjdk/jre
CreateLink /usr/lib/jvm/default-runtime java-8-openjdk/jre

# laptop tools
AddPackage brightnessctl # Lightweight brightness control tool

# These seem to be changed somehow
SetFileProperty /usr/bin/groupmems group groups
SetFileProperty /usr/bin/groupmems mode 2750

# systemd
SystemdEnable --name getty@tty1.service systemd /usr/lib/systemd/system/getty@.service
SystemdEnable systemd /usr/lib/systemd/system/remote-fs.target
SystemdEnable systemd /usr/lib/systemd/system/systemd-timesyncd.service
SystemdEnable systemd /usr/lib/systemd/system/systemd-userdbd.socket
sed -i -e "s/^#HandleLidSwitch=.*$/HandleLidSwitch=ignore/g" \
  -e "s/^#HandleLidSwitchExternalPower=.*$/HandleLidSwitchExternalPower=ignore/g" \
  $(GetPackageOriginalFile systemd /etc/systemd/logind.conf)
