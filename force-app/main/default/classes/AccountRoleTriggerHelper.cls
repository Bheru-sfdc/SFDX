/**
    *Name:- accountRoleTriggerHelper class
	*Desc:- this is a Helper class for accountRoleTrigger where we create updateAccountField() functionality
**/
public class AccountRoleTriggerHelper {
 	public static Boolean runTrigger = true ; // Usually this should be store as custom metadata
    public static List<AccountRole__c> newAccountRoleList = new List<AccountRole__c>();
    public static List<AccountRole__c> oldAccountRoleList = new List<AccountRole__c>();
    public static Map<Id, AccountRole__c> newAccountRoleMap = new Map<Id, AccountRole__c>();
    public static Map<Id, AccountRole__c> oldAccountRoleMap = new Map<Id, AccountRole__c>();
    
    /**
    *Name:- updateAccountField()
	*Desc:- this function is used to create update Active_contacts and Inactive_Contacts field on Account Object functionality
	**/
        public static void updateAccountField(){
            // Variable Declaration
            Set<Id> accIds = new Set<Id>();
            Set<Id> oldAccIds = new Set<Id>();
            List<Account> accList = new List<Account>();
            List<Account> oldAccList = new List<Account>();
            
            // Check if isInsert OR isUpdate Events are Invoked
            if(trigger.isInsert || trigger.isUpdate){
                // Iterate within New AccountRole List
				for(AccountRole__c acc : newAccountRoleList){
                	if(trigger.isInsert){
                     	accIds.add(acc.AccountId__c);
                	}else if(trigger.isUpdate){
                    	if(acc.Role__c != oldAccountRoleMap.get(acc.Id).Role__c || acc.Contact__c != oldAccountRoleMap.get(acc.Id).Contact__c){
                        	accIds.add(acc.AccountId__c);
						}
                    	if(acc.AccountId__c != oldAccountRoleMap.get(acc.Id).AccountId__c){
							accIds.add(oldAccountRoleMap.get(acc.Id).AccountId__c);
                            
						} // End If 
					} // End Elseif
				} // End For
			} // End If
            
            // Check if isDelete Event Invoked
            if(trigger.isDelete){
                // Iterate Within Old AccountRole List
           		for(AccountRole__c accRole : oldAccountRoleList){
					accIds.add(accRole.AccountId__c);
				} // End for
			} // End if
            
            // Check Total used SOQl Query to avoid hitting a governor Limit
            if(accIds.size() >0 && Limits.getQueries() < Limits.getLimitQueries()){
                accList = [select Id,Active_Contacts__c,Inactive_Contacts__c,(select Id,Role__c,Contact__r.Name from AccountRoles__r) from Account where Id IN: accIds];
                
                // Check Total Retrieved Record by SOQl Query to avoid hitting a governor Limit
                if(accList.size() >0 && Limits.getQueryRows() < Limits.getLimitQueryRows()){
                    for(Account acc : accList){
                        // Populate Active_Contacts__c And Inactive_Contacts__c With Null
                        acc.Active_Contacts__c='';
                        acc.Inactive_Contacts__c='';
                        for(AccountRole__c accRole : acc.AccountRoles__r){
                            if(accRole.Role__c == 'Active'){
                                acc.Active_Contacts__c += accRole.Contact__r.Name +', ';
                              
                            }else if(accRole.Role__c == 'Inactive'){
                                acc.Inactive_Contacts__c += accRole.Contact__r.Name+', ';
                            } // End Elseif
                        } // End if
                        
                        if(acc.Active_Contacts__c.length() > 0){
                            acc.Active_Contacts__c = acc.Active_Contacts__c.subString(0,acc.Active_Contacts__c.length()-2);
                        } // End if
                        
                        if(acc.Inactive_Contacts__c.length() > 0){
                            acc.Inactive_Contacts__c = acc.Inactive_Contacts__c.subString(0,acc.Inactive_Contacts__c.length()-2);
                        } // End if
						
                    } // End For
                    
                    // Check Total used DML Statements to avoid hitting a governor Limit 
                    if(accList.size() > 0 && Limits.getDmlStatements() < Limits.getLimitDmlStatements()){
                        Update accList;
					} // End if
                    
                } // End if
            } // End if
            
        } // End updateAccountField()
   
    } // End AccountRoleTriggerHelper