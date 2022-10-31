APP_NAME = boilerplate

APP_VERSION ?= $(shell git describe --tags --always)
COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null)
BRANCH ?= $(shell git symbolic-ref --short HEAD 2>/dev/null)
TAGS = $(shell docker image inspect --format='{{ join .RepoTags " " }}' $(CONTAINER_NAME):$(APP_VERSION))
GCE_PROJECT = gce-hub
CONTAINER_NAME = gcr.io/$(GCE_PROJECT)/$(APP_NAME)
EXTRA_ARGS ?=

default:
	@echo "Build targets"
	@echo "with_commit: add commit hash as docker tag"
	@echo "with_latest: add latest docker tag"
	@echo "clean: clean build and repull all images"
	@echo "debug: enable progress output"
	@echo "version: display the version tag"
	@echo "image: build the image"
	@echo "push: push the image and all the tags"
	@echo "bash: start a bash terminal in container"

with_commit:
ifneq (${COMMIT},)
	@echo -n $(eval EXTRA_ARGS += -t $(CONTAINER_NAME):$(COMMIT))
endif

with_latest:
	@echo -n $(eval EXTRA_ARGS += -t $(CONTAINER_NAME):latest)

clean:
	@echo -n $(eval EXTRA_ARGS += --force-rm --no-cache --pull)

debug:
	@echo -n $(eval EXTRA_ARGS += --progress plain)

version:
	@echo $(APP_VERSION)

image:
	DOCKER_BUILDKIT=1 docker build $(EXTRA_ARGS) -t $(CONTAINER_NAME):$(APP_VERSION) --build-arg APP_VERSION --build-arg BUNDLE_GITHUB__COM -f Dockerfile .

push:
	for tag in $(TAGS) ; do \
	  docker push $$tag ; \
	done

bash:
	docker run -it --entrypoint="" $(CONTAINER_NAME):$(APP_VERSION) bash
