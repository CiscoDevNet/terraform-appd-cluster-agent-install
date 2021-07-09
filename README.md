# Installing the Appdynamics cluster agent with Terraform
This repo contains shows how we can automation the installation of the AppDynamics `cluster-agent` on Kubernetes using Terraform.

### Requirements

You'll require the following to make this work in your environment:

- Kubernetes installed - we are using Intersight IKS (Intersight Kubernetes Service) Kubernetes deployed environment
- A Kubernetes `kubeconfig` file, ours is named `da-compute-kubeconfig.yml` but you can name yours with a name that makes the most sense for you but be sure to change the variable name in `terraform-appd-cluster-agent.tf`.
- Helm (we tested with version 3.3.4)
- Create your own `secret.tfvars` file with values set for variables mentioned in the lab further down in this README.md file

### Values for `secret.tfvar`

Terraform keeps sensitive values in a file named `secret.tfvar`and, because the values contain sensitive information such as account credentials, it's not posted here so you'll need to make one using your credentials.

| Variable               | Description |
| -----------------------| ----------- |
| controller_url         | Title       |
| controller_account     | Text        |


### Sample File

```
# AppDynamics controller credentials
controller_url       = "https://example.saas.appdynamics.com:443"
controller_account   = "somenane"
controller_username  = "horses"
controller_password  = "myC00lpas$$W0rd"
controller_accessKey = "v12345b234"
```