trigger OpportunityTrigger on Opportunity (before update, before delete) {

    // TR - Before Update
    if (Trigger.isBefore && Trigger.isUpdate){
        //validates to see if updated opp record has an amount greater than 5000. Throws error if false. The method allows for partial DML update using database.update();
        handlerOpportunity.amountValidation(Trigger.old, Trigger.new);
        handlerOpportunity.updatePrimaryContact(Trigger.new);
     }

    // TR - Before Delete
     if (Trigger.isBefore && Trigger.isDelete) {
        //Prevents deletion of closed won opp if account industy is 'Banking'
        handlerOpportunity.preventDeletion(Trigger.old);
     }
}
     /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */