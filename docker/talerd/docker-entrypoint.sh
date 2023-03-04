#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for talerd"

  set -- talerd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "talerd" ]; then
  mkdir -p "$BITCOIN_DATA"
  chmod 700 "$BITCOIN_DATA"
  chown -R taler "$BITCOIN_DATA"

  echo "$0: setting data directory to $BITCOIN_DATA"

  set -- "$@" -datadir="$BITCOIN_DATA" -rpcuser="$TALER_RPC_USER" -rpcpassword="$TALER_RPC_PASSWORD" -rpcport=10000 -rpcbind=0.0.0.0 -rpcallowip="0.0.0.0/0" -zmqpubhashblock="tcp://0.0.0.0:3000"
fi

#if [ "$1" = "taler-cli" ] || [ "$1" = "taler-tx" ]; then
#  set -- "$@" -rpcuser="$TALER_RPC_USER" -rpcpassword="$TALER_RPC_PASSWORD" -rpcport=10000 -rpcconnect=127.0.0.1
#fi

if [ "$1" = "talerd" ] || [ "$1" = "taler-cli" ] || [ "$1" = "taler-tx" ]; then
  echo
  exec gosu taler "$@"
fi

echo
exec "$@"

