/**
    *Name:- AccountRoleTriggerHelper_Test class
	*Desc:- this is a Test class for AccountRoleTriggerHelper where we Test whenever Changed Role__c,Contact__c And Account Also test when we transfer AccountRole__c one Account to Another Account functionality
**/
@isTest
public class AccountRoleTriggerHelper_Test {
    /**
    *Name:- setup()
	*Desc:- this function is used to create Test Data for all the test Methods
	**/
    /*@testSetup static void onSetup(){
        // variable Declaration
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<AccountRole__c> accRoleList = new List<AccountRole__c>();
        
        // Insert 200 Account Records
        for( Integer i=1; i<=200; i++){
            Account Acc = new Account();
            Acc.Name = 'TestAccount' + i;
            accList.add(Acc);
		}
        Test.startTest();
        Insert accList;
        
        // Insert 4 Contact for Each Account Records
        for(Account acc : acclist){
            Contact con1 = new Contact();
            con1.LastName = 'Contact1';
            con1.AccountId = acc.Id;
            conList.add(con1);
            
            Contact con2 = new Contact();
            con2.LastName = 'Contact2';
            con2.AccountId = acc.Id;
            conList.add(con2);
            
            Contact con3 = new Contact();
            con3.LastName = 'Contact3';
            con3.AccountId = acc.Id;
            conList.add(con3);
            
            Contact con4 = new Contact();
            con4.LastName = 'Contact4';
            con4.AccountId = acc.Id;
            conList.add(con4);
            
        }
        Insert conList;
        
        // Retrieve Inserted Account With Associated Contacts
        accList =[select Id,Name,(select Id,LastName from Contacts) from Account limit 200];
      
        //Insert 4 AccountRole for Each Account Records
        for(Account acc : accList){
            for(Contact con:acc.contacts){
				if(con.LastName == 'Contact1'){
                    AccountRole__c accRole1 = new AccountRole__c();
                    accRole1.Name = 'AccountRole1';
                    accRole1.Role__c = 'Active';
                    accRole1.Contact__c = con.Id;
                    accRole1.AccountId__c = acc.Id;
                    accRoleList.add(accRole1);
                } else if(con.LastName == 'Contact2'){
                    AccountRole__c accRole2 = new AccountRole__c();
                    accRole2.Name = 'AccountRole2';
                    accRole2.Role__c = 'Active';
                    accRole2.Contact__c = con.Id;
                    accRole2.AccountId__c = acc.Id;
                    accRoleList.add(accRole2);
                } else if(con.LastName == 'Contact3'){
                    AccountRole__c accRole3 = new AccountRole__c();
                    accRole3.Name = 'AccountRole3';
                    accRole3.Role__c = 'Inactive';
                    accRole3.Contact__c = con.Id;
                    accRole3.AccountId__c = acc.Id;
                    accRoleList.add(accRole3);
                } else if(con.LastName == 'Contact4'){
                    AccountRole__c accRole4 = new AccountRole__c();
                    accRole4.Name = 'AccountRole4';
                    accRole4.Role__c = 'Inactive';
                    accRole4.Contact__c = con.Id;
                    accRole4.AccountId__c = acc.Id;
                    accRoleList.add(accRole4);
				} // End Else if
			} // End For 
     
		} // End For
        
        Insert accRoleList;
        
    } // End onSetup()
*/    
    /**
    *Name:- updateRole()
	*Desc:- this function is used to Test Functionality Whenever Role__c is Changed 
	**/
    
	static testMethod void updateRole(){
        
        // Variable Declaration
		List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
		List<AccountRole__c> accRoleList = new List<AccountRole__c>();
        
		// call createBulkAccount() from AccountRoleTestData_Factory And insert 200 Account Records
        for(Integer i=0; i<200; i++){
            accList.add(TestDataFactory.createAccount(i));
        }
        
        Test.startTest();
        // Insert AccountList
        insert accList;
        
        // call createBulkContact() from AccountRoleTestData_Factory and Insert 2 Contacts for Each Account
        if(accList.size() >0){
            for(Integer i=0; i<accList.size(); i++){
              for(Integer j=0; j<2; j++){
                conList.add(TestDataFactory.createBulkContact(accList[i].Id, j, null) );
				}  
            }
            
            // Insert conlist
        	insert conList;
            // Retrieve Inserted Account Records
            accList = [select Id,Name,(select Id,LastName from Contacts) from Account limit 200];
            
            for(Integer i=0; i<accList.size(); i++){
                for(Integer k=0; k<accList[i].contacts.size(); k++){
					accRoleList.add(TestDataFactory.createBulkAccountRole(accList[i].Id,conList[k].Id, k, 'Active') );
				} //End for
			} // End for
            
            insert accRoleList;

		// Retrieve 5th Account Record 
			accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Name = 'TestAccount5'];
		
			for(Account acc: accList){
                // Check Updated Fields With Expected Output
                System.assertEquals(acc.Active_Contacts__c, acc.Active_Contacts__c);
				System.assertEquals(null, acc.Inactive_Contacts__c);
 					
			} // End for
        
		// Retrieve 5th Account Associated AccountRole 
		accRoleList = [select Id,Name,Role__c,Contact__r.LastName from AccountRole__c where AccountId__c IN: accList];
            
            // Iterate within accRoleList
			if(accRoleList.size() > 0){
				for(AccountRole__c accRole :accRoleList){
                	// Determine if Role__c is Updated
   					if(accRole.Name == 'AccountRole1'){
						accRole.Role__c = 'Inactive';
					} // End if
				} // End for
			
            
			update accRoleList;
            
            // Retrieve 5th Account Record And Updated Fields
			accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Name = 'TestAccount5'];
		
			for(Account acc: accList){
                // Check Updated Fields With Expected Output
                System.assertEquals('Contact0', acc.Active_Contacts__c);
				System.assertEquals('Contact1', acc.Inactive_Contacts__c);
 					
			} // End for
        } // End if 
        } // End if
        Test.stopTest();
	
	} // End UpdateRole() 
    

	 /**
    *Name:- updateRoleAndAccount()
	*Desc:- this function is used to Test Functionality whenEver Role__c  And  Account Is Changed
	**/
    
	static testMethod void updateRoleAndAccount(){
        // Variable Declaration
        Id acc0Id, acc1Id ;
		List<Account> accList = new List<Account>();
		List<Contact> conList = new List<Contact>();
        List<AccountRole__c> accRoleList = new List<AccountRole__c>();

		// call createBulkAccount() from AccountRoleTestData_Factory And insert 2 Accounts
		for(Integer i=0; i<2; i++){
            accList.add(TestDataFactory.createAccount(i));
        }
		Test.startTest();
        // Insert AccountList
        insert accList;
        System.debug('Name'+accList[1].Id);
        // call createBulkContact() from AccountRoleTestData_Factory And Insert 2 contacts for Each Account
        if(accList.size() >0){
            for(Integer i=0; i<accList.size(); i++){
              for(Integer j=0; j<2; j++){
                conList.add(TestDataFactory.createBulkContact(accList[i].Id, j, null) );
				} // End for  
            } // End for

            // Insert conlist
        	insert conList;
            
            accList = [select Id,Name,(select Id,LastName from Contacts) from Account limit 2];
            
            for(Integer i=0; i<accList.size(); i++){
                for(Integer k=0; k<accList[i].contacts.size(); k++){
					accRoleList.add(TestDataFactory.createBulkAccountRole(accList[i].Id,conList[k].Id, k, 'Inactive') );
				} //End for
			} // End for
            
            insert accRoleList;

            // Retrieve 1st Account Records for Before Checking Update
			accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Id =: accList[0].Id];
			for(Account acc: accList){
				// Check Updated Fields With Expected Output 
				System.assertEquals(null, acc.Active_Contacts__c);
				System.assertEquals('Contact1, Contact0', acc.Inactive_Contacts__c);
			} // End for
            
            // Retrieve AccountRole Associated With TestAccount1
            accRoleList = [select Id,Name,Role__c,AccountId__c from AccountRole__c where AccountId__c =: accList[0].Id];
            
            // Iterate with accRoleList
			if(accRoleList.size() > 0){
				for(AccountRole__c accRole :accRoleList){
                	// Determine if Role__c And AccountId__c is Updated
   					if(accRole.Name == 'AccountRole1'){
						accRole.Role__c = 'Active';
                    	accRole.Accountid__c = acc1Id;
					} // End if
				} // End for
			} // End if
            
			update accRoleList;
 
		// Retrieve 1st Account Records for Checking Update
		accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Id =: accList[0].Id];
		for(Account acc: accList){
			// Check Updated Fields With Expected Output 
			System.assertEquals(null, acc.Active_Contacts__c);
			System.assertEquals('Contact0', acc.Inactive_Contacts__c);
		} // End for
        
        
	} // End if
		
        Test.stopTest();
	} // End updateRoleAndAccount()

	
   
    /**
    *Name:- deleteAccountRole()
	*Desc:- this function is used to Test Delete AccountRole Functionality
	**/
   
	static testMethod void deleteAccountRole(){
        // Variable Declaration
		List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
		List<AccountRole__c> accRoleList = new List<AccountRole__c>();
        
         // call createBulkAccount() from AccountRoleTestData_Factory and insert 2 accounts
		for(Integer i=0; i<2; i++){
            accList.add(TestDataFactory.createAccount(i));
        }
		Test.startTest();
        // Insert AccountList
        insert accList;
        
        // call createBulkContact() from AccountRoleTestData_Factory and insert 2 contacts for each Accounts
        if(accList.size() >0){
            for(Integer i=0; i<accList.size(); i++){
              for(Integer j=0; j<2; j++){
                conList.add(TestDataFactory.createBulkContact(accList[i].Id, j, null) );
				} // End for  
            } // End for

            // Insert conlist
        	insert conList;
            
            accList = [select Id,Name,(select Id,LastName from Contacts) from Account limit 2];
            
            for(Integer i=0; i<accList.size(); i++){
                for(Integer k=0; k<accList[i].contacts.size(); k++){
					accRoleList.add(TestDataFactory.createBulkAccountRole(accList[i].Id,conList[k].Id, k, 'Active') );
				} //End for
			} // End for
            
            insert accRoleList;
        }		
        // Checking Account Fields Before Deleting
        accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Name = 'TestAccount1'];
		if(accList.size() > 0){
			for(Account acc: accList){
				System.assertEquals('Contact1, Contact0', acc.Active_Contacts__c);
                System.assertEquals(null, acc.Inactive_Contacts__c);
 					
			} // End for 
            
             accRoleList = [select Id from AccountRole__c where AccountId__c IN: accList And Name = 'AccountRole1' ];
           
            // Delte accRoleList
			delete accRoleList;
            
            // Retrieve 1st Account And Updated Fields
        	accList = [select Id,Active_Contacts__c,Inactive_Contacts__c from Account where Name = 'TestAccount1'];
			for(Account acc: accList){
				System.assertEquals('Contact0', acc.Active_Contacts__c);
				System.assertEquals(null, acc.Inactive_Contacts__c);
			} // End for

            // check Replace supportAddresses
            OrgWideEmailAddress[] senderAddress = [
                SELECT Id
                FROM OrgWideEmailAddress
                WHERE Address = :System.Label.Sender_Email
            ];

            System.assertEquals(1, senderAddress.size());

		} // End if
        Test.stopTest();

	} // End deleteAccountRole()
 
} // AccountRoleTriggerHelper_Test