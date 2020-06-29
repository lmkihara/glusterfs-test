# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  (1..3).each do |n|
    config.vm.define "srv-gluster-0#{n}" do |gluster|
      gluster.vm.hostname = "srv-gluster-0#{n}"
      gluster.vm.network "private_network", ip: "10.1.1.1#{n}"
      gluster.vm.provider "virtualbox" do |vb|
        vb.name = "srv-gluster-0#{n}"
        vb.memory = "512"
        vb.cpus = "1"

        file_to_disk = "disk_2-#{n}.vdi"
        unless File.exist?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 1024]
        end
        vb.customize ['storageattach', :id, '--storagectl', 'SCSI', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]

        file_to_disk = "disk_3-#{n}.vdi"
        unless File.exist?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 1024]
        end
        vb.customize ['storageattach', :id, '--storagectl', 'SCSI', '--port', 3, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end
    end
  end
  config.vm.provision "shell", path: "gluster-install.sh"
end
