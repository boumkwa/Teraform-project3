#creating the lightsail instance

resource "aws_lightsail_instance" "custom" {
  name              = "custom"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2"

  bundle_id = "nano_1_0"

  user_data = <<-EOF
#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo bash -c 'echo "<h1>This Server is created using Terraform </h1>" > /var/www/html/index.html'
EOF
}

output "lightsail_server_public_ip" {
  value = aws_lightsail_instance.custom.is_static_ip
}
