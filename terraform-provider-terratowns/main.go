// package main: Declare the package name
// The main package is special in Go, it's where the execution of the program starts.
package main

// import fmt package, fmt is short for format, functions for formatted I/O. 
import (
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// defines the main function, the entry point to the app
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider
	})
	// Format.PrintLine to standard output
	fmt.Println("Hello World")
}

// in golang a titlecase function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Resource{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service"
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // make the token sensitive to hide it in the logs
				Required: true,
				Description: "Bearer token for authorization"
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				ValidateFunc: validateUUID
			}
		}
	}
	p.ConfigureContextFunc = providerConfigure(p)
	return p
}