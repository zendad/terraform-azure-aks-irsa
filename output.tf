
output "client_id" {
  value = azurerm_user_assigned_identity.this.client_id
}

output "identity_id" {
  value = azurerm_user_assigned_identity.this.id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
}
