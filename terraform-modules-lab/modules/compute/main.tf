resource "null_resource" "server" {
  triggers = {
    name = var.server_name
  }
}
