region = "eu-west-1"
instance_type = "t4.medium"
monitoring_value = true

common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "AWS Instance Creation"
    Environment = "Example Parameters"
}

allow_sg_ports = ["21", "123", "9191", "80"]
