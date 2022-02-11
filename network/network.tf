resource "aws_vpc_endpoint" "ptfe_service" {
  vpc_id             = aws_vpc.primary.id
  service_name       = data.terraform_remote_state.atlaspl.outputs.atlaspl-service
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.primary-az1.id, aws_subnet.primary-az2.id]
  security_group_ids = [aws_security_group.primary_default.id]
}

data "terraform_remote_state" "atlaspl" {
  backend = "local"


  config = {
    path = "../bootstrap/terraform.tfstate"
  }
}
//locals {
// private_link_id = data.terraform_remote_state.atlaspl.outputs.private_link_id
//}

/*resource "mongodbatlas_private_endpoint_interface_link" "atlaseplink" {
  project_id            = mongodbatlas_privatelink_endpoint.atlaspl.project_id
  private_link_id       = mongodbatlas_privatelink_endpoint.atlaspl.private_link_id
  interface_endpoint_id = aws_vpc_endpoint.ptfe_service.id
}*/
resource "mongodbatlas_privatelink_endpoint_service" "atlaseplink" {
  project_id            = var.atlasprojectid
  //private_link_id       = mongodbatlas_privatelink_endpoint.atlaspl.private_link_id
  private_link_id = data.terraform_remote_state.atlaspl.outputs.atlaspl-id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service.id
  provider_name = "AWS"
}
