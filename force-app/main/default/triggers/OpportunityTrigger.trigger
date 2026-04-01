trigger OpportunityTrigger on Opportunity (before update, before delete) {

    // TR - Before Update
    if (Trigger.isBefore && Trigger.isUpdate){
        //validates to see if updated opp record has an amount greater than 5000. Throws error if false. The method allows for partial DML update using database.update();
        handlerOpportunity.amountValidation(Trigger.old, Trigger.new);
     }

    // TR - Before Delete
     if (Trigger.isBefore && Trigger.isDelete) {
        //Prevents deletion of closed won opp if account industy is 'Banking'
        handlerOpportunity.preventDeletion(Trigger.old);
     }
    }
