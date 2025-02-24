variable image {
    description = "Image docker utilisée"
    type = string
    default = "nginx:latest"

    validation {
        condition = length(var.image) > 0
        error_message = "Le nom d'image ne peut pas etre vide"
    }
}

variable memory {
    description = "Quantité de RAM allouée (MB)"
    type = number
    default = 512

    validation {
        condition = var.memory > 0
        error_message = "The memory variable must be a positive number."
  }
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

    validation {
        condition = var.nb_containers > 0
        error_message = "The nb_containers variable must be a positive number."
  }
}

variable start_port {
    description = "Port utilisé par le premier container"
    type = number
    default = 3000
    
    validation {
        condition = var.start_port > 0 && var.start_port <= 65535
        error_message = "The start_port variable must be between 1 and 65535."
  }
}