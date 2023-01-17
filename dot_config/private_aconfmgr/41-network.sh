# hosts
echo $HOSTNAME >"$(CreateFile /etc/hostname)"

cat >"$(CreateFile /etc/hosts)" <<EOF
#
# /etc/hosts: static lookup table for host names
#
#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1		localhost.localdomain	localhost
::1				localhost.localdomain	localhost
127.0.0.1		$HOSTNAME.localdomain	$HOSTNAME
EOF

# utility
AddPackage inetutils
AddPackage net-tools
AddPackage nethogs
AddPackage netstat-nat
AddPackage iptraf-ng
AddPackage traceroute

# ssh
AddPackage openssh
CopyFile /etc/ssh/ssh_config.d/99-custom.conf

# davfs2
AddPackage --foreign davfs2
CopyFile /etc/davfs2/davfs2.conf

cat >> "$(CreateFile /etc/davfs2/secrets)" <<EOF
$GOODCLOUD_URL $GOODCLOUD_LOGIN $GOODCLOUD_PASSWORD
EOF

# DNS
CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
SystemdEnable systemd /usr/lib/systemd/system/systemd-resolved.service

# network manager

AddPackage libmicrodns    # Minimal mDNS resolver library
AddPackage netctl         # Profile based systemd network management
AddPackage networkmanager # Network connection manager and user applications

AddPackage wireless-regdb
AddPackage wireless_tools
AddPackage iwd
CreateDir /etc/iwd
SystemdEnable wpa_supplicant /usr/lib/systemd/system/wpa_supplicant.service
SystemdEnable networkmanager /usr/lib/systemd/system/NetworkManager-dispatcher.service
SystemdEnable networkmanager /usr/lib/systemd/system/NetworkManager.service
SystemdEnable networkmanager /usr/lib/systemd/system/NetworkManager-wait-online.service