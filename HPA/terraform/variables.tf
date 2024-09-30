variable "cluster_name" {
  type    = string
  default = "group3-prod"
}

variable "host" {
  type = string
  default = "https://C6FF797D3B1924E3AD11F99A8ABD8DF4.gr7.ap-northeast-2.eks.amazonaws.com"
}

variable "cluster_ca_certificate" {
  type = string
  default = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJWlorNnA1bjVHeTB3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBeU1UWXdOalV5TlRaYUZ3MHpOREF5TVRNd05qVTNOVFphTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUM5aTdCNk5yT3I2RXVER1BLLy85N0dmZmR5b1Mva3JKU0Y4dldyQm9Cd0FtQlRlMkRuUUhQTFoyd0gKb1dGU09tRkNkaG1ubGhBd3JOWENNTlVYdGx0Z0dFaHRCZEszWk95OEYyM3JYSUxEMm02R3p4OE5OR3pHRHE5UAp0VFA0Uk05NC8yam5xdEQxMzBoVkJWODBhQ3E3RWVnZWRmdFFoK0xscnRjRkNUSUtndlEyeGVMNTdXUW03V0x3CnhpTWlyeWQvSzVGSnNXQ1Nzb3N3Uk4xTytBakc5MkhaUWpRTlB2eEZvVGNzVnptNkxFVFZJYWoxM2d3SHFFUkcKeWRTd095aGdYckYxQW5iZTV4UWdTVU5sNE5NR0JtQlhEWENVN1pSalVPOUVaL3RUbnZoZnY4YURneDRGNHpRbgp5ZGYwWmhKSDVXUVRXK3VXRHN4Zkk2RFJCV2JsQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTZDc1dGVrK0d6SjQ3WXlJNlkwZzdpWFNEanp6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQlN5ZWVPRmY0OAplallHcEtUWHNsaHk4Vm1MZS95RXQ2eEZZWnB5aFpMRFRPOEZaRGg2MXFZTkxIM1l5K2dwVERkSGpxQlRvZHE1CndRRFY5N3FteFZULzI2a3lna1I1NkhiV2I4RWN1bjlnbHlVYzdma3JWQ2xPMzdLMjlXdUk0VDZvTUNySDhWUFgKSDFxcWgyRjQxU3Z3ODJobXNmMUN2elJsamNsL3VzNmFUQVBsSHVycXBZV1hOakNTTHN3NlpVSTZsMjhOc1RxTAprbzk5dlRrV09ieGpXQ3FJeXpGLzNHeU0zYm5ZWWljdjZrOGVxL0RpTTRQOGRPWVJjMWh4RVZaZllGZWY2c2g2Cm5oSXpCZVZZUFMxaXkvQlYrUUxDQnJPa1NaZnlxS0xaRXY0bUwvNS9lTDBYdkFOV05qOVQ5YlFPZkVrdGluangKUVdQRFNPUWdKcWlTCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
}

