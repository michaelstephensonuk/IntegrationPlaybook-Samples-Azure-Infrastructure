locals {
  apim_host = replace(azurerm_api_management.platform_apim.gateway_url, "https://", "")  
}

resource "azurerm_frontdoor" "platform_frontdoor" {
  name                                         = "${var.general_prefix_lowercase}-api-fd-${var.environment_name_lowercase}"  
  resource_group_name                          = data.azurerm_resource_group.eai_resource_group.name
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "APIM-RoutingRule"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/api/*"]
    frontend_endpoints = ["MainFrontEndEndpoint"]
    forwarding_configuration {
      forwarding_protocol = "HttpsOnly"
      backend_pool_name   = "APIManagement"
	  custom_forwarding_path = "/external"
    }
  }  

  backend_pool_load_balancing {
    name = "defaultLoadBalancingSettings"
  }

  backend_pool_health_probe {
    name = "defaultHealthProbeSettings"
  }

  backend_pool {
    name = "APIManagement"
    backend {
      host_header = local.apim_host 
      address     = local.apim_host
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "defaultLoadBalancingSettings"
    health_probe_name   = "defaultHealthProbeSettings"
  }  

  frontend_endpoint {
    name                              = "MainFrontEndEndpoint"
    host_name                         = "${var.general_prefix_lowercase}-api-fd-${var.environment_name_lowercase}.azurefd.net"
    custom_https_provisioning_enabled = false
	session_affinity_enabled		  = true
	session_affinity_ttl_seconds      = 120
  }
}