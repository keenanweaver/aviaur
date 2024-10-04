#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc

# Install thinkfan, tlp, igt-gpu-tools and displaylink kernel module
rpm-ostree install tlp thinkfan igt-gpu-tools /tmp/rpms/kmods/*evdi*.rpm

#Disable negativo repo after installing displaylink, as it otherwise conflicts with RPM-fusion
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-multimedia.repo

# Mask power-profiles-daemon in order for tlp to work correctly
systemctl mask power-profiles-daemon.service

#### Example for enabling a System Unit File

systemctl enable podman.socket
