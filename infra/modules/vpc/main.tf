resource "aws_vpc" "main" {
    cidr_block = var.cidr
    tags = {
        Name = "vpc-1"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    for_each = var.public_subnet
    cidr_block = each.value.cidr
    availability_zone = each.value.az 
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet-${each.key}"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    for_each = var.private_subnet
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    tags = {
        Name = "private_subnet-${each.key}"
    }
}

resource "aws_internet_gateway" "igw-1" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "igw-1"
    }
}

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "public-rtb"
    }
}

# Associate internet gateway to the public route table
resource "aws_route" "igw_route" {
    destination_cidr_block = "0.0.0/0"
    route_table_id = aws_route_table.public_rtb.id
    gateway_id = aws_internet_gateway.igw-1.id
}

# Associate public subnets to public route table
resource "aws_route_table_association" "public_route" {
    for_each = aws_subnet.public
    subnet_id = each.value.id
    route_table_id = aws_route_table.public_rtb.id
}

# Create private route table
resource "aws_route_table" "private_rtb" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "private-rtb"
    }
}

# Associate private subnets to private route table
resource "aws_route_table_association" "private_route" {
    for_each = aws_subnet.private
    subnet_id = each.value.id
    route_table_id = aws_route_table.private_rtb.id
}