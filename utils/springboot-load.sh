#!/usr/bin/env bash
echo "starting load test - http://innowashere.com/springboot"

while sleep 1; 
do 
  curl http://innowashere.com/springboot/hello
  curl http://innowashere.com/springboot/helloNode
done