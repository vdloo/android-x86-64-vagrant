# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'android'
    config.ssh.username = 'android'
    config.ssh.password = 'android'
    config.ssh.forward_agent = true
    config.vbguest.auto_update = false
    config.vm.synced_folder '.', '/vagrant', disabled: true

    ANDROID_VAGRANT_SCRIPT_DIR = File.dirname(__FILE__) << '/'
    config.vm.box_url = ANDROID_VAGRANT_SCRIPT_DIR + 'images/catalog.json'
    config.vm.provision "shell" do |s|
        s.path  = ANDROID_VAGRANT_SCRIPT_DIR + 'provisioning/provision.sh'
    end

    config.vm.provider :virtualbox do |vbox|
        vbox.memory = 4096
    end
end
