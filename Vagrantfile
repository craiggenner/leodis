# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty"
  config.vm.box_url = "https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-vagrant.box"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  instances = '[{"name": "server", "ip": "10.0.5.3", "mem": 2048}]'

  JSON.load(instances).each do |instance|
    config.vm.define instance['name'] do |app|
      app.vm.hostname = instance['name']
      app.vm.network :private_network, ip: instance['ip']
#      app.vm.provision :puppet do |puppet|
##      	puppet.options = "--verbose --debug"
#        puppet.manifests_path = 'puppet/manifests'
#        puppet.manifest_file = 'site.pp'
#        puppet.module_path = 'puppet/modules'
#        puppet.facter = instance['tags']
#        puppet.hiera_config_path = 'puppet/hiera.yaml'
#        puppet.working_directory = '/vagrant/puppet'
#      end
      if instance.key?('mem')
        config.vm.provider :virtualbox do |vb|
          vb.memory = instance['mem']
        end
      else
        config.vm.provider :virtualbox do |vb|
          vb.memory = 512
        end
      end
    end
  end
end
