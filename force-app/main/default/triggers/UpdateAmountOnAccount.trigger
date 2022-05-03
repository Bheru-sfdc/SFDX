/**
    *Name:- UpdateAmountOnAccount Trigger
	*Desc:- this Trigger is used to create Update Account Total_Amouunt field Based on Related COntact Amount field
	**/
trigger UpdateAmountOnAccount on Contact (after insert, after update, after delete, after undelete) {
    
    // Assign New Contact List into newContactList
	UpdateAmountOnAccountHelper.newContactList = trigger.new;
    // Assign old Contact List into oldContactList
	UpdateAmountOnAccountHelper.oldContactList = trigger.old;
    // Assign NewMap Contact  into newContactMap
    UpdateAmountOnAccountHelper.newContactMap = trigger.newMap;
    // Assign oldMap Contact  into oldContactMap
    UpdateAmountOnAccountHelper.oldContactMap = trigger.oldMap;
    
    if( UpdateAmountOnAccountHelper.runTrigger ){
        if( trigger.isAfter ){
            if( trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete){
                // Run updateAmountOnAccount() function on After Insert ,After Update, After Delete and After Undelete Event
                UpdateAmountOnAccountHelper.updateAmountOnAccount();
            } // End if
        } // End If
    } // End If
} // End UpdateAmountOnAccount