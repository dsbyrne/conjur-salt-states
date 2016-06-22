#!/usr/bin/env bash
set -e

err () {
 echo "$@" 1>&2;
 echo ""
 echo "Usage: run.sh <ACCOUNT> <API_KEY> <CERTIFICATE PATH>"
 exit 1
}

{
  docker-compose kill
  docker-compose rm -f
} &> /dev/null

[ -n "$1" ] || err "Missing account"
[ -n "$2" ] || err "Missing API key for host/app-002.itp.myorg.com"
[ -n "$3" ] || err "Missing certificate path"

echo "Creating data file for the salt master..."
{
  IDENTITY_FILE=app-identity.yml
  mkdir -p tmp
  pushd tmp
    echo "appliance_url: https://conjur/api" >  $IDENTITY_FILE
    echo "account: $1" >> $IDENTITY_FILE
    echo "id: app-002.itp.myorg.com" >> $IDENTITY_FILE
    echo "api_key: $2" >> $IDENTITY_FILE
    echo "certificate: |" >> $IDENTITY_FILE
    echo "$(awk '{print " ", $0}' $3)" >> $IDENTITY_FILE
  popd
} &> /dev/null

echo "Waiting for the containers to come up..."
{
  docker-compose up -d
  sleep 11s
} &> /dev/null

MASTER_ID=$(docker-compose ps | grep salt-master | awk '{print $1}')
run_cmd () {
  docker exec -it $MASTER_ID "$@"
}

echo "Waiting for the minion to reconnect to the master..."
{
  run_cmd salt-key -Ay
  sleep 11s
} &> /dev/null

run_cmd salt '*' saltutil.sync_all
run_cmd salt '*' state.apply