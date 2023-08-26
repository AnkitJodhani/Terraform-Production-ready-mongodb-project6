# 🌍 Terraform script to provisiond MongoDB sharded cluster on AWS

Welcome to the MongoDB sharded cluster provisioning repository! Here, you'll find all the necessary resources and instructions to set up a highly available and scalable MongoDB sharded cluster on the AWS cloud.

## 🏠 Architecture
![Architecture of the application](architecture.gif)

## 🚀 Why Use a Sharded Cluster?
A sharded cluster is designed to handle large datasets and high workloads by distributing data across multiple machines. This architecture offers horizontal scalability, making it an ideal choice for applications that require seamless scaling as user demand grows. With automatic data distribution and failover mechanisms, a sharded cluster ensures both data availability and reliability.


## 🖥️ Installation of Terraform
**Note** To get started, make sure you have Terraform installed on your machine. The provided installation script helps you set up Terraform quickly on an Amazon Linux environment.

```sh
#!/bin/bash

# fail on any error
set -eu

# install yum-config-manager to manage your repositories
sudo yum install -y yum-utils

# use yum-config-manager to add the official HashiCorp Linux repository
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# install terraform
sudo yum -y install terraform

# verify terraform is installed
terraform --version
```

## 📦 Cloning the Repository
Start by cloning this repository to your local machine. Navigate into the project directory to access all the necessary files for setting up the MongoDB sharded cluster.

```sh
git clone https://github.com/AnkitJodhani/Terraform-Production-ready-mongodb-project6.git 
cd Terraform-Production-ready-mongodb-project6
```

## 🔑 Generating SSH Keys
Secure communication between cluster components is essential. Follow the steps provided to generate SSH keys and store them in the designated directory `/module/KEY/`. These keys will be used for authentication purposes within the cluster.
**Note** We need to generate Public key and private key and need to store in `/module/KEY/` directory.

```sh
cd module/KEY/
ssh-keygen.exe 
```

**Note:** Please rename the with *controller.pub* & *controller* because that is predefinde in terraform script.

## Ansible (Optional)
If you prefer an automated approach to configuring your MongoDB sharded cluster, consider exploring the Ansible integration.The provided [Ansible script](https://github.com/AnkitJodhani/Ansible-Production-ready-mongodb-project6.git) repository offers automation for various aspects of cluster management.

## Blog link
For a comprehensive guide on setting up a production-ready MongoDB sharded cluster using both Terraform and Ansible, check out the accompanying [blog post](https://github.com/AnkitJodhani/Ansible-Production-ready-mongodb-project6.git). The blog covers step-by-step instructions, best practices, and insights into optimizing your cluster for performance and reliability.

## configuration

Customize the `terraform.tfvars` file to tailor the cluster setup to your specific requirements. Set variables such as the region, project name, instance sizes, and network configurations.

```sh
vim main/terraform.tfvars
```

file containe many importnat varialbe that will be needed terraform to spin up the desired infrastrcutre.

```sh
REGION           = ""
PROJECT_NAME     = ""
CPU              = ""
AMI              = ""
MAX_SIZE         = ""
MIN_SIZE         = ""
DESIRED_CAP      = ""
VPC_CIDR         = ""
PUB_SUB_1_A_CIDR = ""
PUB_SUB_2_B_CIDR = ""
PUB_SUB_3_C_CIDR = ""
PRI_SUB_4_A_CIDR = ""
PRI_SUB_5_B_CIDR = ""
PRI_SUB_6_C_CIDR = ""
PRI_SUB_7_A_CIDR = ""
PRI_SUB_8_B_CIDR = ""
PRI_SUB_9_C_CIDR = ""

```

## ✈️ Now we are ready to deploy our application on cloud ⛅
get into project directory 
```sh
cd Terraform-Production-ready-mongodb-project6/main/
```

type below command to see plan of the exection 
```sh
terraform plan
```

✨Finally, HIT the below command to deploy the application...
```sh
terraform apply 
```

type `yes`, it will prompt you for permission..

## 🎉 Congratulations!

Your MongoDB sharded cluster is now up and running on the AWS cloud! You've successfully set up a powerful and scalable database system that can handle your application's growing needs. If you have any questions or encounter any issues, refer to the blog post or reach out to the community for assistance.

**Thank you for choosing this repository for your MongoDB cluster deployment. Happy coding! 🚀**