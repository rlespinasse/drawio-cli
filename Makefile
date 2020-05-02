.PHONY: build

DOCKER_IMAGE?=rlespinasse/drawio-cli:local
build:
	@docker build -t ${DOCKER_IMAGE} .

RUN_ARGS?=
run:
	docker run -it --privileged -v $(PWD):/data rlespinasse/drawio-cli:local ${RUN_ARGS}
