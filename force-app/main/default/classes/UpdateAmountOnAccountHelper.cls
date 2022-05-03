/**
    *Name		:- UpdateAmountOnAccountHelper class
	*CreatedBy	:- Bheru gadri
	*CreatedDate:- 31/05/2021
	*Desc		:- this is a Helper class for UpdateAmountOnAccount trigger where we create Update Total_Amount__c field on Account 
**/
public class UpdateAmountOnAccountHelper {
    public static Boolean runTrigger = true ; // Usually this should be store as custom metadata
    public static List<Contact> newContactList = new List<Contact>();
    public static List<Contact> oldContactList = new List<Contact>();
    public static Map<Id, Contact> newContactMap = new Map<Id, Contact>();
    public static Map<Id, Contact> oldContactMap = new Map<Id, Contact>();

    /**
    *Name:- updateAmountOnAccount()
	*Desc:- this function is used to create update Account Total_Amouunt field Based on Related COntact Amount field 
	**/
	public static void updateAmountOnAccount(){
        
		// Variable Declaration
		Set<Id> accIds = new Set<Id>();
		List<Account> accList = new List<Account>();
    	List<Contact> conlist = new List<Contact>();

		// Check if isInsert , isUpdate OR isUndelete Events are Invoked
		if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
			// Iterate within New Contact List
			for(Contact con : newContactList){
				if(trigger.isInsert && con.AccountId != null){
					accIds.add(con.AccountId);
				}else if(trigger.isUpdate){
					if(con.Amount__c != oldContactMap.get(con.Id).Amount__c && con.AccountId != null){
						accIds.add(con.AccountId);
					}
					if(con.AccountId != oldContactMap.get(con.Id).AccountId ){
                    	// add old AccountId
						accIds.add(oldContactMap.get(con.Id).AccountId);
                    	//add new AccountId
                   	 	accIds.add(con.AccountId);
					} // End If 
				} else if(trigger.isUndelete){
					if(con.AccountId != null){
						accIds.add(con.AccountId);
					}
				} // End ELse If
			} // End For
		} // End If
            
		// Check if isDelete Event Invoked
		if(trigger.isDelete){
			// Iterate Within Old Contact List
			for(Contact con : oldContactList){
				if(con.AccountId != null){
					accIds.add(con.AccountId);
				}
			} // End for
		} // End if
            
		// Check Total used SOQl Query to avoid hitting a governor Limit
		if(accIds.size() >0 && Limits.getQueries() < Limits.getLimitQueries()){
			accList = [select Id,Total_Amount__c,(select Id,Amount__c from Contacts) from Account where Id IN: accIds];
        
			// Check Total Retrieved Record by SOQl Query to avoid hitting a governor Limit
			if(accList.size() >0 && Limits.getQueryRows() < Limits.getLimitQueryRows()){
            
				for(Account acc : accList){
					Decimal countTotal = 0;
					for(Contact con: acc.contacts){
                    	if(con.Amount__c != null){
                        	countTotal += con.Amount__c;
                    	}
					
					} // End For
                
					acc.Total_Amount__c = countTotal;
				} // End for
        	}// End if
			// Check Total used DML Statements to avoid hitting a governor Limit 
			if(accList.size() > 0 && Limits.getDmlStatements() < Limits.getLimitDmlStatements()){
				update accList;
			} // End if
		
		}// End if
        
    } // End updateAmountOnAccount()
}