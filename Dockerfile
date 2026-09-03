# Use an older Ubuntu release compatible with LEDE 17.01 toolchain dependencies
FROM ubuntu:16.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required build dependencies for LEDE Image Builder
RUN apt-get update && apt-get install -y \
    build-essential \
    libncurses5-dev \
    gawk \
    gettext \
    git \
    file \
    wget \
    unzip \
    python \
    bzip2 \
    ca-certificates \
    && apt-get clean

# Set up a non-root user (LEDE/OpenWrt Image Builder cannot be run as root)
RUN useradd -m lede
USER lede
WORKDIR /home/lede

# Download and extract the LEDE 17.01.7 Image Builder from the primary OpenWrt downloads server
RUN wget https://downloads.openwrt.org/releases/17.01.7/targets/ar71xx/generic/lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz \
    && tar -xJf lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz \
    && rm lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz

# Set the working directory to the extracted Image Builder
WORKDIR /home/lede/lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64

# Default command: prints info on how to use the Image Builder
CMD ["make", "info"]
