**User story**
- As a DevOps team member I want to automate setting up of two ubuntu based nodes with [Vagrant](https://www.vagrantup.com/) for development purpose so that I can distribute Docker Swarm mode services in a cluster configuration.

**Assumptions**
- Development machine is Windows 10
-	At least 10GB free RAM is available on your machine. Otherwise, you will need to edit Vagrantfile to adjust available RAM for your machine:
  -	`v.customize ["modifyvm", :id, "--memory", <MEMORY_ALLOCATION>]`

**Prerequisite:**
-	Install latest version of  [Git bash](https://git-scm.com/downloads) and/or [GitHub Desktop](https://help.github.com/desktop/guides/getting-started/)
-	Install latest version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
-	Install latest version of  [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html)
-	Install [Vagrant Host Manager](https://github.com/devopsgroup-io/vagrant-hostmanager) plugin by running ```vagrant plugin install vagrant-hostmanager``` in Git bash. This will update host files on both guest and host machines.

**Instructions:**
-	Run ```vagrant up``` command which will setup a Docker swarm mode cluster; 1xMaster and 1xWorker
  - ```vagrant ssh node1``` to log into the master node
  - ```vagrant ssh node2``` to log into the worker node
- Infrastructure visualizer is availabe at [http://node1:9080](http://node1:9080). You should see two nodes; one of which is a master and the second one is a worker
- Portainer is available at [http://node1:9000](http://node1:9000). This UI was provisioned as part of running the "vagran upt" command.
 - Portainer documentation is [here](https://hub.docker.com/r/portainer/portainer/) on github.
