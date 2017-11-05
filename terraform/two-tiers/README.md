#### User story
As a DevOps team member, I want to build infrastructure _([AWS Scenario 2](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario2.html))_ in AWS using [Terraform](https://www.terraform.io/) for development purpose.

If you don't have an AWS account, create [free-tier](https://aws.amazon.com/free/) one now.

<p align="center">
  <img src="../pics/user_6212_58f4de3f53474.png_800.jpg" alt="AWS infra" style="width: 250px;"/>
</p>

#### Assumptions
- Latest version of Docker is installed
- AWS credentials are available at: "~/.aws/credentials"
    ```
    [default]
    aws_access_key_id = <KEY>
    aws_secret_access_key = <SECRET>
    ```

#### Prerequisite if standing up a vagrant box
If of some reason docker can not be run natively on your platform, feel free to use the provided Vagrantfile to setup a VM which will have a docker engine installed.

Vagrant coppies a number of files and folders (like aws credentials) from host to guest machine _(Modify the Vagrantfile as per your needs)_
- Run `vagrant up` command to create a VM
-	Run `vagrant ssh` to log into the VM

#### Instructions
On the platform where docker engine is installed, execute the following commands to clone this repo:
1. `alias git='docker run -it --rm --name git -v $PWD:/git -w /git indiehosters/git git'`
2. `git version`
3. `git clone https://github.com/shazChaudhry/infra.git`
4. `sudo chown -R $USER infra`
5. `cd infra/terraform/two-tiers`

Terraform docker image is available at https://hub.docker.com/r/hashicorp/terraform/. Execute the following commands to run terraform:
1. `alias terraform='docker run -it --rm --name terraform -v ~/.ssh/id_rsa.pub:/home/root/.ssh/id_rsa.pub -v ~/.aws/credentials:/home/root/.aws/credentials -v $PWD:/terraform -w /terraform hashicorp/terraform'`
2. `terraform --version`
3. `terraform init`
4. `terraform plan -out=tfplan`
5. `terraform apply tfplan`
6. `terraform show`

#### Testing
- Navigate to https://console.aws.amazon.com/ec2 page
- On instance plage, make a note of public IP of 'phpapp' instance
- Open a new tab in your web browser, and visit `http://[PHPAPP_IP]/calldb.php`
- If all has gone well, then you should see the following text:
  - `the value is: linuxacademythebest`

#### Clean up
- `terraform destroy -force`

#### References
For the purpose of learning Terraform, the idea for this repository was taken from the Linux Academy; A complete AWS environment with Terraform: https://linuxacademy.com/howtoguides/posts/show/topic/13922-a-complete-aws-environment-with-terraform

##### Other refs
I have also found these blogs useful in learning Terraform:
- AWS "Scenario 2" blog: https://nickcharlton.net/posts/terraform-aws-vpc.html
- Tutorial: https://simonfredsted.com/1459
