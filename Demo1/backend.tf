terraform {
  required_version = ">=1.15.0"

  cloud {
    
    organization = "Vedaj-org"

    workspaces {
      name = "Demo-terraform-lab"
    }
  }
}