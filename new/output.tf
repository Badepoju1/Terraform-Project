# Output Declarat

output "vpc-id" {
    value = module.main-config.vpc-id   
}

output "public_subnets" {
    value = module.main-config.public_subnets
  
}

output "privateapp_subnets" {
    value = module.main-config.privateapp_subnets
  
}

output "privatedata_subnets" {
    value = module.main-config.privatedata_subnets
  
}

output "nat-gw" {
    value = module.main-config.nat-gw
  
}

output "s3_bucket" {
  value = module.main-config.s3_bucket
}

output "alb-ip" {
    value = module.main-config.alb-ip
}