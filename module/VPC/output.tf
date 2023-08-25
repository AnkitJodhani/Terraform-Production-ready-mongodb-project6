

output "REGION" {
  value = var.REGION
}

output "PROJECT_NAME" {
  value = var.PROJECT_NAME
}
output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUB_1_A_ID" {
    value = aws_subnet.pub-sub-1-a.id
}
output "PUB_SUB_2_B_ID" {
    value = aws_subnet.pub-sub-2-b.id

}
output "PUB_SUB_3_C_ID" {
    value = aws_subnet.pub-sub-3-c.id

}

output "PRI_SUB_4_A_ID" {
    value = aws_subnet.pri-sub-4-a.id

}
output "PRI_SUB_5_B_ID" {
    value = aws_subnet.pri-sub-5-b.id

}
output "PRI_SUB_6_C_ID" {
    value = aws_subnet.pri-sub-6-c.id

}
output "PRI_SUB_7_A_ID" {
    value = aws_subnet.pri-sub-7-a.id

}
output "PRI_SUB_8_B_ID" {
    value = aws_subnet.pri-sub-8-b.id

}
output "PRI_SUB_9_C_ID" {
    value = aws_subnet.pri-sub-9-c.id

}



