# Auto fill the values for production

region = "ca-central-1"
instance_type = "t2-medium"
monitoring_value = true

common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "AWS Instance Creation"
    Environment = "Production"

}

allow_sg_ports = ["22", "80", "443", "8080", "3306", "9090"]
