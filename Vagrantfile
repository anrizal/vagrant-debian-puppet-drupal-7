#Vagrant API Version
#Currently, there are only two supported versions: "1" and "2".
#Version 1 represents the configuration from Vagrant 1.0.x.
#"2" represents the configuration for 1.1+ leading up to 2.0.x.
VAGRANTFILE_API_VERSION = "2"

# The BOX used is Ubuntu 12.04 LTS 64 bit
BOX = "precise64"
BOX_URL = "http://files.vagrantup.com/precise64.box"

# We set the vm's memory to 1024 MB
MEMORY = "1024"

# Network Settings.
IP = "10.0.0.12"

# Share/synced folder configuration
HOST_FOLDER = "./sites"
GUEST_FOLDER = "/home/vagrant/sites"

#Provision source
PUPPET_MANIFEST_PATH = "."
PUPPET_MANIFEST_FILE = "puppet/manifests/default.pp"
PUPPET_MODULE_PATH = "puppet/modules"

#==========================================================================
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online. http://docs.vagrantup.com/v2/

  # The BOX
    config.vm.box = BOX
    config.vm.box_url = BOX_URL

  # We set the vm's memory, enable ioapic, set natdnsresolver
    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", MEMORY]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end    

  # Network Settings. Note, in 1.1++ no host only and no forward port option 
    config.vm.network :private_network, ip: IP

  # configure shared/synced folder. 
  # we do not use NFS for Windows Host
  # we need extra permission setting for OSX
  case RUBY_PLATFORM.downcase
    when /cygwin|mswin|mingw|bccwin|wince|emx/ #windows
      config.vm.synced_folder HOST_FOLDER, GUEST_FOLDER, id: "vagrant-root", nfs: false
    when /darwin|mac os/ #OSX
      config.vm.synced_folder HOST_FOLDER, GUEST_FOLDER, id: "vagrant-root", :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775', 'fmode=775']
    when /linux/ #linux
      config.vm.synced_folder HOST_FOLDER, GUEST_FOLDER, id: "vagrant-root", nfs: true
    else
      puts "un-supported Operating System"
  end

  # Provisioning settings.
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = PUPPET_MANIFEST_PATH
      puppet.manifest_file = PUPPET_MANIFEST_FILE
      puppet.module_path = PUPPET_MODULE_PATH
      puppet.options = "--verbose --debug"
    end    

end