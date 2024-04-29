resource "aws_ssm_document" "base_packages_al2023" {
  name          = "install-base-al2023-${var.vpc_name}"
  document_type = "Command"

  content = <<EOF
{
  "schemaVersion": "2.2",
  "description": "Install AWS CLI tools with apt",
  "mainSteps": [
    {
      "action": "aws:runShellScript",
      "name": "install_awscli",
      "inputs": {
        "runCommand": [
          "dnf update -y",
          "dnf install -y awscli rsync jq wget mariadb105-server openssh-clients amazon-efs-utils nmap-ncat htop git tar unzip"
        ]
      }
    }
  ]
}
EOF
}

resource "aws_ssm_document" "base_packages_al2" {
  name          = "install-base-al2-${var.vpc_name}"
  document_type = "Command"

  content = <<EOF
{
  "schemaVersion": "2.2",
  "description": "Install AWS CLI tools with apt",
  "mainSteps": [
    {
      "action": "aws:runShellScript",
      "name": "install_awscli",
      "inputs": {
        "runCommand": [
          "yum update -y",
          "yum install -y awscli rsync jq wget mysql openssh-clients amazon-efs-utils nmap-ncat htop git tar unzip"
        ]
      }
    }
  ]
}
EOF
}
