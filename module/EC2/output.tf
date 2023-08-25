output "MONGOS_1_ID" {
  value = aws_instance.servers["mongos-1"].id
}
output "MONGOS_2_ID" {
  value = aws_instance.servers["mongos-2"].id
}
