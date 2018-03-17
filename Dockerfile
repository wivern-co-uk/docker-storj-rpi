FROM easypi/alpine-arm:edge

RUN \
	apk add --no-cache nodejs nodejs-npm g++ gcc git make bash python && \
	echo "node version: $(node --version)" && \
	echo "npm version: $(npm --version)" && \
	export MAKEFLAGS=-j8 && \
	npm config set unsafe-perm true && \
	npm install --global storjshare-daemon && \
	npm cache clean --force && \
	apk del --no-cache nodejs-npm g++ gcc git make bash python

RUN \
	apk add --no-cache git curl

ENV DATADIR=/data/storj \
    MOUNT_SOURCE= \
    MOUNT_DEST= \
    WALLET_ADDRESS= \
    SHARE_SIZE= \
    RPC_ADDRESS="0.0.0.0" \
    RPC_PORT="80"

ADD versions entrypoint /
ENTRYPOINT ["/entrypoint"]
