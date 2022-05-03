mkdir keys  
    echo $DevOrg_Key | base64 -di > keys/server.key
echo "Authenticating org"
    sfdx force:auth:jwt:grant --clientid $DevOrg_Consumer --jwtkeyfile keys/server.key --username $DevOrg_UserName --instanceurl $Instance_URL --setdefaultdevhubusername -a DevHub