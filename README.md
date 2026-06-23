# uCLinux on Wildcat

_Project 5: uCLinux on Wildcat_

> A port of μClinux (NOMMU Linux) to the [Wildcat](https://github.com/schoeberl/wildcat) RISC-V processor.

μClinux is a variant of Linux for processors that have no memory management unit (MMU). This repository brings it up on Wildcat, a Chisel-based RISC-V core, and is for the course Project work for a bachelor in Computer Engineering at DTU.

## Demo

<p align="center">
  <img src="terminal.gif" alt="μClinux booting on the Wildcat simulator" width="720">
</p>

## Getting Started

Pick the workflow that matches your platform:

| Platform | Recommended workflow |
| --- | --- |
| Linux | Native (`make`) |
| Windows | WSL, then the native (`make`) workflow |
| macOS | Docker |

### 1. Clone

```bash
git clone https://github.com/ElbiBeck/uCLinux-on-Wildcat.git
cd uCLinux-on-Wildcat
git submodule update --init --recursive
```

### 2. Install prerequisites

**Linux / WSL** — install the build dependencies:

```bash
sudo apt update
sudo apt install which sed make binutils build-essential diffutils gcc g++ \
  bash patch gzip bzip2 perl tar cpio unzip file bc findutils wget libncurses-dev
```

**macOS** — only Docker is required (e.g. Docker Desktop):

```bash
brew install --cask docker
```

### 3. Build and run

**Linux / WSL (native):**

```bash
make build && make run
```

**macOS (Docker):**

```bash
make docker_build_fw && make docker_run
```
Once the image is built it can be run natively on macOS using `make run`

#### 3.1 Login

Login to the default user using root
```bash
wildcat login: root
```

## Command Reference

### Native (Linux / WSL)

| Command | Description |
| --- | --- |
| `make run` | Run the image in the Wildcat simulator |
| `make edit` | Open Buildroot menuconfig |
| `make edit_linux` | Open Linux kernel menuconfig |
| `make build` | Build the Linux image |
| `make sim` | Run the image in QEMU |
| `make clean` | Clean the Buildroot output |

### Docker (macOS)

| Command | Description |
| --- | --- |
| `make docker_run` | Run the Wildcat simulator in Docker |
| `make docker_build` | Build the Docker image |
| `make docker_edit` | Open Buildroot menuconfig in Docker |
| `make docker_linux` | Open Linux kernel menuconfig in Docker |
| `make docker_build_fw` | Build the firmware in Docker |
| `make docker_clean` | Clean build output in Docker |
| `make docker_distclean` | Remove the Docker build volume |

## Compilation Time Examples

> For a clean measurement, run a full build once, then `make clean` and rebuild so that package downloads aren't counted in the timing.

| Machine | Operating System | Date | Command | Time |
| --- | --- | --- | --- | --- |
| Apple M4 | MacOS | 2026-06-23 | `make docker_build_fw` | 13:01.53 |
| AMD Ryzen 5 7640U | Ubuntu 24.04 | 2026-06-23 | `make build` | 19:02.03 |
| Intel i5-1135G7 @ 2.40GHz | Windows (WSL-Ubuntu) | 2026-06-23 | `make build` | 43:42.86 |
| GitHub Actions Pipeline (With downloads) | Ubuntu | 2026-06-15 | `make build` | 34:50 |

## Project Status

**Complete.** This project met its objective and is no longer in active development.
