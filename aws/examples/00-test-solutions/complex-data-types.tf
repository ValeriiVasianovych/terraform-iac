variable "list_example" {
  type    = list(string)
  default = ["cat", "dog", "bird"]
}

variable "list_example" {
  type    = map(any)
  default = { "year" = 2010, "model" = "Ford" }
}

variable "list_example" {
  type    = set(string)
  default = ["cat", "dog", "bird", "cat"]
}

variable "object_example" {
  type = object({
    name = string
    age  = number
  })
  default = {
    name = "John"
    age  = 30
  }
}

variable "tuple_example" {
  type = tuple([string, number, string])
  default = ["John", 30, "New York"]
}

