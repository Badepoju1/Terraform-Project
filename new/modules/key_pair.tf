# Generate RSA Key pair

resource "tls_private_key" "bade-key" {
  algorithm = "RSA"
  rsa_bits = 2048
  }

# Generate Public key pair

resource "aws_key_pair" "bade-key" {
    key_name = "bade-key"
  public_key = tls_private_key.bade-key.private_key_openssh
}

#Creating local file to save the generated key pair

resource "local_file" "bade-key" {
  filename = "bade-key.pem"
  content = tls_private_key.bade-key.private_key_pem
}