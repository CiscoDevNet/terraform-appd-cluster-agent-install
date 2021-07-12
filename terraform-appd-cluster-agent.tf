##################################################################################
# LOCAL VARIABLES
##################################################################################

locals{
  kube_config = yamldecode(var.kubeconfig)
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

output "instance_ips" {
  value = local.kube_config.clusters[0].cluster.server
}

provider "kubernetes" {
  host = local.kube_config.clusters[0].cluster.server
  client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
  client_key = base64decode(local.kube_config.users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
}

provider "helm" {
  kubernetes {
    host = local.kube_config.clusters[0].cluster.server
    client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
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