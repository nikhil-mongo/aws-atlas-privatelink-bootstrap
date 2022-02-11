terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
  required_version = ">= 0.13"
}

/*terraform {
 backend local {
    path = "../bootstrap/terraform.tfstate" 
  }
}*/