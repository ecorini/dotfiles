# version control
AddPackage git
AddPackage --foreign gitextensions

# debugger
AddPackage gdb
AddPackage gcovr

# utilities
AddPackage jq # Command-line JSON processor
AddPackage lcov
AddPackage lib32-gcc-libs
AddPackage lib32-glibc
AddPackage cppcheck
AddPackage bless
AddPackage cmake                # A cross-platform open-source make system
AddPackage --foreign git-chglog # git CHANGELOG generator
AddPackage --foreign gita       # git tool to manage multiple git repositories

# docker
AddPackage docker

# python
AddPackage python-cpplint
AddPackage python-pathspec
AddPackage python-tox
AddPackage python-pip
AddPackage python-pytest

# ruby
AddPackage ruby

# editor / ide
AddPackage --foreign visual-studio-code-bin
AddPackage neovim

# compater tools
AddPackage meld

# mqtt
AddPackage mosquitto

# doxygen
AddPackage doxygen

# zephyr
AddPackage ccache     # Compiler cache that speeds up recompilation by caching previous compilations
AddPackage dfu-util   # Tool intended to download and upload firmware using DFU protocol to devices connected over USB
AddPackage dtc        # Device Tree Compiler
AddPackage gperf      # Perfect hash function generator
AddPackage ninja      # Small build system with a focus on speed
AddPackage python-nox # Flexible test automation for Python
AddPackage tk         # A windowing toolkit for use with tcl
