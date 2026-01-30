FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required socat 
RUN apk add --no-cache \
  gcc make linux-headers musl-dev \
  zlib-dev zlib-static python3-dev \
  openssl-dev openssl-libs-static git grep \
  git curl bash xz

  
ENV XZ_OPT=-e9
COPY build-static-socat.sh build-static-socat.sh
RUN chmod +x ./build-static-socat.sh
RUN bash ./build-static-socat.sh
