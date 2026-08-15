output "object_storage_namespace" {
  value = data.oci_objectstorage_namespace.ns.namespace
}

output "bucket_name" {
  value = oci_objectstorage_bucket.tfstate.name
}
