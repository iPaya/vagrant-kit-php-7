# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'fileutils'

config_files = {
  config: './config/config.yml',
  example: './config/config.example.yml'
}

sites_files = {
  sites: './config/sites.yml',
  example: './config/sites.example.yml'
}

hosts = {}

# copy config from example if local config not exists
FileUtils.cp config_files[:example], config_files[:config] unless File.exist?(config_files[:config])
FileUtils.cp sites_files[:example], sites_files[:sites] unless File.exist?(sites_files[:sites])

# read config
config = YAML.load_file config_files[:config]
sites = YAML.load_file sites_files[:sites]

# check github token
if config['github_token'].nil? || config['github_token'].to_s.length != 40
  puts "You must place REAL GitHub token into configuration:\nconfig/config.yml"
  exit
end

# check code path
if config['code_path'].nil? || !File.exist?(config['code_path'])
  puts "You must place REAL code path into configuration:\nconfig/config.yml"
  exit
end

Vagrant.configure(2) do |kit|

  kit.vm.box = "iPaya/php-7.0"
  kit.vm.hostname = config["hostname"]
  kit.vm.network 'private_network', ip: config["ip"]

  kit.vm.provider "virtualbox" do |vb|
	# machine cpus count
    vb.cpus = config["cpus"]
    # machine memory size
    vb.memory = config["memory"]
    # machine name (for VirtualBox UI)
    vb.name = config["machine_name"]
  end

  kit.vm.synced_folder config["code_path"], "/code", type: "nfs"

  kit.vm.provision 'shell', path: './scripts/init-apache.sh'
  kit.vm.provision 'shell', path: './scripts/install-composer.sh'
  kit.vm.provision 'shell', path: './scripts/setup-composer-as-vagrant.sh', privileged: false, args: [config["github_token"]]

  sites["domains"].each do |site|
    hosts[site["serverName"]] = site["serverName"]

    kit.vm.provision "shell", run: "always" do |shell|
      shell.path = "./scripts/install-site.sh"
      shell.args = [
        site["serverName"],
        site["documentRoot"]
      ]
    end
  end
  kit.vm.provision 'shell', run: "always", path: './scripts/always-as-root.sh'

  # hostmanager
  kit.vm.provision :hostmanager
  kit.hostmanager.enabled = true
  kit.hostmanager.manage_host = true
  kit.hostmanager.manage_guest = true
  kit.hostmanager.ignore_private_ip = false
  kit.hostmanager.include_offline = false
  kit.hostmanager.aliases = hosts.values

  # post-install message (vagrant console)
  kit.vm.post_up_message = "Congratulations!!!\n"
end