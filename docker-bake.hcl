variable "image_name_prefix" {
  type = string
  default = "Prefix to prepend to each image name"
}

variable "git_sha" {
  type = string
  default = "Git SHA that will be used as a tag"
}

function "image_tags" {
  params = [image_name]
  result = ["${image_name}:latest", "${image_name}:${formattimestamp("YYYY-MM-DD", timestamp())}",  "${image_name}:${git_sha}"]
}

group "default" {
  targets = ["base", "patches"]
}

target "base" {
  context = "base/"
  tags = image_tags(image_name_prefix)
  args = {
    BASE_IMAGE_TAG = "2026-10-26"
  }
}

target "patches" {
  name = "project-${dir}"
  matrix = {
    dir = ["security-patch-2025-07-28"]
  }
  context = "${dir}"  
  tags = ["${image_name_prefix}:${git_sha}-${dir}"]
}
