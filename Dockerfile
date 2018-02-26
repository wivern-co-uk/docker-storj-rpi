FROM resin/raspberry-pi-alpine-node

RUN apk add --no-cache nodejs g++ gcc git make bash python && \
		export MAKEFLAGS=-j8 && \
		npm install -g storjshare-daemon && \
		npm cache clear --force && \
		apk del --no-cache g++ gcc git make bash python

ENV INITSYSTEM=on \
    USE_HOSTNAME_SUFFIX=FALSE \
    DATADIR=/data/storj \
    WALLET_ADDRESS= \
    SHARE_SIZE=10GB \
    RPCADDRESS=0.0.0.0

VOLUME ["/data/storj"]

EXPOSE 4000-4003/tcp

ADD storj.sh /storj.sh

ENTRYPOINT ["/storj.sh"]
