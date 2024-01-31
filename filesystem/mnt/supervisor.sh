#!/usr/bin/env bash

echo "Configure supervisor"
cat <<EOF > /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:named]
command=minio server /mnt/data --certs-dir /etc/minio/certs --console-address :9001
EOF
