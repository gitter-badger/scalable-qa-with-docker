require 'fileutils'

Vagrant.require_version ">= 1.6.0"

CLOUD_CONFIG_CORE01_PATH = File.join(File.dirname(__FILE__), "core01.user-data")
CLOUD_CONFIG_CORE02_PATH = File.join(File.dirname(__FILE__), "core02.user-data")
CONFIG = File.join(File.dirname(__FILE__), "config.rb")

# Attempt to apply the deprecated environment variable NUM_INSTANCES to
# $num_instances while allowing config.rb to override it
if ENV["NUM_INSTANCES"].to_i > 0 && ENV["NUM_INSTANCES"]
  $num_instances = ENV["NUM_INSTANCES"].to_i
end

if File.exist?(CONFIG)
  require CONFIG
end

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false

  config.vm.box = "coreos_766.3.0.box"
  config.vm.box_url = "data/vagrant/coreos_766.3.0.box"

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  (1..$num_instances).each do |i|
    config.vm.define vm_name = "core-%02d" % i do |config|
      config.vm.hostname = vm_name

      if $expose_docker_tcp
        config.vm.network "forwarded_port", guest: 2375, host: ($expose_docker_tcp + i - 1), auto_correct: true
      end

      $forwarded_ports.each do |guest, host|
        config.vm.network "forwarded_port", guest: guest, host: host, auto_correct: true
      end

      config.vm.provider :virtualbox do |vb|
        vb.gui = $vb_gui
        vb.memory = $vb_memory
        vb.cpus = $vb_cpus
      end

      config.vm.provision 'shell' do |s|
        s.path = 'provision.sh'
        s.args = [$ip_docker_registry]
      end

      ip = "172.17.8.#{i+100}"
      config.vm.network :private_network, ip: ip


      if i == 1
        config.vm.synced_folder "data/gitbucket/", "/gitbucket", id: "share-gitbucket", nfs: true, mount_options: ['nolock,vers=3,udp']
        config.vm.synced_folder "data/registry/", "/registry", id: "share-registry", nfs: true, mount_options: ['nolock,vers=3,udp']
        config.vm.synced_folder "data/jenkins/", "/jenkins", id: "share-jenkins", nfs: true, mount_options: ['nolock,vers=3,udp']
        config.vm.provision :file, :source => "data/slave.jar", :destination => "/home/core/slave.jar"
        config.vm.provision :file, :source => "#{CLOUD_CONFIG_CORE01_PATH}", :destination => "/tmp/vagrantfile-user-data"
      else
        config.vm.provision :file, :source => "data/slave.jar", :destination => "/home/core/slave.jar"
        config.vm.provision :file, :source => "#{CLOUD_CONFIG_CORE02_PATH}", :destination => "/tmp/vagrantfile-user-data"
      end

      config.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true

    end
  end
end
