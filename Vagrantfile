Vagrant.configure('2') do |config|
        config.vm.box = 'android-x86_64'
        config.vm.box_url = 'packer/android-x86_64-virtualbox.box'
        config.ssh.username = 'android'
        config.ssh.password = 'android'
        config.vbguest.auto_update = false
        config.vm.synced_folder '.', '/vagrant', disabled: true
end

