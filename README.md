# terraform-azure-aks-irsa

This Terraform module creates an Azure **User Assigned Managed Identity**, configures a **federated identity credential** to allow a Kubernetes ServiceAccount to use it, and optionally assigns Azure roles to the identity.

# Features
- Creates a User Assigned Managed Identity (UAMI)
- Adds a Federated Identity Credential linking the UAMI to a Kubernetes ServiceAccount
- Assigns one or more Azure RBAC roles to the identity

# Usage

```hcl
module "aks_service_account" {
  source = "."
  identity_name         = "app-storage-access"
  resource_group_name   = "rg-aks-weu"
  location              = "westeurope"
  oidc_issuer_url       = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  k8s_namespace         = "ns-app-sa"
  k8s_service_account   = "app-sa"
  role_assignment_scope = azurerm_storage_account.app_storage.id
  role_definition_ids   = [
    data.azurerm_role_definition.storage_blob_data_contributor.id
  ]
}
```

## Usage ServiceAccount Annotation
To allow the Kubernetes ServiceAccount to assume the managed identity, you must annotate it with the identity's client ID:

```hcl
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-sa
  namespace: default
  annotations:
    azure.workload.identity/client-id: "<MANAGED_IDENTITY_CLIENT_ID>"
```
Replace <MANAGED_IDENTITY_CLIENT_ID> with the client_id output from this module.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity_name"></a> [identity\_name](#input\_identity\_name) | Name of the user assigned identity | `string` | n/a | yes |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | Namespace of the service account | `string` | n/a | yes |
| <a name="input_k8s_service_account"></a> [k8s\_service\_account](#input\_k8s\_service\_account) | ServiceAccount name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for the identity | `string` | n/a | yes |
| <a name="input_oidc_issuer_url"></a> [oidc\_issuer\_url](#input\_oidc\_issuer\_url) | OIDC issuer URL from AKS | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group in which to create the identity and FIC | `string` | n/a | yes |
| <a name="input_role_assignment_scope"></a> [role\_assignment\_scope](#input\_role\_assignment\_scope) | The Azure scope to assign the role(s) at (e.g., a resource group, subscription, or resource) | `string` | n/a | yes |
| <a name="input_role_definition_ids"></a> [role\_definition\_ids](#input\_role\_definition\_ids) | List of role definition IDs to assign to the identity | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_identity_id"></a> [identity\_id](#output\_identity\_id) | n/a |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
