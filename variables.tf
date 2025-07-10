ivariable "identity_name" {
  type        = string
  description = "Name of the user assigned identity"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the identity and FIC"
}

variable "location" {
  type        = string
  description = "Azure location for the identity"
}

variable "oidc_issuer_url" {
  type        = string
  description = "OIDC issuer URL from AKS"
}

variable "k8s_namespace" {
  type        = string
  description = "Namespace of the service account"
}

variable "k8s_service_account" {
  type        = string
  description = "ServiceAccount name"
}

variable "role_definition_ids" {
  type        = list(string)
  description = "List of role definition IDs to assign to the identity"
  default     = []
}

variable "role_assignment_scope" {
  type        = string
  description = "The Azure scope to assign the role(s) at (e.g., a resource group, subscription, or resource)"
}
