FROM easypi/alpine-arm:edge

RUN \
  apk add --no-cache nodejs nodejs-npm g++ gcc git make bash python && \
  export MAKEFLAGS=-j8 && \
  npm config set unsafe-perm true && \
  npm install --global storjshare-daemon && \
  npm cache clean --force && \
  apk del --no-cache g++ gcc git make bash python

RUN \
  apk add --no-cache nodejs nodejs-npm git build-base python && \
  git clone https://github.com/calxibe/StorjMonitor.git && \
  cd StorjMonitor && \
  rm -rf node_modules && \
  npm install --production && \
  apk del --no-cache git build-base python

ENV \
  DATADIR=/data/storj \
  MOUNT_SOURCE= \
  MOUNT_DEST= \
  WALLET_ADDRESS= \
  SHARE_SIZE= \
  RPC_ADDRESS="0.0.0.0" \
  RPC_PORT="80" \
  STORJSTAT_KEY=

ADD entrypoint /
ENTRYPOINT ["/entrypoint"]
