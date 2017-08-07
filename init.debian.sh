#!/bin/bash

VIRSUAL_SOFTWARE=(htop bmon nmon sysstat iotop iftop iptraf)
DEV_SOFTWARE=(build-essential cmake git pkg-config)
PACKAGE_SOFTWARE=(aptitude apt-file unattended-upgrades)
NET_SOFTWARE=(dnsutils wget traceroute mtr)
SHELL_SOFTWARE=(curl git zsh)
LANGUAGE_SOFTWARE=(language-pack-zh-hans)
EDIT_SOFTWARE=(vim most)
REMOTE_SOFTWARE=(curl openssh-client tmux mosh libpam-systemd)

VIRSUAL_TOOLS=false
DEV_TOOLS=false
PACKAGE_TOOLS=false
NET_TOOLS=false
SHELL_TOOLS=false
LANGUAGE_TOOLS=false
EDIT_TOOLS=false
REMOTE_TOOLS=false
UPGRADE=false

while (( $# ))
do
  parameter="$1" && shift
  case "${parameter}" in
    (-a|--all-tools)
      VIRSUAL_TOOLS=true
      DEV_TOOLS=true
      PACKAGE_TOOLS=true
      NET_TOOLS=true
      SHELL_TOOLS=true
      LANGUAGE_TOOLS=false
      EDIT_TOOLS=true
      REMOTE_TOOLS=true
      UPGRADE=true
      ;;
    (-v|--visual-tools)
      VIRSUAL_TOOLS=true
      ;;
    (-d|--dev-tools)
      DEV_TOOLS=true
      ;;
    (-p|--package-tools)
      PACKAGE_TOOLS=true
      ;;
    (-n|--net-tools)
      NET_TOOLS=true
      ;;
    (-s|--shell-tools)
      SHELL_TOOLS=true
      ;;
    (-l|--language-tools)
      LANGUAGE_TOOLS=true
      ;;
    (-e|--edit-tools)
      EDIT_TOOLS=true
      ;;
    (-r|--remote-tools)
      REMOTE_TOOLS=true
      ;;
    (-u|--upgrade)
      UPGRADE=true
      ;;
    (*)
      echo "Unknown parameter ${parameter} ignored."
      ;;
  esac
done

while (( $# ))
do
  parameter="$1" && shift
  case "${parameter}" in
    (-nv|--not-not-visual-tools)
      VIRSUAL_TOOLS=false
      ;;
    (-nd|--not-DEV-tools)
      DEV_TOOLS=false
      ;;
    (-np|--not-package-tools)
      PACKAGE_TOOLS=false
      ;;
    (-nn|--not-net-tools)
      NET_TOOLS=false
      ;;
    (-ns|--not-shell-tools)
      SHELL_TOOLS=false
      ;;
    (-nl|--not-language-tools)
      LANGUAGE_TOOLS=false
      ;;
    (-ne|--not-edit-tools)
      EDIT_TOOLS=false
      ;;
    (-nr|--not-remote-tools)
      REMOTE_TOOLS=false
      ;;
    (-nu|--not-upgrade)
      UPGRADE=false
      ;;
    (*)
      echo "Unknown parameter ${parameter} ignored."
      ;;
  esac
done


if [[ "$USER" == "root" ]]; then
  SUDO=
else
  if `type sudo >/dev/null 2>&1` ; then
    SUDO=sudo
  else
    echo "need sudo to install software"
    exit 1
  fi
fi

$SUDO apt-get update

if $UPGRADE; then
  $SUDO apt-get -q -y upgrade
fi
if $VIRSUAL_TOOLS; then
  $SUDO apt-get -q -y install ${VIRSUAL_SOFTWARE[@]}
fi
if $DEV_TOOLS; then
  $SUDO apt-get -q -y install ${DEV_SOFTWARE[@]}
fi
if $PACKAGE_TOOLS; then
  $SUDO apt-get -q -y install ${PACKAGE_SOFTWARE[@]}
  $SUDO apt-file update
fi
if $NET_TOOLS; then
  $SUDO apt-get -q -y install ${NET_SOFTWARE[@]}
fi
if $LANGUAGE_TOOLS; then
  $SUDO apt-get -q -y install ${LANGUAGE_SOFTWARE[@]}
fi
if $EDIT_TOOLS; then
  $SUDO apt-get -q -y install ${EDIT_SOFTWARE[@]}
  $SUDO update-alternatives --set editor /usr/bin/vim.basic
fi
if $REMOTE_TOOLS; then
  $SUDO apt-get -q -y install ${REMOTE_SOFTWARE[@]}
  mkdir ~/.ssh
  chmod 700 ~/.ssh
  curl -sSL -o ~/.ssh/config http://sa-net.github.io/init-script/configure/ssh/config
fi
if $SHELL_TOOLS; then
  $SUDO apt-get -q -y install ${SHELL_SOFTWARE[@]}
  curl -sSL -o ~/.bashrc http://sa-net.github.io/init-script/configure/bashrc
  curl -sSL -o /tmp/install_zsh.sh http://git.gaoyifan.com/gao/oh-my-zsh/raw/master/tools/install.sh
  chmod +x /tmp/install_zsh.sh
  /tmp/install_zsh.sh
  rm /tmp/install_zsh.sh
fi
