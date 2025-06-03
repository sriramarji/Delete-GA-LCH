module "vpc" {
  source = "./modules/vpc" #how to know which values we need to give
}


module "ec2" {
  source = "./modules/ec2"

  ami_id    = "ami-084568db4383264d4"
  inst_type = "t2.medium"
  subnet_id = module.vpc.subnet_id
  vpc_id    = module.vpc.vpc_id
  key_name  = "Hcl-prac-training"
}

