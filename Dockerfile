FROM debian:bookworm-slim

COPY ./filesystem /.

RUN find /mnt -print

ARG _SERVER_KEY_PASSPHRASE
ENV SERVER_KEY_PASSPHRASE=${_SERVER_KEY_PASSPHRASE}

RUN set -x
RUN bash /mnt/pre-install.sh
RUN bash /mnt/install.sh
RUN bash /mnt/supervisor.sh

EXPOSE 22 9000 9001

CMD ["/usr/bin/supervisord"]
