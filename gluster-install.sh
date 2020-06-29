#!/bin/bash

### Init configuration
initial_configuration(){
  timedatectl set-timezone America/Sao_Paulo
  if [[ $(hostname) == "srv-gluster-01" ]]; then
    echo "10.1.1.12     srv-gluster-02" >> /etc/hosts
    echo "10.1.1.13     srv-gluster-03" >> /etc/hosts
    iptables -I INPUT -p all -s srv-gluster-02 -j ACCEPT
    iptables -I INPUT -p all -s srv-gluster-03 -j ACCEPT
  elif [[ $(hostname) == "srv-gluster-02" ]]; then
    echo "10.1.1.11     srv-gluster-01" >> /etc/hosts
    echo "10.1.1.13     srv-gluster-03" >> /etc/hosts
    iptables -I INPUT -p all -s srv-gluster-01 -j ACCEPT
    iptables -I INPUT -p all -s srv-gluster-03 -j ACCEPT
  else
    echo "10.1.1.11     srv-gluster-01" >> /etc/hosts
    echo "10.1.1.12     srv-gluster-02" >> /etc/hosts
    iptables -I INPUT -p all -s srv-gluster-01 -j ACCEPT
    iptables -I INPUT -p all -s srv-gluster-02 -j ACCEPT
  fi

  ### Install packages
  apt-get update
  apt-get install -y zfsutils-linux glusterfs-server

  ### start gluster daemon
  systemctl start glusterd

}

### Configure zfs pool
zfs_pool(){
  zpool create -f gluster_file mirror /dev/sdc /dev/sdd

  zfs set compression=lz4 gluster_file
  zfs set acltype=posixacl gluster_file

}

gluster_replication(){
  ### ALL COMMANDS HERE, EXECUTE JUST IN MASTER SERVER
  if [[ $(hostname) == "srv-gluster-01" ]]; then
    ### Probe the another server replica
    gluster peer probe srv-gluster-02
    gluster peer probe srv-gluster-03

    ### Create a new volume, set the replica to 2
    gluster volume create vol0 replica 3 srv-gluster-01:/gluster_file/vol0 srv-gluster-02:/gluster_file/vol0 srv-gluster-03:/gluster_file/vol0

    sleep 5m

    gluster volume start vol0

    ### mount gluster brick
    mount -t glusterfs srv-gluster-01:/vol0 /mnt/
  fi

}
echo "START CONFIGURATION!!!"
initial_configuration
zfs_pool
gluster_replication