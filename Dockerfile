FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      which sed make binutils build-essential diffutils gcc g++ \
      bash patch gzip bzip2 perl tar cpio unzip rsync file bc \
      findutils wget libncurses-dev

RUN mkdir -p /build

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
