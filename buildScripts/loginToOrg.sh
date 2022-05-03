mkdir keys1  
    echo $Server_Key | base64 -di > keys1/server.key
echo "Authenticating org"
    sfdx force:auth:jwt:grant --clientid $Consumer_key --jwtkeyfile keys1/server.key --username $SFDX_Username --instanceurl $Instance_URL --setdefaultdevhubusername -a DevHub