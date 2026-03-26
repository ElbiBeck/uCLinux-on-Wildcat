IMAGE     := wildcat
VOLUME    := buildroot-output
BR2_OPTS  := -C buildroot/ O=output

DOCKER_RUN = docker run -it \
	-v $(CURDIR):/app \
	-v $(VOLUME):/build \
	$(IMAGE)

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

clean:
	make $(BR2_OPTS) clean

# Docker wrappers

docker_build:
	docker build -t $(IMAGE) .

docker_edit: docker_build
	$(DOCKER_RUN) edit

docker_linux: docker_build
	$(DOCKER_RUN) edit_linux

docker_build_fw: docker_build
	$(DOCKER_RUN) build

docker_clean: docker_build
	$(DOCKER_RUN) clean

# Wipe the named volume entirely (full rebuild)
docker_distclean:
	docker volume rm -f $(VOLUME)

.PHONY: edit edit_linux build clean \
        docker_build docker_edit docker_linux docker_build_fw docker_clean docker_distclean
