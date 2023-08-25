
# creating VPC

module "VPC" {
  source           = "../module/VPC"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUB_SUB_1_A_CIDR = var.PUB_SUB_1_A_CIDR
  PUB_SUB_2_B_CIDR = var.PUB_SUB_2_B_CIDR
  PUB_SUB_3_C_CIDR = var.PUB_SUB_3_C_CIDR
  PRI_SUB_4_A_CIDR = var.PRI_SUB_4_A_CIDR
  PRI_SUB_5_B_CIDR = var.PRI_SUB_5_B_CIDR
  PRI_SUB_6_C_CIDR = var.PRI_SUB_6_C_CIDR
  PRI_SUB_7_A_CIDR = var.PRI_SUB_7_A_CIDR
  PRI_SUB_8_B_CIDR = var.PRI_SUB_8_B_CIDR
  PRI_SUB_9_C_CIDR = var.PRI_SUB_9_C_CIDR
}


module "SG" {
  source = "../module/SG"
  VPC_ID = module.VPC.VPC_ID
}


# createing Key for instaces
module "KEY" {
  source = "../module/KEY"
}

# create IAM role and that will be attach to the control machine
module "IAM" {
  source = "../module/IAM"
}

module "EC2" {
  source                = "../module/EC2"
  VPC_ID                = module.VPC.VPC_ID
  CPU                   = var.CPU
  AMI                   = var.AMI
  KEY_NAME              = module.KEY.KEY_NAME
  PRI_SUB_7_A_ID        = module.VPC.PRI_SUB_7_A_ID
  PRI_SUB_8_B_ID        = module.VPC.PRI_SUB_8_B_ID
  PRI_SUB_9_C_ID        = module.VPC.PRI_SUB_9_C_ID
  MONGODB_CLUSTER_SG_ID = module.SG.MONGODB_CLUSTER_SG_ID
  CONTROL_MACHINE_SG_ID = module.SG.CONTROL_MACHINE_SG_ID
  ROLE_NAME             = module.IAM.ROLE_NAME
}


module "LB" {
  source = "../module/LB"

  VPC_ID         = module.VPC.VPC_ID
  PROJECT_NAME   = module.VPC.PROJECT_NAME
  PUB_SUB_1_A_ID = module.VPC.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID = module.VPC.PUB_SUB_2_B_ID
  PUB_SUB_3_C_ID = module.VPC.PUB_SUB_3_C_ID
  ALB_SG_ID      = module.SG.ALB_SG_ID
  NLB_SG_ID      = module.SG.NLB_SG_ID
  MONGOS_1_ID    = module.EC2.MONGOS_1_ID
  MONGOS_2_ID    = module.EC2.MONGOS_2_ID
}


module "ASG" {
  source         = "../module/ASG"
  CPU            = var.CPU
  AMI            = var.AMI
  PROJECT_NAME   = module.VPC.PROJECT_NAME
  KEY_NAME       = module.KEY.KEY_NAME
  NGINX_SG_ID    = module.SG.NGINX_SG_ID
  MAX_SIZE       = var.MAX_SIZE
  MIN_SIZE       = var.MIN_SIZE
  DESIRED_CAP    = var.DESIRED_CAP
  PRI_SUB_4_A_ID = module.VPC.PRI_SUB_4_A_ID
  PRI_SUB_5_B_ID = module.VPC.PRI_SUB_5_B_ID
  PRI_SUB_6_C_ID = module.VPC.PRI_SUB_6_C_ID
  NGINX_TG_ARN   = module.LB.NGINX_TG_ARN


}
