/**
    *Name:- accountRoleTrigger Trigger
	*Desc:- this Trigger is used to create  Updating Account field functionality
	**/
trigger AccountRoleTrigger on AccountRole__c (after insert, after update, after delete) {
	// Assign New AccountRole List into newAccountRoleList
	AccountRoleTriggerHelper.newAccountRoleList = trigger.new;
    // Assign New AccountRole List into oldAccountRoleList
	AccountRoleTriggerHelper.oldAccountRoleList = trigger.old;
    // Assign New AccountRole List into newAccountRoleMap
    AccountRoleTriggerHelper.newAccountRoleMap = trigger.newMap;
    // Assign New AccountRole List into oldAccountRoleMap
    AccountRoleTriggerHelper.oldAccountRoleMap = trigger.oldMap;
    
    if( AccountRoleTriggerHelper.runTrigger ){
        if( trigger.isAfter ){
            if( trigger.isInsert || trigger.isUpdate || trigger.isDelete){
                // Run updateAccountField() function on After Insert or After Update Event
                AccountRoleTriggerHelper.updateAccountField();
            } // End if
        } // End If
    } // End If
} // End AccountRoleTrigger