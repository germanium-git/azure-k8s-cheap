# Create k8s cluster
resource "azurerm_kubernetes_cluster" "main" {
    name                = var.k8s_cluster_name
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    dns_prefix          = var.k8s_cluster_name

    default_node_pool {
        name       = var.k8s_cluster_name
        node_count = var.k8s_node_count
        vm_size    = var.k8s_vm_size
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        network_plugin     = "azure"
        service_cidr       = var.k8s_nw_cidr
        dns_service_ip     = cidrhost(var.k8s_nw_cidr, 10)
        docker_bridge_cidr = var.docker_bridge_cidr
        load_balancer_sku  = "standard"
    }
}

output "k8s_api_url" {
  value     = azurerm_kubernetes_cluster.main.fqdn
  sensitive = false
}

output "azurerm_kubernetes_cluster" {
  value     = azurerm_kubernetes_cluster.main
  sensitive = true
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}

output "k8s_host" {
  value = azurerm_kubernetes_cluster.main.kube_config[0].host
  sensitive = true
}

output "k8s_client_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
  sensitive = true
}

output "k8s_client_key" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].client_key
  sensitive = true
}

output "k8s_cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  sensitive = true
}