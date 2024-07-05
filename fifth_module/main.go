package main

import (
	"fifth_module/textfile"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: textfile.Provider,
	})
}
