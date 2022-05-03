echo "Decrypting Server Key"
    #mkdir keys  
    #echo $Server_Key | base64 -di > keys/server.key

    openssl enc -nosalt -aes-256-cbc -d -in $CONTEXT_JWT_KEY_FILE_ENC -out $CONTEXT_JWT_KEY_FILE -base64 -K $CONTEXT_DECRYPTION_KEY -iv $CONTEXT_DECRYPTION_IV       