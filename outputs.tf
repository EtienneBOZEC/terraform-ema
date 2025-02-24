output "container_names" {
  value = docker_container.my_docker[*].name
}

output "container_ports" {
  value = [for i in range(var.nb_containers) : var.start_port + i]
}