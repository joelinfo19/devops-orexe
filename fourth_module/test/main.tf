terraform {
  required_providers {
    example = {
      version = "~> 1.0.0"
      source  = "terraform-example.com/exampleprovider/example"
    }
  }
}


provider "example" {}

resource "example_resource" "example" {
  example = "Hello, World!"
}
