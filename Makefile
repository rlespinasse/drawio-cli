.PHONY: build run setup-test test

DOCKER_IMAGE?=rlespinasse/drawio-cli:local
build:
	@docker build -t ${DOCKER_IMAGE} .

RUN_ARGS?=
DOCKER_OPTIONS?=-e DRAWIO_CLI_SUPPRESS_WARNINGS=true
run:
	@docker run -t $(DOCKER_OPTIONS) -w /data -v $(PWD):/data ${DOCKER_IMAGE} ${RUN_ARGS}

setup-test:
	@npm install -g bats

test:
	@DOCKER_IMAGE=$(DOCKER_IMAGE) bats -r .
