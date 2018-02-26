FROM resin/raspberry-pi-alpine-node

RUN \
	apk add --no-cache nodejs g++ gcc git make bash python && \
	export MAKEFLAGS=-j8 && \
	npm install -g storjshare-daemon && \
	npm cache clear --force && \
	apk del --no-cache g++ gcc git make bash python

ENV INITSYSTEM=on
ENV USE_HOSTNAME_SUFFIX=FALSE
ENV DATADIR=/data/storj
ENV WALLET_ADDRESS=
ENV SHARE_SIZE=10GB
ENV RPCADDRESS=0.0.0.0

VOLUME ["/data/storj"]

EXPOSE 4000-4003/tcp

ADD storj.sh /storj.sh

ENTRYPOINT ["/storj.sh"]
