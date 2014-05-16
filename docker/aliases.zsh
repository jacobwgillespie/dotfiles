function drmi() {
  echo "Deleting $1 from the docker index..."
  curl --silent -u "$DOCKER_USERNAME:$DOCKER_PASSWORD" -XDELETE https://index.docker.io/v1/repositories/$1/ > /dev/null
  echo "Deleted!"
}
