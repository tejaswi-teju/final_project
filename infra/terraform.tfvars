#vpc CIDR
cidr = "192.168.0.0/24"

# public subnets
public_subnet = {
    subnet1 = {
        cidr = "192.168.0.0/28"
        az = "us-east-2a"
    }

    subnet2 = {
        cidr = "192.168.0.16/28"
        az = "us-east-2b"
    }
}

# private subnets
private_subnet = {
    subnet1 = {
        cidr = "192.168.0.128/28"
        az = "us-east-2a"
    }

    subnet2 = {
        cidr = "192.168.0.144/28"
        az = "us-east-2b"

    }
}
