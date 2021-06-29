data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

// data "ibm_resource_instance" "cos_instance" {
//   name              = var.cos_instance_name
//   location          = "global"
//   resource_group_id = data.ibm_resource_group.resource_group.id
//   service           = "cloud-object-storage"
// }

// resource "ibm_is_vpc" "vpc1" {
//   name = "roi-vpc"
// }

// resource "ibm_is_public_gateway" "gateway1" {
//   count = 3
//   name  = "public-gateway-${count.index + 1}"
//   vpc   = ibm_is_vpc.vpc1.id
//   zone  = "us-south-${count.index + 1}"
// }

// resource "ibm_is_security_group_rule" "security_group_rule_tcp" {
//   group     = ibm_is_vpc.vpc1.default_security_group
//   direction = "inbound"
//   tcp {
//     port_min = 30000
//     port_max = 32767
//   }
// }

// resource "ibm_is_subnet" "subnet1" {
//   name                     = "roi-subnet1"
//   vpc                      = ibm_is_vpc.vpc1.id
//   zone                     = "us_south-1"
//   total_ipv4_address_count = 256
// }

// resource "ibm_is_subnet" "subnet2" {
//   name                     = "roi-subnet2"
//   vpc                      = ibm_is_vpc.vpc1.id
//   zone                     = "us-south-2"
//   total_ipv4_address_count = 256
// }

// resource "ibm_is_subnet" "subnet3" {
//   name                     = "roi-subnet3"
//   vpc                      = ibm_is_vpc.vpc1.id
//   zone                     = "us-south-3"
//   total_ipv4_address_count = 256
// }

// resource "ibm_container_vpc_cluster" "cluster1" {
//   name         = "roi-cluster"
//   vpc_id       = ibm_is_vpc.vpc1.id
//   flavor       = "bx2.4x16"
//   kube_version = "4.3_openshift"
//   entitlement  = "cloud_pak"
//   //   pod_subnet        = "172.17.64.0/18"
//   //   service_subnet    = "172.21.0.0/16"
//   worker_count      = 3
//   resource_group_id = data.ibm_resource_group.resource_group.id
//   zones {
//     subnet_id = ibm_is_subnet.subnet1.id
//     name      = "us-south-1"
//   }
//   zones {
//     subnet_id = ibm_is_subnet.subnet2.id
//     name      = "us-south-2"
//   }
//   zones {
//     subnet_id = ibm_is_subnet.subnet3.id
//     name      = "us-south-3"
//   }
// }

data "ibm_container_vpc_cluster" "cluster1" {
  name              = "c3bff0kd05iei7pir4eg"
  resource_group_id = data.ibm_resource_group.resource_group.id
}

data "ibm_container_cluster_config" "config_ds" {
  cluster_name_id = data.ibm_container_vpc_cluster.cluster1.id
  config_dir      = "./"
}

// resource "kubernetes_pod" "hello_world1" {
//   metadata {
//     name = "pod1"
//   }
//   spec {
//     // hostname = "demohost.ibm.com"
//     container {
//       name    = "container1"
//       image   = "ubuntu:14.04"
//       command = ["/bin/sh", "-c"]
//       args    = ["echo new hello"]
//       port {
//         container_port = 8080
//       }
//     }
//     restart_policy = "Never"
//   }
// }

// resource "kubernetes_pod" "hello_world2" {
//   metadata {
//     name = "pod2"
//   }
//   spec {
//     // hostname = "demohost.ibm.com"
//     container {
//       name    = "container2"
//       image   = "ubuntu:14.04"
//       command = ["/bin/sh", "-c"]
//       args    = ["echo new hello"]
//       port {
//         container_port = 8080
//       }
//     }
//     restart_policy = "Never"
//   }
// }

// resource "kubernetes_pod" "hello_world3" {
//   metadata {
//     name = "pod3"
//   }
//   spec {
//     // hostname = "demohost.ibm.com"
// image_pull_secrets {
//   name = "terraformsecret2"
// }
// container {
//   name    = "container3"
//   image   = "us.icr.io/smjtnamespace/ubuntu:latest"
//   command = ["/bin/sh", "-c"]
//   args    = ["echo new hello"]
//   port {
//     container_port = 8080
//   }
//   volume_mount {
//     name       = "vol3"
//     mount_path = "/data/roi/"
//   }
// }
// volume {
//   name     = "vol3"
//   empty_dir  {
//   }
// }
//     restart_policy = "Always"
//   }
// }

resource "kubernetes_deployment" "example1" {
  metadata {
    name = "roideployment"
    labels = {
      test = "roi"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        test = "roi"
      }
    }

    template {
      metadata {
        labels = {
          test = "roi"
        }
      }

      spec {
        image_pull_secrets {
          name = "terraformsecret2"
        }

        container {
          name    = "roicontainer"
          image   = "us.icr.io/smjtnamespace/highroi:1"
          port {
            container_port = 5001
          }
          volume_mount {
            name       = "vol3"
            mount_path = "/data/roi/"
          }
        }
        volume {
          name = "vol3"
          empty_dir {
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "example2" {
  metadata {
    name = "roideployment2"
    labels = {
      test = "roi"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        test = "roi"
      }
    }

    template {
      metadata {
        labels = {
          test = "roi"
        }
      }

      spec {
        image_pull_secrets {
          name = "terraformsecret2"
        }

        container {
          name    = "roicontainer2"
          image   = "us.icr.io/smjtnamespace/highroi:1"
          port {
            container_port = 5002
          }
          volume_mount {
            name       = "vol3"
            mount_path = "/data/roi/"
          }
        }
        volume {
          name = "vol3"
          empty_dir {
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "watchdog" {
  metadata {
    name = "watchdogdeployment"
    labels = {
      test = "watchdog"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        test = "watchdog"
      }
    }

    template {
      metadata {
        labels = {
          test = "watchdog"
        }
      }

      spec {
        image_pull_secrets {
          name = "terraformsecret2"
        }

        container {
          name    = "roicontainer2"
          image   = "us.icr.io/smjtnamespace/watchdog:latest"
          port {
            container_port = 5003
          }
          volume_mount {
            name       = "vol3"
            mount_path = "/data/roi/"
          }
        }
        volume {
          name = "vol3"
          empty_dir {
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "example" {
  metadata {
    name = "roiservice"
  }
  spec {
    selector = {
      app = kubernetes_deployment.example1.metadata.0.labels.test
    }
    port {
      port        = 80
      target_port = 5001
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "example2" {
  metadata {
    name = "roiservice2"
  }
  spec {
    selector = {
      app = kubernetes_deployment.example2.metadata.0.labels.test
    }
    port {
      port        = 80
      target_port = 5001
    }

    type = "LoadBalancer"
  }
}