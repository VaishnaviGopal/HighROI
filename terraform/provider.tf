provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "kubernetes" {
  config_path = data.ibm_container_cluster_config.config_ds.config_file_path
}