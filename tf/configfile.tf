# Save the k8s config into the file
resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.main.kube_config_raw
  filename = "../k8s_config/kubeconfig"

}