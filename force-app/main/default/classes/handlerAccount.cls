public with sharing class handlerAccount {

    // TR - Q1 handler
    // TR - Note to self, DML is not needed for before insert context as system already does this for us after the transaction is finished.
    public static void updateToProspect (List <Account> accounts) {
        for (Account acc : accounts) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }
    }

    // TR - Q2 handler
    // 
}