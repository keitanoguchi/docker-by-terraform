# Pulls the image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create a container
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "nginx"

  ports {
    # container's port
    internal = 80
    # host's port
    external = 8080
  }

  depends_on = [
    docker_image.nginx
  ]
}
