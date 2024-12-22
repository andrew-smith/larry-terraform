
# Read user, tenancy from configuration file.
# There's probably a better way to do this that I haven't figured out

data "local_file" "oci_config" {
  filename = pathexpand("~/.oci/config")
}
locals {
  oci_user_id    = regex("user\\s*=\\s*(.+)", data.local_file.oci_config.content)[0]
  oci_tenancy_id = regex("tenancy\\s*=\\s*(.+)", data.local_file.oci_config.content)[0]
}

module "network" {
  source = "./network"

  name           = "free"
  compartment_id = local.oci_tenancy_id

  udp_ports = [
    "41641" # tailscale
  ]
}

module "box" {
  
  source = "./box-basic"


  compartment_id = local.oci_tenancy_id
  ad_name        = module.network.ad_name
  subnet_id      = module.network.subnet_id

  shape = "VM.Standard.A1.Flex"

  ssh_keys = data.http.andrews_keys.response_body
}



data "http" "andrews_keys" {
    url = "https://github.com/andrew-smith.keys"
}
