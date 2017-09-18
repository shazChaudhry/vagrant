#### User story
As a DevOps team member, I want to automate setting up two Linux based nodes on [AWS](https://aws.amazon.com/free/) with [Terraform](https://www.terraform.io/) for development purpose

#### Assumptions
You have docker installed on your platform. This repository uses docker to execute terraform statements

#### Prerequisite
If in case docker can not be run natively on your platform, you should use the provided Vagrantfile to setup a VM which will have docker installed
- Run `vagrant up` command to setup a VM
-	Run `vagrant ssh` to log into the VM

# WIP
- Terraform docker image available at: https://hub.docker.com/r/hashicorp/terraform/
- Terraform getting started docs at: https://www.terraform.io/intro/getting-started/install.html

- Good tutorial: https://simonfredsted.com/1459

- A complete AWS environment with Terraform - very recent blog: https://linuxacademy.com/howtoguides/posts/show/topic/13922-a-complete-aws-environment-with-terraform

- In the AWS documentation, this is given as an example: “Scenario 2” and this post will show how this can be replicated using Terraform: https://nickcharlton.net/posts/terraform-aws-vpc.html. Repository with the full example over on GitHub: https://github.com/nickcharlton/terraform-aws-vpc

- This is another blog on "Scenario 2": https://040code.github.io/2017/06/18/terraform-aws-vpc/ and code in github: https://github.com/040code/blog_terraform-aws-vpc
