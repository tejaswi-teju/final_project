variable "cidr" {
    type = string
    description = "This is my vpc"
}

variable "public_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
    description = "These are public subnets of vpc-1"
}

variable "private_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
    description = "These are private subnets for vpc-1"
}