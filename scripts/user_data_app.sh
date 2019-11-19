#!/bin/bash
hostnamectl set-hostname ${custom_hostname}-$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4 |cut -d"." -f4)-$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
