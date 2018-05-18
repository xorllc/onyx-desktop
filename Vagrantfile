# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1604"
  config.vm.box_check_update = false

  config.vm.define "vagrant-ubuntu-desktop-i3" do |host|
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-ubuntu-desktop-i3"
    vb.cpus = 2
    vb.memory = "4096"

    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--bioslogofadein', 'off']
    vb.customize ['modifyvm', :id, '--bioslogofadeout', 'off']
    vb.customize ['modifyvm', :id, '--bioslogodisplaytime', '1000']
  end

  config.vm.network "forwarded_port", guest: 8000, host: 8080
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "public_network"

#  # NoMachine configuration.
#  config.vm.synced_folder "docker-ubuntu-mate-desktop-nomachine/", "/opt/git/nomachine"
#
  config.vm.provision "shell", privileged:true, inline: <<-SHELL
    apt-get update -y
    apt-get install docker.io -y
  SHELL
end
