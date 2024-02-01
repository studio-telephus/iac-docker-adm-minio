#!/usr/bin/env bash

echo "Configure supervisor"
cat <<EOF > /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:named]
command=minio server /mnt/data --certs-dir /etc/minio/certs --console-address :9001

[program:sshd]
command=/usr/sbin/sshd -D
EOF

ssh-keygen -t rsa -b 4096 -C "root@minio" -f ~/.ssh/id_rsa -q -N ""

### Missing privilege separation directory: /run/sshd
mkdir /var/run/sshd
