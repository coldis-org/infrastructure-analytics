#!/bin/sh
	
# Changes the password.
curl -XPUT -u elastic:changeme "localhost:${NODE_HTTP_PORT}/_xpack/security/user/elastic/_password" \
-H "Content-Type: application/json" -d "{ \"password\" : \"${PASSWORD}\" }"

