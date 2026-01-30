#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# socat
cd $WORKSPACE
aa=$(git ls-remote  --refs --tags --sort='v:refname' git://repo.or.cz/socat.git | grep -Po '/tag-\K[0-9.]+' | grep 1.8 | tail -n 1)
curl -sL http://www.dest-unreach.org/socat/download/socat-$aa.tar.bz2 | tar x --bzip2
cd socat-$aa
curl -sL https://git.alpinelinux.org/aports/plain/main/socat/use-linux-headers.patch | patch -p1
CFLAGS="$CFLAGS -static" LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr/local/socatmm
make
make install

cd /usr/local
tar vcJf ./socatmm.tar.xz socatmm

mv ./socatmm.tar.xz /work/artifact/
