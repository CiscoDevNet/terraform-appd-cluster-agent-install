##################################################################################
# VARIABLES
##################################################################################

### Define variables needed for the cluster agent helm chart
variable "controller_url" {
  description = "AppDynamics controller URL"
  type        = string
  sensitive   = true
}

variable "controller_account" {
  description = "DevNet AppDynamics controller account name"
  type        = string
  sensitive   = true
}

variable "controller_username" {
  description = "DevNet AppDynamics controller username"
  type        = string
  sensitive   = true
}

variable "controller_password" {
  description = "DevNet AppDynamics controller password"
  type        = string
  sensitive   = true
}

variable "controller_accessKey" {
  description = "DevNet AppDynamics controller access key"
  type        = string
  sensitive   = true
}

variable "agentImage" {
  description = "What image to download from Docker.io"
  type        = string
}

variable "agentTag" {
  description = "Version tag of Cluster-Agent"
  type        = string
}

variable "operatorImage" {
  description = "The image type, as in the type of agent to install"
  type        = string
}

variable "operatorTag" {
  description = "The operator tag set to latest"
  type        = string
}

variable "imagePullPolicy" {
  description = "Image pull policy variable set to always"
  type        = string
}

variable "nsToMonitor" {
  description = "Variable containing the namespaces the cluster agent will monitor"
  type        = string
}

# Define variables defined in or included in a kubeconfig
variable "kubeconfig" {
  description = "Variable contains the values of an entire kubeconfig for the target kubernetes cluster"
  type        = string
}

