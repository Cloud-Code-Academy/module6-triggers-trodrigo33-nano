public with sharing class handlerOpportunity {
    //Q5 - Validates amount on an updated opportunity record; checks is greater than 5000.
        // TR - We do NOT use DML because we are in a before trigger. Because we are in this context, the records are already being saved. Adding in a DML here would 
        // create a recursion.
    public static void amountValidation (List <Opportunity> newOpportunities) {
        for (Opportunity newOpp : newOpportunities ) {
            if (newOpp.Amount <= 5000) {
                newOpp.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    //Q6 Prevents deletion if opportunity is closed won and related account industry is banking
        //Create set to collect accountIds from list of opportunities. This is to query for the related Account's field values for each opportunity in the list.
        //Create map to query for the Industry field. Stores both accountId and account record with queried fields.
        //Loops through each Opportunity in the list and retrieves account record from map.
        // Then use if statement for validation rule
        //TR - We do NOT use delete here as it is a before statement. We are using the addError to PREVENT a deletion of the marked records in this context.
        // FIX
    public static void preventDeletion (List <Opportunity> oldOpportunities){
        Set<Id> accountIds = new Set<Id>(accountIdSet(oldOpportunities));
        Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Industry FROM Account WHERE Id IN :accountIds]);
           for ( Opportunity oppError : oldOpportunities) {
            Account acc = accountMap.get(oppError.AccountId);
            if (acc.Industry == 'Banking' && oppError.StageName == 'Closed Won') {
                oppError.addError('Cannot delete closed opportunity for a banking account that is won');
           }
        }
    }

    //Q7 - Update opportunity Primary contact with the contact who's contact.Role = CEO && that belongs to the same account the opportunity is related to.
    // TR - This only assumes we can have one CEO per account.
            //get contact that has same account as Opportunity and role is CE0
            //create Map for mapping accountId with Contact record (using above list)
            //create Map for mapping accountId with Contact record (using above list)
            //loop to update primary contact
    public static void updatePrimaryContact (List<Opportunity> newOpportunities){
        Set<Id> accountIds = accountIdSet(newOpportunities);
        List <Contact> contactList = ([
            SELECT Id, AccountId 
            FROM Contact 
            WHERE Title = 'CEO' 
            AND AccountId IN :accountIds]);
        
        Map <Id, Contact> conCEO = new Map<Id, Contact>();
        for (Contact con : contactList) {
            conCEO.put(con.AccountId, con);
        }

        for (Opportunity opp : newOpportunities) {
            if (conCEO.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = conCEO.get(opp.AccountId).Id;
            }
    }
}

    //Q6 and Q7 Helper class: creates accountId set for query.
    public static Set<Id> accountIdSet (List <Opportunity> Opportunities){
        Set<Id> accountIds = new Set<Id>();
            for (Opportunity opp : Opportunities) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        return accountIds;
    }
}
