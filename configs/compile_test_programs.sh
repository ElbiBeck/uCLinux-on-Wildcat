#!/bin/sh
set -e

TARGET_DIR="$1"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

PRG_COMPILER="${HOST_DIR}/bin/riscv32-buildroot-linux-uclibc-gcc"
PRG_COMP_FLAGS="-fPIC -Wl,-elf2flt=-r"
PRG_SRC_DIR="${PROJECT_ROOT}/programs"
PRG_OUT_DIR="${TARGET_DIR}/programs"

mkdir -p "$PRG_OUT_DIR"
for src in "$PRG_SRC_DIR"/*.c ; do
	[ -e "$src" ] || continue
	"$PRG_COMPILER" $PRG_COMP_FLAGS "$src" -o "$PRG_OUT_DIR/$(basename "$src" .c)"
done
rm -f "$PRG_OUT_DIR"/*.gdb
