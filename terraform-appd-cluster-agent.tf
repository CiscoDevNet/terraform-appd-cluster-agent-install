##################################################################################
# VARIABLES
##################################################################################

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

##################################################################################
# PROVIDERS
##################################################################################
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.2.0"
    }
 }
}

provider "kubernetes" {
  config_path = "da-compute-kubeconfig.yml" # NOTE: Change this value to your kubeconfig file
}

provider "helm" {
  kubernetes {
    config_path = "da-compute-kubeconfig.yml"
  }
}

resource "kubernetes_namespace" "appdynamics" {
  metadata {
    name = "appdynamics"
  }
}

resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
  }
}
# Per cluster agent requirements, we'll first need metrics-server installed.
# Comment this resource and the metrics namespace above if metrics-server
# is already installed in your environment. Also, note the extraArgs
# set in metrics-server-values.yaml and remove or readjust these values
# as needed for your environment.
resource "helm_release" "metrics-server" {
  name = "metrics-server"
  namespace = "metrics"
  repository = "https://kubernetes-sigs.github.io/metrics-server/" # https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server
  chart = "metrics-server"

  set {
    name  = "args.0"
    value = "--kubelet-preferred-address-types=InternalIP"
  }
}
# Deploy the AppDynamics cluster agent using AppDynamic's helm chart
resource "helm_release" "cluster-agent" {
  name = "cluster-agent"
  namespace = "appdynamics"
  repository = "https://appdynamics.jfrog.io/artifactory/appdynamics-cloud-helmcharts/"
  chart = "cluster-agent"

  values = [
    file("${path.module}/iks-cluster-2.yaml")
  ]
# Values below are required the cluster agent configuration file. The values are
# available in sensitive.yaml.
  set_sensitive {
    name  = "controllerInfo.url"
    value = var.controller_url
  }
  
  set_sensitive {
    name  = "controllerInfo.account"
    value = var.controller_account
  }
  
  set_sensitive {
    name  = "controllerInfo.username"
    value = var.controller_username
  }
  
  set_sensitive {
    name  = "controllerInfo.password"
    value = var.controller_password
  }
  
  set_sensitive {
    name  = "controllerInfo.accessKey"
    value = var.controller_accessKey
  } # If using accessKey, it is possible you may not need username and password
}
