
echo "Authenticating org"
    sfdx force:auth:jwt:grant --clientid $Consumer_key --jwtkeyfile $CONTEXT_JWT_KEY_FILE --username $SFDX_Username --instanceurl $Instance_URL --setdefaultdevhubusername -a DevHub
  