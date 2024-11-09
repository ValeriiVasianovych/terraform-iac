region = "eu-central-1"

vpc_cidr = "192.168.0.0/16"

public_subnet_cidr = "192.168.10.0/24"

allow_sg_ports = [80, 443, 22, 5432]

instance_type = "t3.medium"

common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "AWS Instance Creation"
    Environment = "Production"
}
