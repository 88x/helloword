#!/bin/bash
#
#wget -qO- down.99.tf/bbrx.sh|bash
#
echo "#######################################################安装新内核"
wget "http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.11.7/linux-image-4.11.7-041107-generic_4.11.7-041107.201706240231_amd64.deb"
dpkg -i "linux-image-4.11.7-041107-generic_4.11.7-041107.201706240231_amd64.deb"
rm -fr "linux-image-4.11.7-041107-generic_4.11.7-041107.201706240231_amd64.deb"
