#!/bin/bash
if [[ "$USER" != "root" ]]; then
    SUDO=sudo
fi
$SUDO yum update -y
$SUDO yum -q -y upgrade
$SUDO yum -q -y install vim curl wget git zsh
$SUDO update-alternatives --set editor `which vim`
curl -sSL -o ~/.bashrc http://sa-net.github.io/init-script/configure/bashrc
curl -sSL http://git.gaoyifan.com/gao/oh-my-zsh/raw/master/tools/install.sh | sh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
