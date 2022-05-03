echo "Decrypting Server Key"
    mkdir keys  
    echo $Server_Key | base64 -di > keys/server.key