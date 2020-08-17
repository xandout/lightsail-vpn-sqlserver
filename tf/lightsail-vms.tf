# LS appears to have a global namespace for instance names. Dumb but whatever
resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = false
  number  = false
}

variable "name_prefix" {
  default = "example"
}



resource "aws_lightsail_instance" "vpn_server" {
  # Prefixed ${var.name_prefix} because of "Some names are already in use" error. Lightsail...what is wrong with you?
  name              = "${var.name_prefix}-vpn-${random_string.random_suffix.result}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.ls_vpn_sql_kp.name
  provisioner "local-exec" {
    command = "aws lightsail put-instance-public-ports --instance-name=${var.name_prefix}-vpn-${random_string.random_suffix.result} --port-infos fromPort=22,toPort=22,protocol=tcp fromPort=1194,toPort=1194,protocol=udp"
  }

}

resource "aws_lightsail_instance" "sql_server" {
  # Prefixed ${var.name_prefix} because of "Some names are already in use" error. Lightsail...what is wrong with you?
  name              = "${var.name_prefix}-sql-${random_string.random_suffix.result}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "small_2_0" # SQL Server requires atleast 2GB
  key_pair_name     = aws_lightsail_key_pair.ls_vpn_sql_kp.name
  provisioner "local-exec" {
    command = "aws lightsail put-instance-public-ports --instance-name=${var.name_prefix}-sql-${random_string.random_suffix.result} --port-infos fromPort=22,toPort=22,protocol=tcp"
  }

}

resource "aws_lightsail_key_pair" "ls_vpn_sql_kp" {
  name = "${var.name_prefix}-ls-vpn-sql-${random_string.random_suffix.result}"
}

output "ls_vpn_sql_kp_private_key" {
  value = aws_lightsail_key_pair.ls_vpn_sql_kp.private_key
}

resource "local_file" "privkey" {
  content         = aws_lightsail_key_pair.ls_vpn_sql_kp.private_key
  filename        = "generated_data/ls_vpn_sql_kp.pem"
  file_permission = "0400"
}

resource "local_file" "pubkey" {
  content         = aws_lightsail_key_pair.ls_vpn_sql_kp.public_key
  filename        = "generated_data/ls_vpn_sql_kp.pem.pub"
  file_permission = "0400"
}

# If you have issues with "Some names are already in use", comment from here down and run terraform apply, then uncomment the next section and apply again.

resource "aws_lightsail_static_ip" "vpn_server_ip" {
  name = "${var.name_prefix}-vpn-${random_string.random_suffix.result}-ip"
}

resource "aws_lightsail_static_ip" "sql_server_ip" {
  name = "${var.name_prefix}-sql-${random_string.random_suffix.result}-ip"
}

resource "aws_lightsail_static_ip_attachment" "vpn_ip_attach" {
  static_ip_name = aws_lightsail_static_ip.vpn_server_ip.id
  instance_name  = aws_lightsail_instance.vpn_server.id
}

resource "aws_lightsail_static_ip_attachment" "sql_ip_attach" {
  static_ip_name = aws_lightsail_static_ip.sql_server_ip.id
  instance_name  = aws_lightsail_instance.sql_server.id
}
