#!/usr/bin/env bats

@test "Print help" {
  docker_test "" 0 "help" --help
}

@test "Execute without any arguments" {
  docker_test "" 0 "help"
}

@test "Export a drawio file as pdf" {
  docker_test "-e DRAWIO_CLI_SUPPRESS_WARNINGS=true" 0 "export-file1" -x file1.drawio
}

@test "Export a drawio file with space in its name" {
  docker_test "-e DRAWIO_CLI_SUPPRESS_WARNINGS=true" 0 "export-file2" -x "file 2.drawio"
}

docker_test() {
  local docker_opts="$1"
  local status=$2
  local output_file=$3
  shift
  shift
  shift
  run docker run -t $docker_opts -w /data -v $(pwd)/tests/data:/data ${DOCKER_IMAGE} "$@"

  echo "Status: $status"
  echo "Output:"
  echo "$output"

  [ "$status" -eq $status ]
  [ "$(diff --strip-trailing-cr <(echo "$output") "tests/expected/$output_file.log")" = "" ]
}
