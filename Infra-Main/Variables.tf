##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "general_prefix_lowercase" {
  description = "The prefix for resources in lower case"
  default     = "ipb"
}

variable "general_prefix_uppercase" {
  description = "The prefix for resources in upper case"
  default     = "IPB"
}


variable "environment_name_lowercase" {
  description = "The name of the environment"
  default     = "__CommonSetting_EnvironmentName_LowerCase__"
}

variable "environment_name_normalcase" {
  description = "The name of the environment"
  default     = "__CommonSetting_EnvironmentName_NormalCase__"
}

variable "environment_name_uppercase" {
  description = "The name of the environment"
  default     = "__CommonSetting_EnvironmentName_UpperCase__"
}

variable "eai_resource_group" {
  description = "The name of the resource group"
  default     = "__CommonSetting_ResourceGroup_Name__"
}


variable "eai_keyvault_resourcegroup_name" {
  description = "The name of the Key Vaults resource group"
  default     = "__CommonSetting_KeyVault_ResourceGroup_Name__"
}

variable "eai_keyvault_name" {
  description = "The name of the Key Vault instance"
  default     = "__CommonSetting_KeyVault_Name__"
}



#Tag Variables
#=============

variable "tags_managed_by" {
  description = "The managed by tag"
  default     = "eai@ipb.com"
}

variable "tags_project_all" {
  description = "The project tag for all projects"
  default     = "all"
}

variable "tags_cost_centre_eai" {
  description = "The tag for eai cost centre"
  default     = "eai"
}

variable "tags_dataprofile_internal" {
  description = "The tag internal data profile"
  default     = "internal"
}

variable "tags_dataprofile_external" {
  description = "The tag external data profile"
  default     = "internal"
}

variable "tags_resourcemap_base_scope" {
  description = "The tag path for the base scope for resource map"
  default     = "IPB\\Integration"
}





#DevOps Pipeline Variables
#==========================

variable "BUILD_DEFINITIONNAME" {
  description = "Injected from the devops build pipeline, tells you the build definition the last modification matches to"
  default     = "__BUILD_DEFINITIONNAME__"
}
variable "BUILD_BUILDNUMBER" {
  description = "Injected from the devops build pipeline, tells you the build pipeline number the resource last modified matches"
  default     = "__BUILD_BUILDNUMBER__"
}
variable "RELEASE_DEFINITIONNAME" {
  description = "Injected from the devops build pipeline, tells you the release definition that last modified the resource"
  default     = "__RELEASE_DEFINITIONNAME__"
}
variable "RELEASE_RELEASENAME" {
  description = "Injected from the devops build pipeline, tells you the name of the release pipeline instance that deployed the resource"
  default     = "__RELEASE_RELEASENAME__"
}
variable "BUILD_REPOSITORY_NAME" {
  description = "Injected from the devops build pipeline, tells you which repo the resource was built from"
  default     = "__BUILD_REPOSITORY_NAME__"
}








