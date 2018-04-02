`vagrant up` will spin up a CentOS 7.4 desktop VM. This VM is a single node docker swarm mode cluster

You will need to ensure that you have SSH key pair available in ~/.ssh directory. This directory will be coppied to the guest VM

You will need to ensure that you have ~/.aws/credentials file available on the host machine. ~/.aws directory will be coppied to the guest VM

The infrastructure created with Vagrantfile will have the following tools installed:
  - Openjdk 1.8
  - Ansible _(latest compatible version)_
  - Eclipse Oxygen _(Rel 3)_
  - Atom _(Beta)_ along with numerous plugins. see Vagrantfile for full list
  - Google Chrome _(latest compatible version)_
  - Terraform v0.11.5
  - Docker CE _(latest compatible version)_
