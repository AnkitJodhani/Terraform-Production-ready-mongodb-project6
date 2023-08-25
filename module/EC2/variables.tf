
variable "VPC_ID" {}
variable "CPU" {
  default = "t2.micro"
}
variable "AMI" {
    default = "ami-053b0d53c279acc90"
}
variable "ROLE_NAME" {}
variable "KEY_NAME" {}
# variable "PUB_SUB_1_A_ID" {}
# variable "PUB_SUB_2_B_ID" {}
# variable "PUB_SUB_3_C_ID" {}
# variable "PRI_SUB_4_A_ID" {}
# variable "PRI_SUB_5_B_ID" {}
# variable "PRI_SUB_6_C_ID" {}
variable "PRI_SUB_7_A_ID" {}
variable "PRI_SUB_8_B_ID" {}
variable "PRI_SUB_9_C_ID" {}
variable "MONGODB_CLUSTER_SG_ID" {}
variable "CONTROL_MACHINE_SG_ID" {}

locals {
  data = {
    shard-1 = {
      sub_id = var.PRI_SUB_7_A_ID
      name   = "shard-1"
    }
    shard-2 = {
      sub_id = var.PRI_SUB_8_B_ID
      name   = "shard-2"
    }
    shard-3 = {
      sub_id = var.PRI_SUB_9_C_ID
      name   = "shard-3"
    }
    csrs-1 = {
      sub_id = var.PRI_SUB_7_A_ID
      name   = "csrs-1"
    }
    csrs-2 = {
      sub_id = var.PRI_SUB_8_B_ID
      name   = "csrs-2"
    }
    csrs-3 = {
      sub_id = var.PRI_SUB_9_C_ID
      name   = "csrs-3"
    }
    mongos-1 = {
      sub_id = var.PRI_SUB_7_A_ID
      name   = "mongos-1"
    }
    mongos-2 = {
      sub_id = var.PRI_SUB_9_C_ID
      name   = "mongos-2"
    }
  }
}

