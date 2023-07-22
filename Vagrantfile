# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "oraclebase/oracle-8"
  config.vm.hostname = "docker-minikube"
  
  # share additional folder to the guest vm
  config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096      	# Memory size in M.
    vb.cpus   = 2         	# Number of vCPUs
    vb.name   = "docker-minikube"   # VM name.
    
    # Tell VirtualBox this VM is running on an SSD.
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '0', '--nonrotational', 'on']
	
	# Use NAT for NIC1
	vb.customize ["modifyvm", :id, "--nic1", "nat"]
	
	# Configure graphics vmsvga controller
    vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
		
		
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sh /vagrant/scripts/script.sh
  SHELL
end
