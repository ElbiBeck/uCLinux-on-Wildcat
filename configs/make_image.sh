#!/bin/bash
set -e

CROSS=riscv32-buildroot-linux-uclibc-
BOARD_DIR="$(dirname "$(realpath "$0")")"
BINARIES_DIR="$1"

# Compile DTB
dtc -I dts -O dtb -o "$BINARIES_DIR/wildcat.dtb" "$BOARD_DIR/wildcat.dts"

# Assemble and link - run from BINARIES_DIR
cd "$BINARIES_DIR"

${CROSS}as -march=rv32i -mabi=ilp32 \
    -I "$BINARIES_DIR" \
    -o "$BINARIES_DIR/start.o" \
    "$BOARD_DIR/start.S"

${CROSS}ld -T "$BOARD_DIR/boot.ld" \
    -o "$BINARIES_DIR/boot.elf" \
    "$BINARIES_DIR/start.o"

${CROSS}objcopy -O binary \
    "$BINARIES_DIR/boot.elf" \
    "$BINARIES_DIR/boot.bin"

echo "Done: $BINARIES_DIR/boot.bin"