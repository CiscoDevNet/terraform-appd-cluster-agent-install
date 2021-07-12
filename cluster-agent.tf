# Deploy the AppDynamics cluster agent using AppDynamic's helm chart
resource "helm_release" "cluster-agent" {
  name = "cluster-agent"
  namespace = "appdynamics"
  repository = "https://appdynamics.github.io/appdynamics-charts"
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
  }

  set {
    name  = "imageInfo.agentImage"
    value = var.agentImage
  }

  set {
    name  = "imageInfo.agentTag"
    value = var.agentTag
  }

  set {
    name  = "imageInfo.operatorImage"
    value = var.operatorImage
  }

  set {
    name  = "imageInfo.operatorTag"
    value = var.operatorTag
  }

  set {
    name  = "imageInfo.imagePullPolicy"
    value = var.imagePullPolicy
  }

  set {
    name  = "clusterAgent.nsToMonitor"
    value = var.nsToMonitor
  }

}