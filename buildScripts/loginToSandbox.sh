echo "Authenticating org"
    sfdx force:auth:jwt:grant --clientid $Consumer_key --jwtkeyfile keys/server.key --username $SFDX_Username --instanceurl $Instance_URL --setdefaultdevhubusername -a DevHub