trigger OpportunityTrigger on Opportunity (before update) {

     if (Trigger.isBefore && Trigger.isUpdate){
        //validates to see if updated opp record has an amount greater than 5000. Throws error if false. The method allows for partial DML update using database.update();
        handlerOpportunity.amountValidation(Trigger.old, Trigger.new);
     }
    /*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
}