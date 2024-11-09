region = "us-east-2"
instance_type = "t3.medium"
monitoring_value = false

common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "AWS Instance Creation"
    Environment = "Test Parameters"
}

allow_sg_ports = ["22", "80"]
