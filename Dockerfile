FROM docker.io/ubuntu:latest

ADD http://download.redis.io/redis-stable.tar.gz /tmp
RUN apt-get update && apt-get -y install \
    libjemalloc2 \
    libjemalloc-dev \
    gcc \
    make
WORKDIR /tmp
RUN tar xzvf redis-stable.tar.gz
WORKDIR /tmp/redis-stable
RUN make

FROM docker.io/ubuntu:21.10
COPY --from=0 /tmp/redis-stable/src/redis-cli /usr/local/bin/
