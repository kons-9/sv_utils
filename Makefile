.PHONY: top clean docker-build
top: verible.filelist docker-build
	@echo "Done."
include Makefile.inc

DOCKER:=$(shell which docker)
USER_ID:=$(shell id -u)
GROUP_ID:=$(shell id -g)
VERILATOR_VERSION:=5.032
PROJECT_ROOT:=$(shell git rev-parse --show-toplevel)

docker-build:
	@echo "Building docker image..."
	$(DOCKER) build -t unprivileged_verilator \
		--progress=plain \
		--build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg VERILATOR_VERSION=$(VERILATOR_VERSION) \
		--build-arg PROJECT_ROOT=$(PROJECT_ROOT) \
		.

verible.filelist: $(SV_UTILS_FILES) Makefile
	@echo "Generating filelist..."
	@find $(SV_UTILS_PROJECT_ROOT) -name "*.sv" -o -name "*.svh" -o -name "*.v" | grep -v "dummy/" | sort > verible.filelist

clean:
	@rm -f verible.filelist
	@echo "Cleaned up."

