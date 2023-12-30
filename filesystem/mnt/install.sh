#!/usr/bin/env bash
: "${MINIO_ROOT_PASSWORD?}"
: "${SERVER_KEY_PASSPHRASE?}"

##
echo "Install the base tools"

apt-get update
apt-get install -y \
 curl vim wget htop unzip gnupg2 lsb-release socat \
 bash-completion software-properties-common

echo "Download the MinIO server’s latest .deb package"
curl -Lo minio.deb https://dl.min.io/server/minio/release/linux-amd64/minio_20231223071911.0.0_amd64.deb

echo "Set up a minio command and a systemd startup script"
dpkg -i minio.deb

mkdir -p /etc/minio/certs
cat /etc/ssl/certs/server-chain.crt > /etc/minio/public.crt
openssl rsa \
  -in /etc/ssl/private/server-encrypted.key \
  -out /etc/minio/certs/private.key \
  -passin "pass:$SERVER_KEY_PASSPHRASE"

echo "Create a system group that the MinIO server will run"
groupadd -r minio-user
useradd -M -r -g minio-user minio-user

mkdir /mnt/data
chown minio-user:minio-user /mnt/data

#cat << EOF > /etc/default/minio
#MINIO_VOLUMES="/mnt/data"
#MINIO_OPTS="--certs-dir /etc/minio/certs --console-address :9001"
#MINIO_ROOT_USER=minioadmin
#MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
#EOF

# MINIO_ROOT_USER=admin MINIO_ROOT_PASSWORD=password minio server /mnt/data --console-address ":9001"

#systemctl start minio
