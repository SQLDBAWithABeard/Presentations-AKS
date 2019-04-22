variable "presentation" {
    description = "The name of the presentation - used for tagging Azure resources so I know what they belong to"
    default = "__Presentation__"
}

variable "resource_group_name" {
   default =   "aks"
}

variable "location" {
   default =   "westeurope"
}

variable "ssh_public_key" {
   type         = "string"
   default      = ""
   description  = "Public key for aksadmin's SSH access."
}

variable "agent_count" {
   default =   2
}

variable "vm_size" {
   default =   "Standard_DS2_v2"
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "testing"
    }
}