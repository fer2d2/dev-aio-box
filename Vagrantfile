# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.10.10"

  # config.vm.network "public_network"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.synced_folder "/Users/fernando/dev_env", "/vagrant", type: "nfs",
    linux__nfs_options: %q(no_subtree_check all_squash rw),
    map_uid: 501, map_gid: 20

  # vagrant plugin install vagrant-bindfs
  config.bindfs.bind_folder "/vagrant", "/vagrant",
    :'create-as-user' => true,
    :perms => "u=rwx:g=rwx:o=rwx",
    :'create-with-perms' => "u=rwx:g=rwx:o=rwx"
    # :'chown-ignore' => true, :'chgrp-ignore' => true, :'chmod-ignore' => true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "mtc"
    vb.gui = false
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "60"]
    vb.memory = "4096"
    vb.cpus = 4
  end

  config.vm.provision :shell, path: "bootstrap.sh"

end
