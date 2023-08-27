from fedora:latest as build-env

run dnf -y install wget unzip
run wget https://github.com/bitwarden/clients/releases/download/cli-v2023.7.0/bw-linux-2023.7.0.zip
run unzip bw-linux-2023.7.0.zip

run mkdir /output
run dnf -y --installroot /output --releasever $(cat /etc/system-release | awk '{print $3}') --setopt=install_weak_deps=false --nodocs install glibc-minimal-langpack coreutils-single libstdc++
run dnf -y --installroot /output --releasever $(cat /etc/system-release | awk '{print $3}') clean all
run mv bw /output/usr/bin/

from scratch
copy --from=build-env /output /

ENV HOME=/data
WORKDIR /data
VOLUME /data

ENTRYPOINT ["bw"]
