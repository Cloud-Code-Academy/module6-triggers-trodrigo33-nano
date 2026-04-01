trigger OpportunityTrigger on Opportunity (before update, before delete) {

    // TR - Before Update
    if (Trigger.isBefore && Trigger.isUpdate){
        handlerOpportunity.amountValidation(Trigger.old, Trigger.new);
        handlerOpportunity.updatePrimaryContact(Trigger.new);
     }

    // TR - Before Delete
     if (Trigger.isBefore && Trigger.isDelete) {
        handlerOpportunity.preventDeletion(Trigger.old);
     }
}
