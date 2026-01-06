output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.app.public_ip
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ubuntu@${aws_instance.app.public_ip}"
}

output "docker_install_status" {
  description = "Docker installation status"
  value       = "Docker should be installed via user_data. Run: ssh ubuntu@${aws_instance.app.public_ip} 'docker --version'"
}

