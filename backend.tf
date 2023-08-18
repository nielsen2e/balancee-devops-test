# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "balancee-terraform-remote-state-file"
    key    = "project-application.tfstate"
    region = "eu-west-2"
  }
}