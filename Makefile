WILDCAT_IMAGE  := wildcat
SBT_IMAGE      := sbtscala/scala-sbt:graalvm-community-21.0.2_1.12.9_3.8.3
VOLUME         := buildroot-output
BR2_OPTS       := -C buildroot/ O=output
WILDCAT        := -C wildcat/
OUTPUT_DIR     := ./output
BUILD_OUTPUT   := buildroot/output/images

BINARY         := boot.bin
ELF            := boot.elf
IMAGE          := Image


DOCKER_RUN = docker run -it \
	-v $(CURDIR):/app \
	-v $(VOLUME):/build \
	-w /app \
 $(1)

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
	mkdir -p $(OUTPUT_DIR)
	cp $(BUILD_OUTPUT)/$(BINARY) $(OUTPUT_DIR)
	cp $(BUILD_OUTPUT)/$(ELF) $(OUTPUT_DIR)
	cp $(BUILD_OUTPUT)/$(IMAGE) $(OUTPUT_DIR)

run:
	make $(WILDCAT) run PROGRAM=.$(OUTPUT_DIR)/$(BINARY)

sim:
	qemu-system-riscv32 -M virt -bios none -kernel $(OUTPUT_DIR)/$(IMAGE) -append "rootwait root=/dev/vda ro"  -nographic -cpu rv32,mmu=off

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
