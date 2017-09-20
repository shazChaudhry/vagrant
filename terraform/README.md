#### User story
As a DevOps team member, I want to build infrastructure _(AWS "Scenario 2")_ on [AWS](https://aws.amazon.com/) using [Terraform](https://www.terraform.io/) for development purpose.

<p align="center">
  <img src="pics/aws-infra.png" alt="AWS infra" style="width: 250px;"/>
</p>

If you don't have an AWS account, create [free-tier](https://aws.amazon.com/free/) one now.

#### Assumptions
- You have the latest docker engine installed on your platform. This repository uses docker to execute terraform statements.
- You have AWS credentials in a safe location:
  - Create a "~/.aws/credentials" file with the following content
    ```
    [default]
    aws_access_key_id = <KEY>
    aws_secret_access_key = <SECRET>
    ```

#### Prerequisite if standing up a vagrant box
If of some reason docker can not be run natively on your platform, you should use the provided Vagrantfile to setup a VM which will have a docker engine installed. Vagrant coppies a number of files and folders (like aws credentials) from host to guest machine. Modify the Vagrantfile as per your needs.

Also, ensure you have a "~/.aws/credentials" file on the host machine with the following content:
  ```
  [default]
  aws_access_key_id = <KEY>
  aws_secret_access_key = <SECRET>
  ```

- Run `vagrant up` command to setup a VM
-	Run `vagrant ssh` to log into the VM

#### Instructions
On the platform where docker engine is installed, execute the following commands to clone this repo:
1. `alias git='docker run -it --rm --name git -v $PWD:/git -w /git indiehosters/git git'`
2. `git version`
3. `git clone https://github.com/shazChaudhry/infra.git`
4. `sudo chown -R docker infra`
5. `cd infra/terraform`

Terraform docker image is available at https://hub.docker.com/r/hashicorp/terraform/. Before executing terraform, ensure that you have a "~/.aws/credentials" file with the following content:
```
[default]
aws_access_key_id = <KEY>
aws_secret_access_key = <SECRET>
```

Execute the following commands to run terraform:
1. `alias terraform='docker run -it --rm --name terraform -v ~/.aws/credentials:/home/root/.aws/credentials -v $PWD:/terraform -w /terraform hashicorp/terraform'`
2. `terraform --version`
3. `terraform init`
4. `terraform plan`
5. `terraform apply`
6. `terraform show`

#### Clean up
1. `terraform destroy`

#### References
- Tutorial: https://simonfredsted.com/1459
- AWS "Scenario 2" blog: https://040code.github.io/2017/06/18/terraform-aws-vpc/
- AWS "Scenario 2" blog: https://nickcharlton.net/posts/terraform-aws-vpc.html
- AWS environment with Terraform: https://linuxacademy.com/howtoguides/posts/show/topic/13922-a-complete-aws-environment-with-terraform
