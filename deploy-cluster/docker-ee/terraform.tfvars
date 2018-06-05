# Docker EE Cluster Topology
####################################
linux_ucp_manager_count    = 1
linux_ucp_worker_count     = 2
linux_dtr_count            = 1
windows_ucp_worker_count   = 0
deployment                 = "serverless-bench-"                 # VM/Hostname prefix string. Prepended to all resources.
# Docker EE Configuration
####################################
ansible_inventory          = "inventory/1.hosts"
ucp_license_path           = "./docker_subscription.lic"
ucp_admin_password         = ""                          # If unset, check $ansible_inventory for generated value

# AWS Credentials
###################################
# Nota Bene: you need to have ~/.aws/credentials in place
region                     = "us-west-2"      # The region to deploy (e.g. us-east-2)
key_name                   = ""               # (a short string identifying your AWS Ec2 KeyPair, e.g. "alice")
# Make sure this key has no password to enable automatic retrieval of Windows instance passwords.
private_key_path           = ""               # The path to the private key corresponding to key_name

# AWS AMIs for Docker EE
###################################
# Linux instances will use the newest AMI matching this pattern
# Windows instances will use the newest AMI matching this pattern
# VM Credentials and Domains
####################################
#windows_user               = "Administrator"
#windows_admin_password     = ""
# Docker EE VM Settings
####################################
#See instances.auto.tfvars to change Instance Types
#linux_manager_volume_size  = 100
#linux_worker_volume_size   = 20
#windows_worker_volume_size = 100
#dtr_instance_volume_size   = 100
# Docker EE Uninstallation
####################################
#linux_ucp_uninstall_command   = ""
#windows_ucp_uninstall_command = ""
#linux_dtr_uninstall_command   = ""
# Load balancer DNS names
####################################
#docker_ucp_lb                 = "ucp.example.com"
#docker_dtr_lb                 = "dtr.example.com"
# AWS Configuration Options
###################################
# VPC configuration
# By default, a new VPC will be created with all appropriate routes and subnets.
# However, if you wish to use a pre-existing VPC then:
# 1. Set the existing VPC ID here
# 2. Allocate a block of IP addresses within, as vpc_cidr.
# Terraform will create one subnet within this block for each availablility zone.
# This will take up a further 4 bits in the address, so vpc_cidr can't be larger than a /22.
# After running terraform, you'll need to associate the new subsets with some routing
# table and ensure that they have Internet access.
#vpc_id                       = "vpc-0417d63da5aeb8ed6"
#vpc_cidr                     = "10.0.16.0/20"
#efs_supported                 = 1 # 1 if the region supports EFS (0 if not)
# OPTIONAL: Database VM
####################################
#linux_database_count = 0
#windows_database_count = 0
# OPTIONAL: Build VM
####################################
#linux_build_server_count = 0
#windows_build_server_count = 0
linux_user = "ubuntu"
efs_supported = 0
linux_ami_owner = "099720109477"
linux_ami_name = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20180109"
# windows_ami_owner = ""
# windows_ami_name  = ""  # Was using ami-8f5366ea, which doesn't appear to exist
