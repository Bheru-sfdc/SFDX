echo "Deploy to target deployment org and run unit tests"
    sfdx force:mdapi:deploy --checkonly --wait -1 -d src --targetusername $SFDX_Username --testlevel $TESTLEVEL -r $TESTCLASSLIST