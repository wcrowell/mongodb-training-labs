VAGRANT_COMMAND = ARGV[0]
# Set a variable for the IP address and Mongo version to install at the top of the file, so we can change it easily.
ip_address = "10.10.10.222"
hostname = "mongodb-training" 
mongodb_version = "4.4"
#mongodb_version = "3.6"
repl_set_name = "training"
config_server = 0
mongodb_minor_point_version = "4"

Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "./common/setup.sh", args: "#{ip_address} #{hostname} #{mongodb_version} #{repl_set_name} #{config_server} #{mongodb_minor_point_version}"
  config.vm.synced_folder "./common/", "/common"
  config.vm.network :forwarded_port, guest: 27017, host: 27017
  config.vm.network :forwarded_port, guest: 27018, host: 27018
  config.vm.network :forwarded_port, guest: 27019, host: 27019
  config.vm.network :forwarded_port, guest: 27020, host: 27020
  config.vm.network :forwarded_port, guest: 27021, host: 27021
  config.vm.network :forwarded_port, guest: 27022, host: 27022
  config.vm.network :forwarded_port, guest: 27023, host: 27023
  config.vm.network :forwarded_port, guest: 27024, host: 27024

  # If ssh passed in, then change user to mongod
  if VAGRANT_COMMAND == "ssh"
#    config.ssh.username = 'mongod'
  end
  config.vm.box = "centos/7"
 
  config.vm.network "private_network", ip: "#{ip_address}"
  config.vm.hostname = "#{hostname}" 
 
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end
end
