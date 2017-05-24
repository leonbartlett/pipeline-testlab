# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://internetgateway.cdf.atradiusnet.com:8080"
    config.proxy.https    = "http://internetgateway.cdf.atradiusnet.com:8080"
    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
  end
  
  config.vm.define "util" , primary: true do |util|

    util.vm.box = "centos-7-1611-x86_64"
    util.vm.box_url = "/projects/vagrantboxes/centos-7-1611-x86_64.box"

    util.vm.hostname = "util.example.com"
    util.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    #util.vm.synced_folder "/software/Oracle_Software/fmw/12.2.1/installers", "/software"

    util.vm.network :private_network, ip: "10.10.11.2"
    #util.vm.network "forwarded_port", guest: 7001, host:9001, auto_correct: true

    util.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2024"]
      vb.customize ["modifyvm", :id, "--name"  , "util"]
      vb.customize ["modifyvm", :id, "--cpus"  , 2]
    end

    util.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppetlabs/code/hiera.yaml;rm -rf /etc/puppetlabs/code/modules;ln -sf /vagrant/puppet/environments/development/modules /etc/puppetlabs/code/modules"


    util.vm.provision :puppet do |puppet|

      puppet.environment_path     = "puppet/environments"
      puppet.environment          = "development"

      puppet.manifests_path       = "puppet/environments/development/manifests"
      puppet.manifest_file        = "site.pp"

      puppet.options           = [
                                  '--verbose',
                                  '--report',
                                  '--trace',
                                  # '--debug',
#                                  '--parser future',
                                  '--strict_variables',
                                  '--hiera_config /vagrant/puppet/hiera.yaml'
                                 ]
      puppet.facter = {
        "environment"     => "development",
        "vm_type"         => "vagrant",
      }

    end
  end
end
