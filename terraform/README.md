### multi-env
- _(Work in Progress)_

This example assumes terraform can be executed natively on your platform.

<p align="center">
  <img src="./pics/three-vpcs-peered-diagram.png" alt="AWS infra" style="width: 250px;"/>
</p>

Infrastructure created with terraform makes use of modules to spin up multiple environment. Each environment is in its own VPC. Communication between all environments is via VPC peering.
- Environment `logging` is reserved for setting up Elastic Stack where application logs are aggregated. Elastic will also be used for monitoring all environments within multi-env example
- Environment `common` is reserved for setting up a SSO / Authentication & Authorization componennt
- Environment `devops` is reserved for setting up Continuous Integration tools i.e. Jenkins, GitLab, etc.
