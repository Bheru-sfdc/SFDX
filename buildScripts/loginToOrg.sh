mkdir keys  
    echo $Server_Key | base64 -di > keys/server.key
echo "Authenticating org"
    sfdx force:auth:jwt:grant --clientid $Server_Key --jwtkeyfile keys/server.key --username $SFDX_Username --instanceurl $Instance_URL --setdefaultdevhubusername -a DevHub