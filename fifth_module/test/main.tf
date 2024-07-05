terraform {
  required_providers {
    textfile = {
      version = "~> 1.0.0"
      source = "terraform-example.com/exampleprovider/textfile"
    }
  }
}

provider "textfile" {}

resource "textfile" "example" {
  path    = "example.txt"
  content = "Hello, Terraform!"
}
