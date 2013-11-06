#Vagrant API Version
#Currently, there are only two supported versions: "1" and "2".
#Version 1 represents the configuration from Vagrant 1.0.x.
#"2" represents the configuration for 1.1+ leading up to 2.0.x.

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online. http://docs.vagrantup.com/v2/

  # The BOX used is Ubuntu 12.04 LTS 64 bit
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # We set the vm's memory to 1024 MB, enable ioapic, set natdnsresolver
    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end    

  # Network Settings. Note, in 1.1++ no host only and no forward port option 
    config.vm.network :private_network, ip: "10.0.0.10"

  # configure shared/synced folder. we do not use NFS for Windows Host
    config.vm.synced_folder "./sites", "/home/vagrant/sites", id: "vagrant-root", nfs: false
end