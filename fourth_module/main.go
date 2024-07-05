package main

import (
	"fourth_module/example"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// Binary need to be called terraform-provider-"name", in this case terraform-provider-example
func main() {

	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: example.Provider,
	})
}
