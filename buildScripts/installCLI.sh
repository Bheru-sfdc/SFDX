echo "Downloading Salesforce CLI"
    mkdir sfdx
    wget -qO- $DX_CLI_URL | tar xJ -C sfdx --strip-components 1

echo "Installing Salesforce CLI"
    ./sfdx/install
    sfdx
    mkdir tmp
