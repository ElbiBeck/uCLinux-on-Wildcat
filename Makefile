WILDCAT_IMAGE  := wildcat
SBT_IMAGE      := sbtscala/scala-sbt:graalvm-community-21.0.2_1.12.9_3.8.3
VOLUME         := buildroot-output
BR2_OPTS       := -C buildroot/ O=output
WILDCAT        := -C wildcat/
IMAGE_PATH     := ../output/images/boot.bin

DOCKER_RUN = docker run -it \
	-v $(CURDIR):/app \
	-v $(VOLUME):/build \
	-w /app \
 $(1)

all: help

help:
	@echo "Available commands:"
	@echo ""
	@echo "Native commands:"
	@echo "  make edit           - Open Buildroot menuconfig"
	@echo "  make edit_linux     - Open Linux kernel menuconfig"
	@echo "  make build          - Build the Linux image"
	@echo "  make run            - Run image in Wildcat simulator"
	@echo "  make sim            - Run image in QEMU"
	@echo "  make clean          - Clean Buildroot output"
	@echo ""
	@echo "Docker commands:"
	@echo "  make docker_build      - Build Docker image"
	@echo "  make docker_edit       - Run Buildroot menuconfig in Docker"
	@echo "  make docker_linux      - Run Linux menuconfig in Docker"
	@echo "  make docker_build_fw   - Build firmware in Docker"
	@echo "  make docker_run        - Run Wildcat simulator in Docker"
	@echo "  make docker_clean      - Clean build output in Docker"
	@echo "  make docker_distclean  - Remove Docker build volume"
# Native

edit:
	make $(BR2_OPTS) defconfig BR2_DEFCONFIG=../configs/wildcat_defconfig
	make $(BR2_OPTS) menuconfig
	make $(BR2_OPTS) savedefconfig BR2_DEFCONFIG=../configs/wildcat_defconfig

edit_linux:
	make $(BR2_OPTS) defconfig BR2_DEFCONFIG=../configs/wildcat_defconfig
	make $(BR2_OPTS) linux-menuconfig
	make $(BR2_OPTS) linux-update-defconfig

build:
	make $(BR2_OPTS) defconfig BR2_DEFCONFIG=../configs/wildcat_defconfig
	make $(BR2_OPTS)

run:
	make $(WILDCAT) run PROGRAM=$(IMAGE_PATH)

sim:
	qemu-system-riscv32 -M virt -bios none -kernel output/images/Image -append "rootwait root=/dev/vda ro"  -nographic -cpu rv32,mmu=off

clean:
	make $(BR2_OPTS) clean

# Docker wrappers

docker_build:
	docker build -t $(WILDCAT_IMAGE) .

docker_edit: docker_build
	$(call DOCKER_RUN,$(WILDCAT_IMAGE)) edit

docker_linux: docker_build
	$(call DOCKER_RUN,$(WILDCAT_IMAGE)) edit_linux

docker_build_fw: docker_build
	$(call DOCKER_RUN, $(WILDCAT_IMAGE)) build

docker_run:
	$(call DOCKER_RUN,$(SBT_IMAGE)) make run

docker_clean: docker_build
	$(DOCKER_RUN) clean

# Wipe the named volume entirely (full rebuild)
docker_distclean:
	docker volume rm -f $(VOLUME)

.PHONY: edit edit_linux build clean \
        docker_build docker_edit docker_linux docker_build_fw docker_clean docker_distclean
