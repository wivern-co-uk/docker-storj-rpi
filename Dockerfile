FROM easypi/alpine-arm:3.7

RUN \
  apk add --no-cache nodejs nodejs-npm g++ gcc git make python && \
  export MAKEFLAGS=-j8 && \
  npm config set unsafe-perm true && \
  npm install --global storjshare-daemon && \
  npm cache clean --force && \
  apk del --no-cache g++ gcc git make python

RUN \
  apk add --no-cache nodejs nodejs-npm git build-base python && \
  git clone https://github.com/wivern-co-uk/StorjMonitor.git && \
  cd StorjMonitor && \
  rm -rf node_modules .git && \
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
  STORJSTAT_INTERVAL="900" \
  STORJSTAT_KEY=

ADD entrypoint storjstat /
ENTRYPOINT ["/entrypoint"]
