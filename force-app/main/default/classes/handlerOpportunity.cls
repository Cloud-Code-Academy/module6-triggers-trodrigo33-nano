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

    //Q6 - Prevents deletion if opportunity is closed won and related account industry is banking
    public static void preventDeletion (List <Opportunity> oldOpportunities){
        //Create set to collect accountIds from list of opportunities. This is to query for the related Account's field values for each opportunity in the list.
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : oldOpportunities) {
           if (opp.AccountId != null) {
            accountIds.add(opp.AccountId);
           }
            }

        //Create map to query for the Industry field. Stores both accountId and account record with queried fields.
        //Loops through each Opportunity in the list and retrieves account record from map.
        // Then use if statement for validation rule.
        Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Industry FROM Account WHERE Id IN: accountIds]);
           for ( Opportunity oppError : oldOpportunities) {
            Account acc = accountMap.get(oppError.AccountId);

            if (acc.Industry == 'Banking' && oppError.StageName == 'Closed Won') {
                oppError.addError('Cannot delete closed opportunity for a banking account that is won');
           }
        }
        //TR - We do NOT use delete here as it is a before statement. We are using the addError to PREVENT a deletion of the marked records in this context.
    }
}