CopyFile /etc/sudoers.d/wheel 440

AddUser root '!*' 0 0 '' '' /root /bin/bash root
AddUser bin '!*' 1 1 '!' '' / /usr/bin/nologin sys,daemon
AddUser daemon '!*' 2 2 '!' '' / /usr/bin/nologin adm,bin
AddUser mail '!*' 8 12 '!' '' /var/spool/mail /usr/bin/nologin ''
AddUser ftp '!*' 14 11 '!' '' /srv/ftp /usr/bin/nologin ''
AddUser http '!*' 33 33 '!' '' /srv/http /usr/bin/nologin ''
AddUser nobody '!*' 65534 65534 '!' Nobody / /usr/bin/nologin ''
AddUser dbus '!*' 81 81 '!' 'System Message Bus' / /usr/bin/nologin ''
AddUser systemd-journal-remote '!*' 981 981 '!' 'systemd Journal Remote' / /usr/bin/nologin ''
AddUser systemd-network '!*' 980 980 '!' 'systemd Network Management' / /usr/bin/nologin ''
AddUser systemd-oom '!*' 979 979 '!' 'systemd Userspace OOM Killer' / /usr/bin/nologin ''
AddUser systemd-resolve '!*' 978 978 '!' 'systemd Resolver' / /usr/bin/nologin ''
AddUser systemd-timesync '!*' 977 977 '!' 'systemd Time Synchronization' / /usr/bin/nologin ''
AddUser systemd-coredump '!*' 976 976 '!' 'systemd Core Dumper' / /usr/bin/nologin ''
AddUser uuidd '!*' 68 68 '!' '' / /usr/bin/nologin ''
AddUser $USER_NAME "$USER_HASHED_PASSWORD" $USER_UID $USER_GID '!' '' $USER_HOME /bin/bash sys,ftp,mail,log,games,network,adm,wheel,tty,audio,input,kvm,lp,storage,uucp,video,systemd-journal,rfkill,http,dbus,vboxusers,docker
AddUser polkitd '!*' 102 102 '!' 'PolicyKit daemon' / /usr/bin/nologin proc
AddUser avahi '!*' 974 974 '!' 'Avahi mDNS/DNS-SD daemon' / /usr/bin/nologin ''
AddUser colord '!*' 973 973 '!' 'Color management daemon' /var/lib/colord /usr/bin/nologin ''
AddUser rtkit '!*' 133 133 '!' RealtimeKit /proc /usr/bin/nologin ''
AddUser git '!*' 972 972 '!' 'git daemon user' / /usr/bin/git-shell ''
AddUser geoclue '!*' 971 971 '!' 'Geoinformation service' /var/lib/geoclue /usr/bin/nologin ''
AddUser tss '!*' 970 970 '!' 'tss user for tpm2' / /usr/bin/nologin ''
AddUser cups '!*' 209 209 '!' 'cups helper user' / /usr/bin/nologin lp
AddUser mosquitto '!*' 969 969 '!' 'Mosquitto MQTT Broker' /var/empty /usr/bin/nologin ''
AddUser usbmux '!*' 140 140 '!' 'usbmux user' / /usr/bin/nologin ''
AddUser ldap '!*' 439 439 '!' 'LDAP Server' /var/lib/openldap /usr/bin/nologin ''
AddUser systemd-journal-upload '!*' 967 967 '!' 'systemd Journal Upload' / /usr/bin/nologin ''
AddUser _talkd '!*' 965 965 '!' 'User for legacy talkd server' / /usr/bin/nologin ''
AddUser greeter '!*' 963 963 '!' 'greetd greeter user' / /bin/bash video
AddGroup sys '!' 3
AddGroup mem '!' 8
AddGroup log '!' 19
AddGroup smmsp '!' 25
AddGroup proc '!' 26
AddGroup games '!' 50
AddGroup lock '!' 54
AddGroup network '!' 90
AddGroup floppy '!' 94
AddGroup scanner '!' 96
AddGroup power '!' 98
AddGroup adm '!' 999
AddGroup wheel '!' 998
AddGroup kmem '!' 997
AddGroup tty '!' 5
AddGroup utmp '!' 996
AddGroup audio '!' 995
AddGroup disk '!' 994
AddGroup input '!' 993
AddGroup kvm '!' 992
AddGroup lp '!' 991
AddGroup optical '!' 990
AddGroup render '!' 989
AddGroup sgx '!' 988
AddGroup storage '!' 987
AddGroup uucp '!' 986
AddGroup video '!' 985
AddGroup users '!' 984
AddGroup systemd-journal '!' 983
AddGroup rfkill '!' 982
AddGroup vboxusers '!' 108
AddGroup docker '!' 968
AddGroup groups '!' 966
AddGroup seat '!' 964

CopyFile /etc/systemd/system/rescue.service.d/SYSTEMD_SULOGIN_FORCE.conf