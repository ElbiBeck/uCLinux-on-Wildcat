# uCLinux-on-Wildcat
_Project 5: uCLinux on Wildcat_

Port of NOMMU Linux to the [Wildcat](https://github.com/schoeberl/wildcat) processor.  
Project work for a Bachelor’s degree in Computer Engineering.

---

## Requirements

### Linux / WSL

Install the following tools and packages:

```bash
which
sed
make
binutils
build-essential
diffutils
gcc
g++
bash
patch
gzip
bzip2
perl
tar
cpio
unzip
file
bc
findutils
wget
libncurses-dev
````

### macOS

```bash
Docker
```

---

## Getting Started

### Recommended setup

* **Windows:** Use WSL
* **macOS:** Use Docker

---

## Native Commands

```bash
make edit           # Open Buildroot menuconfig
make edit_linux     # Open Linux kernel menuconfig
make build          # Build the Linux image
make run            # Run image in Wildcat simulator
make sim            # Run image in QEMU
make clean          # Clean Buildroot output
```

---

## Docker Commands (macOS)

```bash
make docker_build      # Build Docker image
make docker_edit       # Open Buildroot menuconfig in Docker
make docker_linux      # Open Linux kernel menuconfig in Docker
make docker_build_fw   # Build firmware in Docker
make docker_run        # Run Wildcat simulator in Docker
make docker_clean      # Clean build output in Docker
make docker_distclean  # Remove Docker build volume
```
