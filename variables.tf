variable image {
    description = "Image docker utilisée"
    type = string
    default = "nginx:latest"
}

variable memory {
    description = "Quantité de RAM allouée (MB)"
    type = number
    default = 512
}

variable privilege {
    description = "Root ou pas la team ?"
    type = bool
    default = false
}

variable nb_containers {
    description = "Nombre de containers à spawn"
    type = number
    default = 2
}

variable start_port {
    description = "Port utilisé par le premier container"
    type = number
    default = 3000
}