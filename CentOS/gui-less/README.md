# Create VMs
`vagrant up` creates two CentOS 7.4 VMs
- This is a docker swarm mode cluster of two nodes
  - `node1` is docker swarm mode master
  - `node2` is docker swarm mode worker

Please ensure .ssh folder on the host machine containers SSH key pair:
- On node1 - SSH key pair from the host machine is coppied to the guest machine at $HOME/.ssh folder
- On node2 - SSH public key on the host machine is appended to `authorized_keys`
