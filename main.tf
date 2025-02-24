resource "docker_image" "my_docker" {
  name         = "var.image"
  keep_locally = true
}

resource "docker_container" "my_docker" {
  count = var.nb_containers
  image = docker_image.my_docker.image_id
  name = "my_docker_${count.index + 1}"
  memory = var.memory
  privileged = var.privilege

  ports {
    external = var.start_port + count.index
    internal = 80
  }
}