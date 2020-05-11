#!/usr/bin/env bats

@test "Print help" {
  docker_test "--help" "" 0 "help"
}

@test "Execute without any arguments" {
  docker_test "" "" 0 "help"
}

@test "Export a drawio file as pdf" {
  docker_test "-x file1.drawio" "-e DRAWIO_CLI_SUPPRESS_WARNINGS=true" 0 "export"
}

docker_test() {
  run docker run -t $2 -w /data -v $(pwd)/tests/data:/data ${DOCKER_IMAGE} $1

  echo "Status: $status"
  echo "Output:"
  echo "$output"

  [ "$status" -eq $3 ]
  [ "$(diff --strip-trailing-cr <(echo "$output") "tests/expected/$4.log")" = "" ]
}
