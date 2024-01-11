# iac-lxd-adm-minio

(Optional) Expose minio buckets for public access (Spacelift)

    <LocationMatch ^/bucket-(.*)$>
        ProxyPass https://10.0.10.109:9000/bucket-$1
        ProxyPassReverse https://10.0.10.109:9000/bucket-$1
    </LocationMatch>
    
(Optional) Create Spacelift context sa-minio-adm

    MINIO_ENDPOINT=https://telephus.k-space.ee/minio
    MINIO_ACCESS_KEY=changeit
    MINIO_SECRET_KEY=changeit
    
## Helpers

    openssl s_client -showcerts -connect localhost:9000 </dev/null
    openssl s_client -showcerts -connect minio.adm.acme.corp:9000 </dev/null
    
    journalctl -u minio
    grep minio /var/log/syslog

## Links

- https://www.digitalocean.com/community/tutorials/how-to-set-up-minio-object-storage-server-in-standalone-mode-on-ubuntu-20-04
- https://min.io/docs/minio/linux/operations/install-deploy-manage/deploy-minio-single-node-single-drive.html#minio-snsd
- https://ruben-rodriguez.github.io/posts/minio-s3-terraform-backend/
