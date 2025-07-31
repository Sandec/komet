#!/bin/bash

set -e
set -x

# SERVER=server1.java4browser.com
SERVER=komet.sandec.de
KEY_FILE=~/.ssh/komet
PROJECT=komet
USERNAME=ubuntu

# ./mvnw clean install -DskipTests; ./mvnw -P jpro -pl application jpro:release

echo "Updating nginx"

ssh -i $KEY_FILE -t $USERNAME@$SERVER "rm nginx.conf"  || true
scp -r -i $KEY_FILE conf/nginx.conf $USERNAME@$SERVER:.
ssh -i $KEY_FILE -t $USERNAME@$SERVER "sudo cp -f nginx.conf /etc/nginx/conf.d"  || true

echo "RESTARTING NGINX"
ssh -i $KEY_FILE -t $USERNAME@$SERVER  "sudo service nginx restart"
echo "FINISHED update conf $SERVER"


ssh -i $KEY_FILE -t $USERNAME@$SERVER "rm jpro/$PROJECT-jpro.zip"  || true
ssh -i $KEY_FILE -t $USERNAME@$SERVER "rm -r ./jpro/$PROJECT-jpro"  || true
scp -i $KEY_FILE ./application/target/$PROJECT-jpro.zip $USERNAME@$SERVER:jpro/

ssh -i $KEY_FILE -t $USERNAME@$SERVER "cd jpro ; unzip $PROJECT-jpro.zip ; rm $PROJECT-jpro.zip"

# ssh -i $KEY_FILE  $USERNAME@$SERVER "./jpro/$PROJECT-jpro/bin/restart.sh  > /dev/null 2> /dev/null < /dev/null &"

ssh -i $KEY_FILE -t $USERNAME@$SERVER  "cd ./jpro/$PROJECT-jpro; docker compose up -d --build --force-recreate --no-deps"

# docker compose up -d --build --force-recreate --no-deps