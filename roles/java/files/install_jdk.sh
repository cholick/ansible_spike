#!/bin/bash -ex

url=http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz
cookie="Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"
expected_checksum=3b3f74589539b8bbe5d78005e52f4f78
version=8.40
download_file="jdk-${version}.tar.gz"

mkdir -p /opt/java
cd /opt/java

size=`curl -sIL --header "$cookie" $url | grep "200 OK" -A 100 | grep "Content-Length" | awk '{print $2}' | tr -d $'\r'`

size_on_disk=0
if [ -a "$download_file" ]; then
    size_on_disk=`ls -lrt "$download_file" | awk '{print $5}'`
fi

if [ "$size" -ne "$size_on_disk" ]; then
    echo "Downloading, different local file size vs server: $size vs $size_on_disk"
    wget --quiet \
         --output-document "$download_file" \
         --header "$cookie"  \
         $url
else
    echo "Skipping download, already on disk"
fi

checksum=`md5sum "$download_file" | awk '{print $1}'`
if [ "$checksum" !=  "$expected_checksum" ]; then
    echo "Invalid checksum"
    exit 1
fi

mkdir -p "jdk-$version"

tar xf "$download_file" --strip-components 1 -C "jdk-$version"

update-alternatives --install /usr/bin/java java "/opt/java/jdk-$version/bin/java" 1
