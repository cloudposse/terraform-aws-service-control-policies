package test

import (
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"log"
	"os"
	"path"
	"path/filepath"
	"regexp"
	"strings"
	"testing"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
	terraform.Destroy(t, terraformOptions)
}

func applyPolicies(t *testing.T, tempTestFolder string, policyFile string) {
	randID := strings.ToLower(random.UniqueId())
	attributes := []string{randID}

	varFiles := []string{"fixtures.us-east-2.tfvars"}
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"attributes": attributes,
			"list_config_paths": []string{policyFile},
		},
	}
	// Keep the output quiet
	if !testing.Verbose() {
		terraformOptions.Logger = logger.Discard
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	organizationsPolicyId := terraform.Output(t, terraformOptions, "organizations_policy_id")
	// Verify we're getting back the outputs we expect
	assert.NotEmpty(t, organizationsPolicyId)

	// Run `terraform output` to get the value of an output variable
	organizationsPolicyArn := terraform.Output(t, terraformOptions, "organizations_policy_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, organizationsPolicyArn, "/service_control_policy/"+organizationsPolicyId)
}


// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)
	defer os.RemoveAll(tempTestFolder)

	catalogRegEx, e := regexp.Compile("^.+\\.(yaml)$")
	if e != nil {
		log.Fatal(e)
	}

	e = filepath.Walk(path.Join(path.Dir(rootFolder), "./catalog"), func(path string, info os.FileInfo, err error) error {
		if err == nil && catalogRegEx.MatchString(info.Name()) {
			applyPolicies(t, tempTestFolder, path)
		}
		return nil
	})
	if e != nil {
		log.Fatal(e)
	}
}
