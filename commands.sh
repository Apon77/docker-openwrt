#Enter in ~/docker-openwrt where Dockerfile stays
#Then run below command
docker build -t lede-builder . 

#you can save the build as tar by below command or unload if dont want to rebuild
#docker save -o lede-builder.tar lede-builder:latest
#docker load -i lede-builder.tar


#keep config files under the folder files and mount it.

docker run -it \
  -v "$(pwd)/output:/home/builduser/output" \
  -v "$(pwd)/files:/home/builduser/lede-imagebuilder-17.01.7-ar71xx-generic.Linux-x86_64/files" \
  --name my-lede-container \
  lede-builder /bin/bash


#inside docker image run this to get the bin in current directory.
make image PROFILE=tl-wr740n-v4 \
PACKAGES="luci stubby libopenssl -ip6tables -odhcp6c -kmod-ipv6 -kmod-ip6tables -odhcpd-ipv6only -ppp -ppp-mod-pppoe -kmod-ppp -kmod-pppoe" \
BIN_DIR="/home/builduser/output/" \
FILES="files"

#now run this command in local pc to get the file
gcloud cloud-shell scp cloudshell:~/docker-openwrt/output/lede-17.01.7-ar71xx-generic-tl-wr740n-v4-squashfs-sysupgrade.bin localhost:./
