variable "presentation" {
    description = "The name of the presentation - used for tagging Azure resources so I know what they belong to"
    default = "__Presentation__"
}

variable "ResourceGroupName" {
  description = "The Resource Group Name"
   default =   "__ResourceGroupName__"
}

variable "location" {
  description = "The Azure Region in which the resources in this example should exist"
   default =   "__location__"
}

variable "ssh_public_key" {
   type         = "string"
   default      = ""
   description  = "Public key for aksadmin's SSH access."
}

variable "agent_count" {
   description  = "The number of Nodes to provision"
   default =  "__agent_count__"
}

variable "VMSize" {
  description = "The size of the VM such as Standard_DS1_v2"
   default =   "__VMSize__"
}
variable "ClusterName" {
  description = "The name of the cluster"
   default =   "__ClusterName__"
}
variable "AgentPoolName" {
  description = "The name of the AgentPool"
   default =   "__AgentPoolName__"
}
variable "ServiceName" {
  description = "The name of the ServiceName"
   default =   "__ServiceName__"
}
