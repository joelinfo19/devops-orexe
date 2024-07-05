package textfile

import (
	"context"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"os"
)

func resourceTextFile() *schema.Resource {
	return &schema.Resource{
		CreateContext: resourceTextFileCreate,
		ReadContext:   resourceTextFileRead,
		UpdateContext: resourceTextFileUpdate,
		DeleteContext: resourceTextFileDelete,

		Schema: map[string]*schema.Schema{
			"content": {
				Type:     schema.TypeString,
				Required: true,
			},
			"path": {
				Type:     schema.TypeString,
				Required: true,
			},
		},
	}
}

func resourceTextFileCreate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	path := d.Get("path").(string)
	content := d.Get("content").(string)

	err := os.WriteFile(path, []byte(content), 0644)
	if err != nil {
		return diag.FromErr(err)
	}

	d.SetId(path)
	return resourceTextFileRead(ctx, d, m)
}

func resourceTextFileRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	path := d.Id()

	content, err := os.ReadFile(path)
	if err != nil {
		if os.IsNotExist(err) {
			d.SetId("")
			return nil
		}
		return diag.FromErr(err)
	}

	d.Set("content", string(content))
	d.Set("path", path)

	return nil
}

func resourceTextFileUpdate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	return resourceTextFileCreate(ctx, d, m)
}

func resourceTextFileDelete(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	path := d.Id()

	err := os.Remove(path)
	if err != nil {
		return diag.FromErr(err)
	}

	d.SetId("")
	return nil
}
