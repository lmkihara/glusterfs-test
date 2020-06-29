#!/bin/bash

check_packages(){
  if [[ -x "$(command -v virtualbox)" ]]; then
    echo "[OK] VirtualBox already installed!"
  else
    echo "[FAIL] Vagrant isn't installed!"
    echo "Initiate the installation"
    install_virtualbox
  fi

  if [[ -x "$(command -v vagrant)" ]]; then
    echo "[OK] Vagrant already installed!"
  else
    echo "[FAIL] Vagrant isn't installed!"
    echo "Initiate the installation"
    install_vagrant
  fi

  }

start_vagrant(){
  ### Check if Vagrantfile exist
  if [[ -e Vagrantfile ]]; then
    vagrant up srv-gluster-03 srv-gluster-02 srv-gluster-01
  fi
  
}

install_vagrant(){
  curl https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
  sudo dpkg --install vagrant_2.2.9_x86_64.deb
}

install_virtualbox(){
  sudo apt-get install virtualbox -y
}

echo "Initiate script"
check_packages
start_vagrant