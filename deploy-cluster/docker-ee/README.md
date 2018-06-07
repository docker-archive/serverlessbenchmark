# Setup Docker EE cluster for the serverless benchmark

In this document, we detail how to deploy a Docker EE cluster for the purposes of the serverless benchmark on an AWS account. **NOTE**: the instructions below will deploy a cluster using a trial (1 month) license.

**Note: following this guide will provision Ec2 machines on your AWS account, for which you will be charged for by AWS.**

### Requirements

 - [Terraform](https://www.terraform.io/downloads.html) (version 0.11.7)
 - [Ansible](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (version 2.5.4)
 - An AWS account, an Ec2 KeyPair for an IAM account with the following permissions*:
   - EC2 (full access)
   - EFS (full access)
   - ELB (full access)
   - IAM (full access)
   - S3 (full access)
   - Route 53 (full access)
 - A [Docker EE trial subscription](https://success.docker.com/article/how-do-i-get-a-docker-enterprise-edition-trial-subscription) (ubuntu edition).
 - Your [Docker EE subscription ID](https://success.docker.com/article/how-do-i-access-my-docker-enterprise-edition-subscription). You can get the id by inspecting the URL shown on the bottom right corner of your subscription page.

\*: these permissions are likely too permissive, will provide finer grain access requirements soon.

### Deploying the cluster

Download the [Docker Certified Infrastructure for AWS](https://success.docker.com/article/certified-infrastructures-aws) (version 1.0.0) and place the `aws-v1.0.0.tar.gz` file in the `frameworks/cluster-setup/docker-ee` directory.

```
tar -zxvf aws-v1.0.0.tar.gz
cp terraform.tfvars aws-v1.0.0/
cd aws-v1.0.0
```

Now edit the `terraform.tfvars` file inside the `aws-v1.0.0` directory with your AWS credentials and Ec2 Key-Pair.

Now create the `inventory/extra-vars` file and include the following:

```
[all:vars]
docker_dtr_image_repository=docker
docker_dtr_version=2.5.2
docker_ucp_image_repository=docker
docker_ucp_version=3.0.1
docker_ee_release_channel=stable
docker_ee_version=17.06
docker_ee_package_version=3:17.06.2~ee~11~3-0~ubuntu
docker_ee_package_version_win=17.06.2-ee-10
docker_ee_subscriptions_ubuntu=<YOUR_DOCKER_EE_SUBSCRIPTION_ID>
```

Do the following inside the `aws-v1.0.0` directory.

```
terraform init
terraform apply -auto-approve
ansible-playbook --private-key=~/.ssh/private_key install.yml
```

Finally, configure the Docker EE cluster for the purposes of the serverless benchmark:

 - Using [this guide](https://docs.docker.com/ee/ucp/admin/configure/set-orchestrator-type/), set the orchestrator type of all worker nodes to Kubernetes.
 - Under admin > Admin Settings > Scheduler, uncheck all boxes under Container Scheduling.

### Deleting the cluster

```
terraform destroy -force
```

### Notes

 - This deployment creates a node running Docker Trusted Registry, which isn't necessary for the benchmarking purposes, but is created nonetheless by the Docker Certified Infrastructure scripts. It is fine to shut it down / remove it from the cluster.

### TODO

 - Update these instructions to use Docker Certified Infrastructure for AWS (version 2.0.0) as soon as it is available. This is required to allow kubernetes to provision AWS resources and create deployments without DTR.
 - Remove the requirement for a DTR node, it isn't necessary.
