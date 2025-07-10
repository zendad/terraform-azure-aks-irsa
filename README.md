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
