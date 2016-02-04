sudo systemctl stop firewalld.service 
sudo systemctl disable firewalld.service

#sudo wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf-0.10.0_rc2-1.x86_64.rpm
cd /vagrant/templates;
sudo yum localinstall chronograf-0.10.0_rc2-1.x86_64.rpm

