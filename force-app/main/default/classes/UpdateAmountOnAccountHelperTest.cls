/**
    *Name		:- UpdateAmountOnAccountHelperTest class
	*CreatedBy	:- Bheru gadri
	*CreatedDate:- 2/06/2021
	*Desc		:- this is a Test class for UpdateAmountOnAccountHelper where we Test update Total_Amount__c field on Account based on Contact Amount__c field 
**/
@isTest
public class UpdateAmountOnAccountHelperTest {
    /**
    *Name:- UpdateTotalAmountFiledWithBulkData()
	*Desc:- this function is used to  update Total_Amount__c field on Account with Bulk data 
	**/
    static testMethod void UpdateTotalAmountFiledWithBulkData(){
        
		// Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 200 Account Records
		for(Integer i=0; i<200; i++){
			accList.add(TestDataFactory.createAccount(i));
		}
        
		Test.startTest();
		// Insert AccountList
		insert accList;
        
		// call createBulkContact() from TestDataFactory and Insert 2 Contacts for Each Account
		if(accList.size() >0){
			for(Integer i=0; i<accList.size(); i++){
				for(Integer j=0; j<2; j++){
					conList.add(TestDataFactory.createBulkContact(accList[i].Id, j,100) );
				}  
			}
            
			// Insert conlist
			insert conList;
        
    		// Retrieve Inserted Account Records
    		accList = [select Id,Total_Amount__c from Account limit 200];	
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Contact Amount__c Field
				System.assertEquals(200, acc.Total_Amount__c);

			} // End for
        
			//Retrieve All The Contacts and Update Amount__c Field
    		conList = [select Id,LastName,Amount__c from Contact where AccountId IN: accList];
	
			for(Contact con: conList){
				if(con.LastName == 'Contact0'){
					con.Amount__c = 250;
				}else if(con.LastName == 'Contact1'){
					con.Amount__c = 50;
				}
			} // End for
	
			update conList;

			// Retrieve Updated Account Records
    		accList = [select Id,Total_Amount__c from Account limit 200];
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Contact Amount__c Field
				System.assertEquals(300, acc.Total_Amount__c);
			} // End for
        	Test.stopTest();
		} // End If
        
    }// UpdateTotalAmountFiledWithBulkData()
    
    /**
    *Name:- UpdateTotalAmountFieldWhenContactInserted()
	*Desc:- this function is used to  update Total_Amount__c field on Account whenever Contact record inserted 
	**/
    static testMethod void UpdateTotalAmountFieldWhenContactInserted(){

    	// Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 1 Account Records
		accList.add(TestDataFactory.createAccount(1));

		Test.startTest();
		// Insert AccountList
		insert accList;
        
    	// call createBulkContact() from TestDataFactory And insert 1 Contact Records 
        if(accList.size()>0){
            conList.add(TestDataFactory.createBulkContact(accList[0].Id, 1,50) );
    		insert conList;

    		// Retrieve Inserted Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field After Inserted Contact Amount__c Field
				System.assertEquals(50, acc.Total_Amount__c);

			} // End for
            Test.stopTest();
        } // End if        
    } // End UpdateTotalAmountFieldWhenContactInserted()
    
    /**
    *Name:- UpdateTotalAmountFieldWhenContactUpdated()
	*Desc:- this function is used to  update Total_Amount__c field on Account whenever Contact Amount__c field Updated 
	**/
    
    static testMethod void UpdateTotalAmountFieldWhenContactUpdated(){
        
        // Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 1 Account Records
		accList.add(TestDataFactory.createAccount(1));

		Test.startTest();
		// Insert AccountList
		insert accList;
        
    	// call createBulkContact() from TestDataFactory And insert 1 Contact Records 
        if(accList.size()>0){
            conList.add(TestDataFactory.createBulkContact(accList[0].Id, 1,150) );
    		insert conList;
            
             // Retrieve Inserted Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Contact Amount__c Field
				System.assertEquals(150, acc.Total_Amount__c);

			} // End for
        
        	// retrieve Contact record Related to 1 Account And Updated Amount__c field
        	conList = [select Id,Amount__c from Contact where AccountId IN:accList];
        	for(Contact con : conList){
                con.Amount__c = 300;
            
        	} // End for 
        	update conList;

        	// Retrieve Updated Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field After Updated Contact Amount__c Field
				System.assertEquals(300, acc.Total_Amount__c);

			} // End for
            Test.stopTest();
		} // End if
        
    } // End UpdateTotalAmountFieldWhenContactUpdated()
    
    /**
    *Name:- UpdateTotalAmountFieldWhenContactDeleted()
	*Desc:- this function is used to  update Total_Amount__c field on Account whenever Contact Amount__c field Deleted 
	**/
    static testMethod void UpdateTotalAmountFieldWhenContactDeleted(){
        
        // Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 1 Account Records
		accList.add(TestDataFactory.createAccount(1));

		Test.startTest();
		// Insert AccountList
		insert accList;
        
    	// call createBulkContact() from TestDataFactory And insert 1 Contact Records 
        if(accList.size()>0){
            conList.add(TestDataFactory.createBulkContact(accList[0].Id, 1,90) );
    		insert conList;
			// Retrieve Inserted Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Contact Amount__c Field
				System.assertEquals(90, acc.Total_Amount__c);

			} // End for
        
        	// retrieve Contact record Related to 1 Account And delete them
        	conList = [select Id,Amount__c from Contact where AccountId IN:accList];
         
        	delete conList;
  
        	// Retrieve Updated Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field After Updated Contact Amount__c Field
				System.assertEquals(0, acc.Total_Amount__c);

			} // End for
            Test.stopTest();
		} // End if
        
    } // End UpdateTotalAmountFieldWhenContactDeleted()
    
    /**
    *Name:- UpdateTotalAmountFieldWhenContactUnDeleted()
	*Desc:- this function is used to  update Total_Amount__c field on Account whenever Contact Amount__c field UnDeleted 
	**/
    static  testMethod void UpdateTotalAmountFieldWhenContactUndelete(){
        
        // Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 1 Account Records
		accList.add(TestDataFactory.createAccount(1));

		Test.startTest();
		// Insert AccountList
		insert accList;
        
    	// call createBulkContact() from TestDataFactory And insert 1 Contact Records 
        if(accList.size()>0){
            conList.add(TestDataFactory.createBulkContact(accList[0].Id, 1,45) );
    		insert conList;
            
			// Retrieve Inserted Account Records
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Contact Amount__c Field
				System.assertEquals(45, acc.Total_Amount__c);

			} // End for
        
        	// retrieve Contact record Related to 1 Account And delete them
        	conList = [select Id,Amount__c from Contact where AccountId IN:accList];
         
        	delete conList;

        	// Retrieve Updated Account Records after Contact Deleted
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field After Updated Contact Amount__c Field
				System.assertEquals(0, acc.Total_Amount__c);

			} // End for
        
			// Undelete the deleted contact 
        	undelete conList;
        
        	// Retrieve Updated Account Records After Undeleted Contact
    		accList = [select Id,Total_Amount__c from Account limit 1];
    		for(Account acc: accList){
				// Check Total_Amount__c Field After Updated Contact Amount__c Field
				System.assertEquals(45, acc.Total_Amount__c);

			} // End for
            Test.stopTest();
      	} // End if
        
    }// End UpdateTotalAmountFieldWhenContactUndelete()
    
    /**
    *Name:- UpdateTotalAmountFieldWhenAccountChangedOnContact()
	*Desc:- this function is used to  update Total_Amount__c field on Account whenever Account Changed On Contact Record
	**/
    static  testMethod void UpdateTotalAmountFieldWhenAccountChangedOnContact(){
        
        // Variable Declaration
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        
		// call createBulkAccount() from TestDataFactory And insert 200 Account Records
		for(Integer i=0; i<2; i++){
			accList.add(TestDataFactory.createAccount(i));
		}
        
		Test.startTest();
		// Insert AccountList
		insert accList;
        
		// call createBulkContact() from TestDataFactory and Insert 2 Contacts for Each Account
		if(accList.size() >0){
			for(Integer i=0; i<accList.size(); i++){
				for(Integer j=0; j<2; j++){
					conList.add(TestDataFactory.createBulkContact(accList[i].Id, j,50) );
				}// End for 
			} // End for
            
			// Insert conlist
			insert conList;
        
    		// Retrieve Inserted Account Records
    		accList = [select Id,Name,Total_Amount__c,(select Id,Lastname,Amount__c,AccountId from Contacts) from Account limit 2];
    		for(Account acc: accList){
				// Check Total_Amount__c Field Before Updated Account
				System.assertEquals(100, acc.Total_Amount__c);

			} // End for
       		
            // Retrieve contacts and transfer 1st contact From 1st Account to 2nd Account
        	conList = [select Id,LastName,AccountId from Contact where AccountId IN: accList];
        	for(Contact con : conList){
            	if(con.AccountId == accList[0].Id && con.LastName == 'Contact0'){
                	con.AccountId = accList[1].Id;
            	}
        	} // End for
            
        	update conList;
        	
            // Retrieve 2nd Account And Check Total_Amount__c field 
        	accList = [select Id,Total_Amount__c from Account where Name = 'TestAccount1'];
    		for(Account acc: accList){
				// Check Total_Amount__c Field 
				System.assertEquals(150, acc.Total_Amount__c);

			} // End for
        	Test.stopTest();
    	} // End if
        
    } // End UpdateTotalAmountFieldWhenAccountChangedOnContact()
    

} // End UpdateAmountOnAccountHelperTest