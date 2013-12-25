# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # use Ubuntu12.04LTS 
  config.vm.box = "Ubuntu12.04"
  config.vm.box_url = "http://download.appscale.com/download/AppScale%201.12.0%20VirtualBox%20Image"

  # Kibana + elasticsearch host
  config.vm.define :search do |vmclient|

    vmclient.vm.hostname = "search"

    # Kibana用のport設定
    vmclient.vm.network :forwarded_port, guest: 5601, host: 5601
    # elasticsearch用のport設定
    vmclient.vm.network :forwarded_port, guest: 9200, host: 9200
    vmclient.vm.network "private_network", ip: "192.168.0.2",virtualbox__intnet: true

    config.vm.provision :chef_solo do |chef|
      chef.run_list = ["elasticsearch", "kibana"]
    end

  end

  # apache host
  config.vm.define :apache do |vmclient|

    vmclient.vm.hostname = "apache"
    # apache用のport設定
    vmclient.vm.network :forwarded_port, guest: 80, host: 8000
    vmclient.vm.network "private_network", ip: "192.168.0.3",virtualbox__intnet: true

    config.vm.provision :chef_solo do |chef|
      chef.run_list = ["apache", "fluentd"]
    end

  end

  # VM capacity
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
    vb.customize ["modifyvm", :id, "--nic2", "intnet"]
  end

  # "chef" auto intall
  config.omnibus.chef_version = :latest

  # plugin berkshelf
  config.berkshelf.enabled = true

end
