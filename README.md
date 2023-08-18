## Introduction:
This repository contains Terraform scripts to set up an AWS environment for a basic python web application.

## Github Repository Structure
.
├── modules
│   ├── subnet
│   │   └── main.tf
│   │    └── outputs.tf
│   │    └── variables.tf
│   ├── webserver
│   │   └── main.tf  
│   │   └── outputs.tf
│   │   └── variables.tf 
├── .terraform.lock.hcl
├── backend.tf
├── entry-script.sh
├── main.tf
├── outputs.tf
├── README.md
└── variables.tf

### Modules:
Modules in Terraform are used to encapsulate a group of resources and can be reused across different environments or AWS accounts. Here, there are two modules: subnet and webserver.

#### Subnet Module:
**main.tf:** The main configuration file for the subnet module. This will define the necessary AWS resources to create subnets, within a VPC.

**outputs.tf:** Defines any values that the subnet module will output once it's been applied. For instance, it could output the subnet IDs created.

**variables.tf:** Defines the variables specific to the subnet module. These could include things like the VPC ID, CIDR blocks for the subnets, availability zones, etc.

#### Webserver Module:
**main.tf:** This configuration will set up the necessary resources for the webserver, potentially including EC2 instances, security groups, and associated rules.

**outputs.tf:** Outputs specific to the webserver module. For instance, it could output the public IPs of the created EC2 instances.

**variables.tf:** Variables specific to the webserver module. These could include instance type, AMI ID, number of instances, etc.

**.terraform.lock.hcl:** This file is used for locking the dependency versions of providers, ensuring consistent behavior and versioning. 

**backend.tf:** This file will define the backend for Terraform. The backend determines how Terraform stores its state. Often, in a collaborative environment, this would be configured to use a remote backend like Amazon S3.

**entry-script.sh:** This is a shell script for simplifying or automating certain tasks related to the Terraform setup, e.g., initializing Terraform, applying changes, and initializing application setup.

**main.tf:** The primary configuration file for Terraform. This file will use modules and other resources to set up the required infrastructure.

**outputs.tf:** This file declares outputs. Outputs are like return values for Terraform modules. After running terraform apply, you can get the values of any output variables using terraform output <output_name>.

**README.md:** A markdown file that provides information about the project, how to use it, any pre-requisites, and other necessary instructions.

**variables.tf:** This file declares all the variables that will be used in the Terraform configuration. Variables can be configured with default values or left to be set when executing Terraform commands.

### Overall Design Thought Process:
This setup indicates a design that is focused on modularization and reusability. By isolating the subnet and webserver configurations into modules, these setups can be reused in different environments or projects with minimal changes. For instance, if you wanted to replicate this in a staging and a production environment, you could do so easily by just referencing the modules with different variable values.

The presence of an `entry-script.sh` suggests an intention to automate and streamline the process of infrastructure setup, making it even more user-friendly and reducing the possibility of human errors during setup.

The split between the main files and the module-specific files allows for a clean and organized codebase, which becomes especially beneficial as the infrastructure grows and becomes more complex.

## Architecture:


## Prerequisites:
- AWS Account
- Terraform installed on your local machine (v0.14 or above)
- AWS CLI configured with AWS account credentials

## Execution:
1. Clone this repository to your local machine.
2. Navigate to the cloned repository's directory in your terminal.
3. Update the variables.tf file with the correct values for your AWS environment.
4. Run `terraform init` to initialize Terraform in the directory.
5. Run `terraform plan` to see the changes that will be made.
6. Run `terraform apply` to apply the changes. Confirm with yes when prompted.

**NB:** terraform.tfvars will be available locally and should not be commited to version control.

## Challenges and Solutions:
**Challenge:** Balancing the cost and performance while selecting the instance types.
Solution: We used t2.micro instances for EC2, which are cost-effective and provide a decent performance for small to medium-sized applications.

## Design and Technology Choices:
**Terraform:** I chose Terraform for Infrastructure as Code (IaC) due to its provider-agnostic approach. It allows us to use the same language for multiple platforms, increasing reusability and reducing the learning curve.

**AWS:** I chose AWS because it offers a wide variety of services that are scalable, reliable, and highly available. It also has good documentation and community support.

## Cleanup:
Run `terraform destroy` and confirm with yes when prompted to delete the resources created by Terraform to avoid unnecessary AWS charges.