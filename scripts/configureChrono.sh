sudo systemctl stop firewalld.service 
sudo systemctl disable firewalld.service
cd /vagrant/templates;
if [ ! -f /vagrant/templates/chronograf-0.10.0_rc2-1.x86_64.rpm ]; then
sudo wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf-0.10.0_rc2-1.x86_64.rpm
fi

sudo yum localinstall -y chronograf-0.10.0_rc2-1.x86_64.rpm

sudo mv /opt/chronograf/config.toml /opt/chronograf/config.toml_orig
sudo cp /vagrant/templates/chrono_config.tmpl /opt/chronograf/config.toml

HOST=$(hostname);
sudo sed -i "s|%HOSTNAME%|$HOST|g" /opt/chronograf/config.toml

sudo service chronograf start