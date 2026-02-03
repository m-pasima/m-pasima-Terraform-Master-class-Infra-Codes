
output "nat_gateway_az1_id" {
  description = "Id of nat-gateway in az1"
  value = aws_nat_gateway.nat_gateway_az1.id
}


output "nat_gateway_az2_id" {
  description = "Id of nat-gateway in az2"
  value = aws_nat_gateway.nat_gateway_az2.id
}
