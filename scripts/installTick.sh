#!/bin/bash

#
# Disable firewall first since this is centos7
#
sudo systemctl stop firewalld.service 
sudo systemctl disable firewalld.service

#
# Install telegraf
#
cd /vagrant/templates/;

if [ ! -f /vagrant/templates/telegraf-0.10.1-1.x86_64.rpm ]; then
  sudo wget http://get.influxdb.org/telegraf/telegraf-0.10.1-1.x86_64.rpm
fi
sudo yum localinstall -y telegraf-0.10.1-1.x86_64.rpm

#
# Install InfluxDB
#
if [ ! -f /vagrant/templates/influxdb-0.9.6.1-1.x86_64.rpm ]; then
   sudo wget https://s3.amazonaws.com/influxdb/influxdb-0.9.6.1-1.x86_64.rpm
fi
sudo yum localinstall -y influxdb-0.9.6.1-1.x86_64.rpm
