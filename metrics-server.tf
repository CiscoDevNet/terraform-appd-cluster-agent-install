# Per cluster agent requirements, we'll first need metrics-server installed.
# Comment this resource and the metrics namespace above if metrics-server
# is already installed in your environment. Also, note the extraArgs
# set in metrics-server-values.yaml and remove or readjust these values
# as needed for your environment.
resource "helm_release" "metrics-server" {
  name = "metrics-server"
  namespace = "metrics"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "metrics-server"

  values = [
    file("${path.module}/metrics-server-values.yaml")
  ]
}