# /boot
IgnorePath '/boot'
IgnorePath '/boot/*'

# /etc
IgnorePath '/etc/.updated'
IgnorePath '/etc/adjtime'
IgnorePath '/etc/*.cache'
IgnorePath '/etc/*-'
IgnorePath '/etc/ca-certificates/extracted'
IgnorePath '/etc/docker/key.json'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/ld.so.cache' # "File containing an ordered list of libraries found in the directories specified in /etc/ld.so.conf
IgnorePath '/etc/.pwd.lock'   # passwd; http://blog.dailystuff.nl/2011/08/the-hunt-for-etc-pwd-lock/
IgnorePath '/etc/NetworkManager/system-connections/*'
IgnorePath '/etc/pacman.d/gnupg'
IgnorePath '/etc/pacman.d/mirrorlist*'
IgnorePath '/etc/shells'
IgnorePath '/etc/ssl/certs'
IgnorePath '/etc/udev/hwdb.bin'
IgnorePath '/etc/fonts/conf.d/*'
IgnorePath '/etc/group'
IgnorePath '/etc/passwd'
IgnorePath '/etc/shadow'
IgnorePath '/etc/gshadow'

# /usr
IgnorePath '/usr/*/*.egg-info/*'
IgnorePath '/usr/*/__pycache__/*'
IgnorePath '/usr/*.cache'
IgnorePath '/usr/lib/modules/*-arch*'
IgnorePath '/usr/lib/udev/hwdb.bin'
IgnorePath '/usr/lib/virtualbox/ExtensionPacks/*'
IgnorePath '/usr/lib/locale/locale-archive' #locale
IgnorePath '/usr/share/.mono/*'
IgnorePath '/usr/share/info/dir'                    #info
IgnorePath '/usr/share/mime/*'                      # MIME
IgnorePath '/usr/share/applications/mimeinfo.cache' #MIME
IgnorePath '/usr/share/fonts/*'
IgnorePath '/usr/share/glib-2.0/schemas/gschemas.compiled'
IgnorePath '/usr/share/icons/*/icon-theme.cache'
IgnorePath '/usr/share/perl5/vendor_perl/XML/SAX/ParserDetails.ini'

# /opt
IgnorePath '/opt/containerd'

# /lost+found
IgnorePath '/lost+found'

# /var
IgnorePath '/var/.updated'
IgnorePath '/var/lib/*'
IgnorePath '/var/log/*'
IgnorePath '/var/swap/*'
IgnorePath '/var/tmp/*'
IgnorePath '/var/db/*'
IgnorePath '/var/spool/*'
