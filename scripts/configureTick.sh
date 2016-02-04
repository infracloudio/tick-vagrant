#!/bin/bash

#
# Variables
#

HOST=$(hostname);

#
# Adding host entries
#
sudo /vagrant/scripts/appendHosts.sh

#
# Configuring telegraf and influxdb
#
sudo mkdir -p /etc/{telegraf,influxdb};
sudo mv /etc/telegraf/telegraf.conf /etc/telegraf/telegraf.conf_orig
sudo cp /vagrant/templates/telegraf.conf.tmpl /etc/telegraf/telegraf.conf
sudo mv /etc/influxdb/influxdb.conf /etc/influxdb/influxdb.conf_orig
sudo cp /vagrant/templates/influxdb.conf.tmpl /etc/influxdb/influxdb.conf
sudo sed -i "s|%HOSTNAME%|$HOST|g" /etc/influxdb/influxdb.conf /etc/telegraf/telegraf.conf
case $HOST in
		tick1.hs.com )
		    INFOPT="";;
		tick2.hs.com )
		    INFOPT="INFLUXD_OPTS=-join tick1.hs.com:8088";;
		tick3.hs.com )
		    INFOPT="INFLUXD_OPTS=-join tick1.hs.com:8088,tick2.hs.com:8088";;
esac
echo "$INFOPT" | sudo tee --append  /etc/default/influxdb

sudo rm -rf /var/lib/influxdb/meta/*
sudo service influxdb start
sudo service telegraf start
#
# Test Command 
#
#curl -G http://tick1.hs.com:8086/query?pretty=true --data-urlencode "db=collectd_db" --data-urlencode "q=show series"
