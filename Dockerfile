FROM ubuntu:focal
MAINTAINER Vincent Mele <vince@nyseion.com>

ENV TENDIS_VERSION="2.4.3-rocksdb-v5.13.4"
ENV ROCKSDB_VERSION="v7.0.4"

ENV TZ="Europe/London"
RUN apt-get update && apt-get install -yq tzdata && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y build-essential cmake autoconf libjemalloc-dev git

ADD patches/rocksdb-7.x.diff /rocks7.diff
ADD patches/remove-warnings.diff /cmake.diff
ADD tendisplus.conf /tendisplus.conf
ADD build.sh /

WORKDIR /
RUN sh /build.sh

FROM ubuntu:focal
COPY --from=0 /tendis/build/bin/tendisplus /tendisplus
EXPOSE 51002

CMD ["tendisplus", "tendisplus.conf"]
