# InfraAsCode

## Instructions:

-	The Vagrantfile assumes you have 10GB RAM available on your machine to spin up 2 VMs. You will need to edit memory part of this file to accomodate you machine  
-	Run "vagrant up" commands. This will setup a Docker swarm cluster; 1xMaster and 1xWorker
-	Wait for a couple of minutes until execution of Vagrantfile has finished
-	In your web browser, navigate to <a href="http://node1:9080/">http://node1:9080/</a>. You should see two nodes; one of which is a master and the second one is a worker