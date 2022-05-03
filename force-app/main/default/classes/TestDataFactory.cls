/**
    *Name:- TestDataFactory class
	*Desc:- this is a class where we create Test data for Test Classes
**/
public class TestDataFactory {
    
    /**
    *Name	:- createBulkAccount()
	@Params	:- Integer numOfCount (Total Number of Counts)
	@return :- List<Account> (return the List of Accounts)
	*Desc	:- this function is used to create Bulk Account records
	**/
	public static Account createAccount(Integer num){
        Account Acc = new Account(Name = 'TestAccount'+num);
        
		// Return acclist
        return Acc;
    } // End createAccount()
    
    /**
    *Name	:- createBulkContact()
	@Params	:- List<Account> accList (List of Accounts) And Integer numOfCount (Total Number of Counts)
	@Return :- List<Contact> (return the List of Contacts)
	*Desc	:- this function is used to create 4 contacts for Each Account Records
	**/
	public static Contact createBulkContact(Id accId, Integer num,Integer Amount){
        
		Contact con = new Contact(LastName = 'Contact'+num, AccountId = accId, Amount__c= Amount);
        // Return conList
         return con;
     
    } // End createBulkContact()
    
    /**
    *Name	:- createBulkAccountRole()
	@Params	:- List<Account> accList (List of Accounts Associated with Contacts) And Integer numOfCount (Total Number of Counts)
	@Return :- List<AccountRole__c> (return the List of AccountRoles)
	*Desc	:- this function is used to create 2 AccountRoles for Each Account Records
	**/
    public static AccountRole__c createBulkAccountRole(Id accId,Id conId, Integer num, String roleVal){
        
       AccountRole__c accRole = new AccountRole__c(Name = 'AccountRole'+num, Role__c = roleVal,
                                                                 Contact__c = conId, AccountId__c = accId );

        //Return accRoleList
        return accRole;
        
    } // End createBulkAccountRole()

} // End AccountRoleTestData_Factory