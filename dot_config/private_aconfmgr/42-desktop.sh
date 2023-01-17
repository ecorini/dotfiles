# video drivers
AddPackage xf86-video-intel

# wayland / hyrprland
AddPackage hypridle                    # hyprland’s idle daemon
AddPackage hyprland                    # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprpaper                   # a blazing fast wayland wallpaper utility with IPC controls
AddPackage wl-clipboard                # Command-line copy/paste utilities for Wayland
AddPackage wev                         # A tool for debugging wayland events on a Wayland window, analagous to the X11 tool xev
AddPackage xdg-desktop-portal-hyprland # xdg-desktop-portal backend for hyprland
AddPackage xorg-xeyes
AddPackage --foreign clipse # A configurable TUI clipboard manager for Unix.

# notification
AddPackage dunst

# bars and menu
AddPackage ttf-jetbrains-mono       # Typeface for developers, by JetBrains
AddPackage ttf-jetbrains-mono-nerd  # Patched font JetBrains Mono from nerd fonts library
AddPackage bemenu                   # Dynamic menu library and client program inspired by dmenu
AddPackage waybar                   # Highly customizable Wayland bar for Sway and Wlroots based compositors
AddPackage --foreign waybar-updates # Tiny Waybar module to check Arch Linux updates from official repositories and AUR

# screen locker
AddPackage hyprlock # hyprland’s GPU-accelerated screen locking utility

# multiple screen
AddPackage arandr
AddPackage autorandr

# gtk
AddPackage gtk-engine-murrine
AddPackage arc-gtk-theme
AddPackage adapta-gtk-theme
AddPackage breeze-gtk
AddPackage lxappearance-gtk3
AddPackage nwg-look # GTK3 settings editor adapted to work on wlroots-based compositors

AddPackage gnome-keyring
SystemdEnable --type user p11-kit /usr/lib/systemd/user/p11-kit-server.socket
SystemdEnable --type user gcr-4 /usr/lib/systemd/user/gcr-ssh-agent.socket
SystemdEnable --type user gnome-keyring /usr/lib/systemd/user/gnome-keyring-daemon.socket

AddPackage gucharmap

# Icons
AddPackage arc-icon-theme

# screenshot
AddPackage slurp  # Select a region in a Wayland compositor
AddPackage swappy # A Wayland native snapshot editing tool
AddPackage grim   # Screenshot utility for Wayland
AddPackage otf-font-awesome

# audio
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wireplumber    # Session / policy manager implementation for PipeWire
AddPackage imv            # Image viewer for Wayland and X11
SystemdEnable --type user wireplumber /usr/lib/systemd/user/wireplumber.service
SystemdEnable --type user pipewire /usr/lib/systemd/user/pipewire.socket
SystemdEnable --type user pipewire-pulse /usr/lib/systemd/user/pipewire-pulse.socket

# fonts
AddPackage ttf-dejavu

# Login manager
AddPackage greetd
AddPackage greetd-tuigreet # A console UI greeter for greetd
CopyFile /etc/greetd/config.toml
SystemdEnable greetd /usr/lib/systemd/system/greetd.service
