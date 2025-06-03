output "vpc_id" {
  value       = aws_vpc.myvpc.id
  description = "displaying id of vpc"
}

output "subnet_id" {
  value       = aws_subnet.mysub.id
  description = "output of subnet id"
}