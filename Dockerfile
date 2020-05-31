FROM ubuntu:bionic

LABEL maintainer="Thagoo <lohitgowda56@gmail.com>"

ENV \
    DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    JAVA_OPTS=" -Xmx3840m " \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk-amd64 \
    PATH=~/bin:/usr/local/bin:/home/builder/bin:$PATH \
    USE_CCACHE=1 \
    CCACHE_COMPRESS=1 \
    CCACHE_COMPRESSLEVEL=8 \
    CCACHE_DIR=/srv/ccache
RUN sed 's/main$/main universe/' /etc/apt/sources.list 1>/dev/null

RUN apt-get update               \
 && apt-get -y -q upgrade        \
 && apt-get -y -q install        \
    bc                           \
    binutils-arm-linux-gnueabihf \
    build-essential              \
    ccache                       \
    git                          \
    libncurses-dev               \
    libssl-dev                   \
    u-boot-tools                 \
    wget                         \
    xz-utils                     \
    python \
    python3 \
    curl \
    zip

RUN  apt install -y unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller rename python-setuptools python python3
RUN apt install -y liblzma-dev python-pip brotli python-lz4
RUN pip install backports.lzma protobuf pycrypto pycryptodome docopt

RUN git config --global user.name "Thagoo"
RUN git config --global user.email "lohitgowda56@gmail.com"
RUN git config --global http.sslVerify false
RUN git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 -b lineage-17.1 --depth 1 --single-branch /tmp/gcc
RUN git clone https://github.com/Thagoo/AnyKernel3 --depth 1 /tmp/AnyKernel3
