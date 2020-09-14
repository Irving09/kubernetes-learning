#!/usr/bin/env bash
echo "starting load test - http://innowashere.com/nodejs/hello"

while sleep 1; 
do 
  curl http://innowashere.com/nodejs/hello
done