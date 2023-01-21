#!/bin/bash

host=$1

curl -I http://${host}:80 
if [ $? -ne 0 ]; then
    echo "TED search is not availible on port 80"
    exit 1
fi

curl -I http://${host}:80/api/search?q=work 
if [ $? -ne 0 ]; then
    echo "TED search api is not availible"
    exit 1
fi

echo "TED search is up and running on port 80"
exit 0