resource "aws_instance" "AprilDevopsEC2" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_name
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [var.vpc_security_group_ids]
    associate_public_ip_address = true

    tags = {
        Name = "AprilDevopsEC2"
}

}