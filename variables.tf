variable "cluster_name" {
  type = string
  description = "Name for the EKS cluster"
  default = "my-eks-cluster"
}

variable "node_instance_type" {
  type = string
  description = "Instance type for EKS worker nodes"
  default = "t2.medium"
}

variable "rds_engine" {
  type = string
  description = "Database engine for RDS instance (e.g., postgresql, mysql)"
  default = "mysql"
}

variable "db_name" {
  type = string
  description = "Name of the database to be created"
  default = "kredi-db"
}

variable "db_username" {
  type = string
  description = "Username for the RDS database"
  default = "admin"
}

variable "db_password" {
  type = string
  description = "Password for the RDS database"
  # Consider using a secure method for storing passwords (e.g., AWS Secrets Manager)
  default = "db_password"
}

# Additional variables for VPC, subnets, security groups, etc. can be defined here

