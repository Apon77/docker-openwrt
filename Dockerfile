# Use an older, compatible Ubuntu release because LEDE 17.01.7 
# requires older host build tools (like older ncurses/make versions)
FROM ubuntu:18.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential dependencies for the LEDE Image Builder
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
    python3 \
    xsltproc \
    zlib1g-dev \
    libssl-dev \
    && apt-get clean

# Create a non-root build user (LEDE/OpenWrt prohibits building as root)
RUN useradd -m builduser
USER builduser
WORKDIR /home/builduser

# Download and extract the LEDE 17.01.7 Image Builder for the ar71xx target
RUN wget https://downloads.openwrt.org/releases/17.01.7/targets/ar71xx/generic/lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz \
    && tar -xf lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz \
    && rm lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64.tar.xz

# Set the working directory directly to the extracted image builder
WORKDIR /home/builduser/lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64

# Keep the container alive or ready for interactive bash sessions
CMD ["/bin/bash"]

