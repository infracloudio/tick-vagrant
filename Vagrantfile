# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

CRGF_MEMORY=1024
AGENT_MEMORY=1536
CRGF_INSTANCES=1
AGENT_INSTANCES=3

TICK_SUBNET="192.168.17"
CRGF_ADDRESS="192.168.17.99"

DOMAIN_NAME="hs.com"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	AGENT_INSTANCES.times do |i|
		config.vm.define "ti_ck_#{i+1}" do |agent|
			agent.vm.box = "puppetlabs/centos-7.0-64-puppet"
			agent.vm.box_check_update = false
			agent.vm.network "private_network", ip: "#{TICK_SUBNET}.#{i+10}"
			agent.vm.hostname = "tick#{i+1}.#{DOMAIN_NAME}"
			agent.vm.provider :virtualbox do |vba|
				vba.customize ["modifyvm", :id, "--memory", AGENT_MEMORY]
			end
			agent.vm.provision "shell", path: "scripts/installTick.sh"
			agent.vm.provision "shell", path: "scripts/configureTick.sh"
		end
	end
	CRGF_INSTANCES.times do |i|
		config.vm.define "chrono" do |graf|
			graf.vm.box = "puppetlabs/centos-7.0-64-puppet"
			graf.vm.box_check_update = false
			graf.vm.network "private_network", ip: "#{CRGF_ADDRESS}"
			graf.vm.hostname = "chrono.hs.com"
			
			graf.vm.provider :virtualbox do |vb|
				vb.customize ["modifyvm", :id, "--memory", CRGF_MEMORY]
			end
#			graf.vm.provision "shell", path: "scripts/configureChrono.sh"
		end
	end	
end