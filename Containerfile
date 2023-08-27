from fedora:latest as build-env

run dnf -y install dnf-plugins-core
run dnf copr enable aptupdate/bitwarden-cli -y

run mkdir /output
run dnf -y --installroot /output --releasever $(cat /etc/system-release | awk '{print $3}') --setopt=install_weak_deps=false --nodocs install glibc-minimal-langpack coreutils-single bitwarden-cli
run dnf -y --installroot /output --releasever $(cat /etc/system-release | awk '{print $3}') clean all

from scratch
copy --from=build-env /output /

ENV HOME=/data
WORKDIR /data
VOLUME /data

ENTRYPOINT ["bw"]
