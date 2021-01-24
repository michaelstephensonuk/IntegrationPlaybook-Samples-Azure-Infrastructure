#Important Note

#This backend is not used in the local development because we want to keep the state in source control to prevent different solutions accidently 
#overweiting the wrong state file however in the build and release pipelines we will not use local state and we will rename this file from .tftemp to .tf so it will be part of the build
#we will the replace tags in the file to take settings from the pipeline

#Note:
#If you setup your own template you might need to change these values in backend below so 
#that you can use a different storage account

terraform {
  backend "azurerm" {
    resource_group_name  = "DevOps"
    storage_account_name = "ipbterraform"
    container_name       = "terraform-dev"
    key                  = "Infra-Main.tfstate"
  }
}
