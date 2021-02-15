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

variable "eai_resource_group_location" {
  description = "The location of the resource group"
  default     = "__CommonSetting_ResourceGroup_Location__"
}








