# Pulls the image
resource "docker_image" "mysql" {
  name = "mysql:5.7"
}

# Create a container
resource "docker_container" "mysql" {
  image = docker_image.mysql.latest
  name  = "mysql"
  env = [
    "MYSQL_ROOT_PASSWORD=root",
    "MYSQL_DATABASE=my_db",
    "MYSQL_USER=docker",
    "MYSQL_PASSWORD=password",
    "TZ:=Asia/Tokyo"
  ]
  command = ["mysqld"]
  ports {
    # container's port
    internal = 3306
    # host's port
    external = 3308
  }

  depends_on = [
    docker_image.mysql
  ]
}
