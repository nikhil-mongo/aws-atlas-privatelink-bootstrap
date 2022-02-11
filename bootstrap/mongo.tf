resource "mongodbatlas_privatelink_endpoint" "atlaspl" {
  project_id    = var.atlasprojectid
  provider_name = "AWS"
  region        = var.aws_region
}
output "atlaspl-service" {
  value=mongodbatlas_privatelink_endpoint.atlaspl.endpoint_service_name
}
output "atlaspl-id" {
    value=mongodbatlas_privatelink_endpoint.atlaspl.private_link_id

}