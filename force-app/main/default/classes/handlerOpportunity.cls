public with sharing class handlerOpportunity {
    //Q5 - Validates amount on an updated opportunity record; checks is greater than 5000.
    public static void amountValidation (List <Opportunity> oldOpportunities, List <Opportunity> newOpportunities) {
        for (Integer i = 0; i < newOpportunities.size(); i++) {
            Opportunity oldOpp = oldOpportunities.get(i);
            Opportunity newOpp = newOpportunities.get(i);
            
            if (oldOpp.Amount != newOpp.Amount && newOpp.Amount <= 5000) {
                newOpp.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }
        // TR - We do NOT use DML because we are in a before trigger. Because we are in this context, the records are already being saved. Adding in a DML here would 
        // create a recursion.
    }
}