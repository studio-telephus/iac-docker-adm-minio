#!/usr/bin/env bash
: "${MINIO_ROOT_USER?}"
: "${MINIO_ROOT_PASSWORD?}"
: "${SERVER_KEY_PASSPHRASE?}"

##
echo "Install the base tools"

apt-get update
apt-get install -y \
 curl vim htop bash-completion

echo "Download the MinIO server’s latest .deb package"
curl -Lo minio.deb https://dl.min.io/server/minio/release/linux-amd64/minio_20231223071911.0.0_amd64.deb

echo "Set up a minio command and a systemd startup script"
dpkg -i minio.deb

echo "Create a system group that the MinIO server will run"
groupadd -r minio-user
useradd -M -r -g minio-user minio-user


mkdir -p /etc/minio/certs
cat /etc/ssl/certs/server-chain.crt > /etc/minio/certs/public.crt
openssl rsa \
  -in /etc/ssl/private/server-encrypted.key \
  -out /etc/minio/certs/private.key \
  -passin "pass:$SERVER_KEY_PASSPHRASE"
chown -R minio-user:minio-user /etc/minio/certs/

mkdir /mnt/data
chown minio-user:minio-user /mnt/data


cat << EOF > /etc/default/minio
MINIO_VOLUMES="/mnt/data"
MINIO_OPTS="--certs-dir /etc/minio/certs --console-address :9001"
MINIO_ROOT_USER=${MINIO_ROOT_USER}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
EOF

systemctl start minio
systemctl enable minio
