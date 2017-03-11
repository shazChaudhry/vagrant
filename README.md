# InfraAsCode

## Tasks:

-	Setting up a docker swarm cluster of 4 nodes with vagrant
![alt text](Infra.PNG "Swam cluster")

## Prerequisists:

-	Install VirtualBox v5.1.14 (Avoid installing v5.1.16. Due to a bug, vagrant will fail to create a box. See <a href="http://stackoverflow.com/questions/42074246/vagrant-error-unable-to-mount-virtualbox-shared-folders-guest-additions-vboxs">Stack Overflow</a> for the issue and resolution)
-	Install latest version of Vagrant 
-	Install hostmanager plugin by running "vagrant plugin install vagrant-hostmanager". This will update host files

## Instructions:

- 	Clone this repo
-	Change to the cloned directory 
-	The Vagrantfile assumes you have 10GB RAM available on your machine to spin up VMs. You will need to edit memory part of this file to accomodate you machine  
-	Run " vagrant box update" and then "vagrant up" commands. This will setup a Docker swarm mode cluster; 1xMaster and 1xSlave