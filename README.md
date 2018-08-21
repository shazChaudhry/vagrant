**User story**
- As a DevOps team member I want to automate setting up of two nodes _(either Ubuntu 18.04 or CentOS 7.4)_ with [Vagrant](https://www.vagrantup.com/) for development purpose and configure them to form docker swarm mode.

**Assumptions**
- Development machine is Windows 10
-	At least 8GB free RAM is available on your machine. Otherwise, you will need to edit Vagrantfile to adjust available RAM for your machine:
  -	`v.customize ["modifyvm", :id, "--memory", <MEMORY_ALLOCATION>]`
  -	Instructions below assume working with Ubuntu and not CentOS folder

**Prerequisite:**
-	Install latest version of  [Git bash](https://git-scm.com/downloads) and/or [GitHub Desktop](https://help.github.com/desktop/guides/getting-started/)
-	Install latest version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
-	Install latest version of  [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html)
-	Install [Vagrant Host Manager](https://github.com/devopsgroup-io/vagrant-hostmanager) plugin by running ```vagrant plugin install vagrant-hostmanager``` in Git bash. This will update host files on both guest and host machines.
-	[Generating a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) if you do not already have one. This is required to ssh from node1 to node2
- AWS credentials are available at "~/.aws/credentials" which should look like as follows. this will be required to run Terraform from node1:
  ```
  [default]
  aws_access_key_id = <KEY>
  aws_secret_access_key = <SECRET>
  ```

**Instructions:**
- Change directory to Ubuntu sub directory
-	Run ```vagrant up``` command which will setup a Docker swarm mode cluster; 1xMaster and 1xWorker
- ```vagrant ssh node1``` to log into the master node
  - ```cd /vagrant```
  - ```docker stack deploy --compose-file=docker-compose.portainer.yml portainer``` Use Portainer agent setup to deploy inside a Swarm cluster
  - ```docker stack services portainer``` List the services in the portainer stack
  - Portainer is available at [http://node1:9000](http://node1:9000). Portainer documentation is [here](https://hub.docker.com/r/portainer/portainer/) on github
- ```vagrant ssh node2``` to log into the worker node
- Node1 will also have the following software installed:
  - Terraform v0.11.8 _(See Prerequisites above)_
  - Ansible v2.6.3 _(As of writing this, 21/08/2018)_

**Clean up:**
- ```vagrant destroy --force``` destroy all VMs that were created above
