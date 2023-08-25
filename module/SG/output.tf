output "ALB_SG_ID" {
    value = aws_security_group.alb_sg.id
}
output "NGINX_SG_ID" {
    value = aws_security_group.nginx_sg.id
}
output "NLB_SG_ID" {
    value = aws_security_group.nlb_sg.id
}
output "MONGODB_CLUSTER_SG_ID" {
    value = aws_security_group.mongodb_cluster_sg.id
}

output "CONTROL_MACHINE_SG_ID" {
    value = aws_security_group.control-machine.id
}