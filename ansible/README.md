# WORK IN PROGRESS
- docker pull williamyeh/ansible:ubuntu16.04
- alias ansible='docker run -it --rm --name ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub -v $PWD:/ansible -w /ansible williamyeh/ansible:ubuntu16.04 ansible'
- ansible --version
- ansible -i ./hosts local --connection=local -m ping
- ansible -i ./hosts local --connection=local -b --become-user=root -m shell -a 'apt update && apt install -y nginx'
- ansible -i ./hosts local --connection=local -b --become-user=root -m apt -a 'name=nginx state=installed update_cache=true'

- alias ansible-playbook='docker run -it --rm --name ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub -v $PWD:/ansible -w /ansible williamyeh/ansible:ubuntu16.04 ansible-playbook'
- ansible-playbook -i ./hosts nginx.yml

- alias ansible-galaxy='docker run -it --rm --name ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub -v $PWD:/ansible -w /ansible williamyeh/ansible:ubuntu16.04 ansible-galaxy'
- mkdir roles
- cd roles
-
# Bootstrap a new role named "nginx"
- ansible-galaxy init nginx
- ansible-playbook -i ./hosts site.yml

- alias ansible-vault='docker run -it --rm --name ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub -v $PWD:/ansible -w /ansible williamyeh/ansible:ubuntu16.04 ansible-vault'












---------------------------------------------------------------------------------------------------------------------------------------------------------------


docker run -it --rm --name ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub -v $PWD:/ansible -w /ansible williamyeh/ansible:ubuntu16.04 bash




ansible -i ./hosts remote -b --become-user=root -m apt -a 'name=nginx state=installed update_cache=true'
