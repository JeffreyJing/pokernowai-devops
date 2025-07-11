resource "aws_ecr_repository" "backend" {
  name = "${var.name_prefix}-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = "${var.name_prefix}-backend"
  }
}
