terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {

  }
}

//grupo de recurso a ser criado no azure
//aula_rg é nome no terraform,   aula-rg é nome que será no azure
resource "azurerm_resource_group" "aula_rg" {
  name     = "aula-rg"
  location = "East US"
}

#cluster kubernete a ser criado no azure
resource "azurerm_kubernetes_cluster" "aula_k8s" {
  //name              = "aula-k8s"
  name                = var.k8s_name                            //usando variáveis
  location            = azurerm_resource_group.aula_rg.location //usar o location do resource group
  resource_group_name = azurerm_resource_group.aula_rg.name
  dns_prefix          = "aulak8s"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}

resource "local_file" "k8s_config" {
  content  = azurerm_kubernetes_cluster.aula_k8s.kube_config_raw
  filename = "kube_config_aks.yaml"
}


//******  blocos de variáveis  *******
#se tiver o arquivo terraform.tfvars com os valores setados lá, vai pegar de lá ao invés daqui, do default
variable "k8s_name" {
  description = "Nome do cluster kubernetes"
  type        = string
  default     = "aula-k8s"
}


variable "node_count" {
  description = "Quantidade de nodes"
  type        = number
  default     = 3
}
