
data "oci_core_images" "list" {
  compartment_id   = var.compartment_id
  operating_system = "Canonical Ubuntu"
  shape            = var.shape
  state            = "AVAILABLE"
  sort_by          = "TIMECREATED"
  sort_order       = "DESC"
}



resource "oci_core_instance" "instance" {
  availability_domain = var.ad_name
  compartment_id      = var.compartment_id

  display_name = var.instance_name

  shape = var.shape
  shape_config {
    ocpus         = var.cpus
    memory_in_gbs = var.ram
  }

  source_details {
    boot_volume_size_in_gbs = var.hdd
    source_type             = "image"
    source_id               = data.oci_core_images.list.images[0].id
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_keys
  }

}
