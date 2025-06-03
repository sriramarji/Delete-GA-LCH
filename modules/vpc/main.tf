resource "aws_vpc" "myvpc" {  #VPC
    cidr_block = var.vpc_cidr
    tags = {
        Name = "alb-vpc"
  } 
}

resource "aws_internet_gateway" "igw" { #IGW
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "alb-igw"
  }    
}

resource "aws_route_table" "public_rt" { #route table
    vpc_id = aws_vpc.myvpc.id
    tags = {
    Name = "public-route-table"
  }
}

resource "aws_subnet" "mysub" {     #subnet creation
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.sub_cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_route" "public_igw" {     #route table and igw connection
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "pub_sub_asso" {        #route table and subnet association
  subnet_id      = aws_subnet.mysub.id
  route_table_id = aws_route_table.public_rt.id
}






