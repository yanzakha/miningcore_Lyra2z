FROM debian:stable-slim

RUN useradd -r taler \
  && apt-get update -y \
  && apt-get install -y curl gnupg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex
#  && for key in \
#    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#  ; do \
#    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
#    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
#    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
#    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
#  done

ENV GOSU_VERSION=1.10

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
#  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
#  && gpg --verify /usr/local/bin/gosu.asc \
#  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV BITCOIN_VERSION=0.16.3
ENV BITCOIN_DATA=/home/taler/.taler
ENV PATH=/opt/taler:$PATH

RUN curl -SLO https://talercrypto.com/files/taler.tar.gz \
  && mkdir /opt/taler \
  && tar -xzf *.tar.gz -C /opt/taler \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/taler/.taler"]

EXPOSE 8332 8333 18332 18333 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["talerd"]

