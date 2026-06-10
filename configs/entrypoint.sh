#!/bin/bash
set -e

# /app  = macOS bind mount (fakeowner — chmod breaks here)
# /build = native container filesystem (or named volume)

export FORCE_UNSAFE_CONFIGURE=1
export BR2_JLEVEL=4

rsync -a --exclude=buildroot/output --exclude=output /app/ /build/

# configs is authoritative from the host: mirror deletions too, otherwise a
# file removed in /app/configs lingers in the persistent /build volume and the
# sync-back below resurrects it into the host directory.
rsync -a --delete /app/configs/ /build/configs/

make -C /build "$@"

# Sync back configs that may have changed
rsync -a --delete /build/configs/ /app/configs/
if [ -d /build/output ]; then
  mkdir -p /app/output
  rsync -a --delete /build/output/ /app/output/
fi
