variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0f673487d7e5f89ca"
}

variable "subnet_id" {
  default = "subnet-0e9532e580b5b6ad7"
}

variable "vpc_security_group_ids" {
  default = "sg-04a22354dc127573c"
}

variable "key_name" {
  default = "marichka-account-key"
}

variable "environment" {
  default = "staging"
}

variable "policy_attachments" {
  description = "List of ARNs for policies that should be attached to the instance profile"
  type        = list(string)
  default     = []
}

variable "root_volume_size" {
  default = "9"
}

variable "root_volume_type" {
  default = "gp3"
}

variable "storage_encrypted" {
  default = false
}

variable "iops" {
  default = 3000
}