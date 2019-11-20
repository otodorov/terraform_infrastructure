#!/bin/bash
hostnamectl set-hostname ${custom_hostname}-$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4 |cut -d"." -f4)-$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
sudo yum update || sudo apt update
sudo yum install -y amazon-efs-utils || \
  sudo yum install -y nfs-utils || \
  sudo apt-get install nfs-common
efs_id="${efs_id}"
efs_mount_point="${efs_mount_point}"
sudo mkdir ${efs_mount_point}
sudo mount -t efs -o tls $efs_id:/ ${efs_mount_point}
sudo echo ${efs_id}:/ ${efs_mount_point} efs defaults,_netdev 0 0 >> /etc/fstab
