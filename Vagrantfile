# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  config.vm.provision :chef_solo do |chef|
    # Grab the cookbooks from the Vagrant files
    chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
    # Tell chef what recipe to run. In this case, the `vagrant_main` recipe
    # does all the magic.
    chef.add_recipe("vagrant_main")
  end
  config.vm.forward_port 80, 8080
  config.vm.network :hostonly, "192.168.10.200"
end
