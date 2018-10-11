#!/bin/bash

set -euo pipefail

es_url=https://elastic:${ELASTIC_PASSWORD}@elasticsearch:9200

until curl -s $es_url -o /dev/null; do
    sleep 1
done

# Set the password for the kibana user.
# REF: https://www.elastic.co/guide/en/x-pack/6.0/setting-up-authentication.html#set-built-in-user-passwords
until curl -s -H 'Content-Type:application/json' \
     -XPUT $es_url/_xpack/security/user/logstash_system/_password \
     -d "{\"password\": \"${ELASTIC_PASSWORD}\"}"
do
    sleep 2
    echo Retrying...
done