FROM debian:bookworm-slim

COPY ./filesystem /.

RUN find /mnt -print

ENV SERVER_KEY_PASSPHRASE=$SERVER_KEY_PASSPHRASE

RUN set -x
RUN bash /mnt/pre-install.sh
RUN bash /mnt/install.sh
RUN bash /mnt/supervisor.sh

EXPOSE 9000 9001

CMD ["/usr/bin/supervisord"]
