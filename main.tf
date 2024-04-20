# Configure VPC and Subnets
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block         = "10.0.1.0/24"
  availability_zone = "us-east-2"
}

# Create an EKS Cluster
resource "aws_eks_cluster" "cluster" {
  name          = var.cluster_name
  role_arn       = aws_iam_role.eks_role.arn
  vpc_config {
    security_group_ids = [aws_security_group.eks_sg.id]
    subnet_ids        = [aws_subnet.public_subnet.id]
  }
  # ... other cluster configurations
}

# Create RDS Database Instance
resource "aws_rds_cluster" "database" {
  engine         = var.rds_engine
  allocated_storage = 20
  master_username = var.db_username
  master_password = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  # ... other database configurations
}

# IAM Roles and Policies
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
  # ... other configurations

  assume_role_policy = jsonencode({
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = ["eks.amazonaws.com"]
      }
      Action = "sts:AssumeRole"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_security_group" "rds_sg" {
  name = "rds-security-group"
  description = "Security group for RDS database access"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 3306  # Allow inbound traffic on port 3306 (default for RDS)
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict access for now (modify later)
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }

  # You can add additional ingress rules to allow specific sources to access the database
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role       = aws_iam_role.eks_role.arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_security_group" "eks_sg" {
  name = "eks-cluster-sg"
  description = "Security group for EKS cluster communication"
  vpc_id = aws_vpc.vpc.id

  # Define ingress rules to allow communication between cluster components and other resources
  ingress {
    from_port = 0  # Allow all inbound traffic for now (modify later)
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict access later
  }

  # Define egress rules to allow outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }

  # You can add specific ingress rules for SSH access, API server access, etc.
}