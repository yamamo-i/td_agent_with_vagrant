# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # use Ubuntu12.04LTS 
  config.vm.box = "Ubuntu12.04"
  config.vm.box_url = "http://download.appscale.com/download/AppScale%201.12.0%20VirtualBox%20Image"

  # Kibana + elasticsearch host
  config.vm.define :log_output do |vmclient|

    vmclient.vm.hostname = "search"
    vmclient.vm.network :forwarded_port, guest: 5601, host: 5601

    config.vm.provision :chef_solo do |chef|
      chef.run_list = ["kibana"]
    end

  end

  #TODO apache

  # VM capacity
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # "chef" auto intall
  config.omnibus.chef_version = :latest

  # plugin berkshelf
  config.berkshelf.enabled = true

end
