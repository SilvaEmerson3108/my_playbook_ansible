#!/bin/bash

# 1. set connection details
url=https://your_zabbix_url/api_jsonrpc.php
user=Your-User
password='Your_Passwd'

# 2. get authorization token
auth=$(curl -s -X POST \
-H 'Content-Type: application/json-rpc' \
-d " \
{
 \"jsonrpc\": \"2.0\",
 \"method\": \"user.login\",
 \"params\": {
  \"user\": \"$user\",
  \"password\": \"$password\"
 },
 \"id\": 1,
 \"auth\": null
}
" $url | \
jq -r '.result'
)

curl -s -X POST \
-H 'Content-Type: application/json-rpc' \
-d " \
{
    \"jsonrpc\": \"2.0\",
    \"method\": \"host.create\",
    \"params\": {
        \"host\": \"insira_o_hostname\",
        \"interfaces\": [
            {
                \"type\": 1,
                \"main\": 1,
                \"useip\": 1,
                \"ip\": \"insira_o_ip\",
                \"dns\": \"\",
                \"port\": \"10051\"
            }
        ],
        \"groups\": [
            {
                \"groupid\": \"2\"
            }
        ],
        \"templates\": [
            {
                \"templateid\": \"10001\"
            }
        ]   
    },
    \"auth\": \"$auth\",
    \"id\": 3
} 
" $url 