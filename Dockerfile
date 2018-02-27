FROM easypi/alpine-arm:3.4
RUN apk add --no-cache nodejs

RUN \
	apk add --no-cache g++ gcc git make bash python && \
	export MAKEFLAGS=-j8 && \
	npm install -g storjshare-daemon && \
	npm cache clear --force && \
	apk del --no-cache g++ gcc git make bash python

ENV USE_HOSTNAME_SUFFIX=FALSE \
    DATADIR=/storj \
    WALLET_ADDRESS= \
    SHARE_SIZE=1TB \
    RPCADDRESS=0.0.0.0 \
		MOUNT_SOURCE=/dev/sda1 \
		MOUNT_DEST=/mnt/storage

EXPOSE 4000-4003/tcp

ADD versions entrypoint /
ENTRYPOINT ["/entrypoint"]
