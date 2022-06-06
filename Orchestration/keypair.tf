resource "tls_private_key" "common" {
  algorithm = "RSA"
  rsa_bits = 4096
}