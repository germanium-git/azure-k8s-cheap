# Azure Subscription - Add subscription ID to the terraform.tfvars
variable "subscription_id" {
}

# Specify Azure region to deploy AKS
variable "location" {
    default = "West Europe"
}

# Specify a Local value to derive unique names for resource group, k8s cluster, ingress-ip etc.
locals {
    name      = "nemedpet"
}


variable "k8s_vm_size" {
    type        = string
    description = "VM Size"
    default     = "Standard_B2s"

    validation {
        condition = anytrue([
            var.k8s_vm_size == "Standard_B2s",
            var.k8s_vm_size == "Standard_B2ms"
        ])
        error_message = "VM Size must be 'Standard_B2s' or 'Standard_B2ms'"
    }
}


variable "k8s_cluster_name" {
    default = "nemedpet"
    type    = string
    validation {
        condition = (
            length(var.k8s_cluster_name) <= 12 &&
            can(regex("^([a-z]|[a-z]?[0-9])",var.k8s_cluster_name))
        )
        error_message = "Must start with a lowercase letter, have max length of 12, and only have characters a-z0-9"
    }
}

variable "k8s_node_count" {
    description   = "Number of k8s worker nodes"
    default       = 1
    type          = number
    validation {
        condition = (
            var.k8s_node_count >= 1 &&
            var.k8s_node_count <= 3
        )
        error_message = "Must be between 1 and 3, inclusive."
    }
}

variable "k8s_nw_cidr" {
    type = string
    description = "CIDR range for k8s internal network"
    validation {
        condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/(2[3-4])$",var.k8s_nw_cidr))
        error_message = "Invalid CIDR format provided. Only A.B.C.D/23 or A.B.C.D/24 is accepted"
    }
    default = "172.100.0.0/24"
}

variable "docker_bridge_cidr" {
    type = string
    description = "CIDR range for k8s internal network"
    validation {
        condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/(16)$",var.docker_bridge_cidr))
        error_message = "Invalid CIDR format provided. Only A.B.C.D/23 or A.B.C.D/24 is accepted"
    }
    default = "172.101.0.0/16"
}