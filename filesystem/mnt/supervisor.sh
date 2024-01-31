#!/usr/bin/env bash

echo "Configure supervisor"
cat <<EOF > /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:named]
command=minio server /mnt/data --console-address ":9001"
EOF
