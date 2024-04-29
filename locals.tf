locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Project    = "ec2-temp"
    Managed_By = "Terraform"
    Created_by = var.creator
  }
}

