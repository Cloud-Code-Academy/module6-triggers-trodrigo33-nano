//This handlerAccount is currently used by 'AccountTrigger.trigger'

public with sharing class handlerAccount {

    // Q1 handler method: Sets the inserted account field's type to Prospect if original value is null.
    // TR - Note to self, DML is not needed for before insert context as system already does this for us after the transaction is finished.
    public static void updateToProspect (List <Account> accounts) {
        for (Account acc : accounts) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }
    }

    // Q2 handler method: Sets the inserted account's Billing address field values WITH Shipping Address value if Billing address is null and Shipping address is not null.
    public static void copyShippingAddress (List <Account> accounts) {
        for (Account acc : accounts) {
            if (billingFieldsBlank(acc) && shippingFieldsNotBlank(acc)) 
                {
                    acc.BillingCity = acc.ShippingCity;
                    acc.BillingCountry =  acc.ShippingCountry; 
                    acc.BillingPostalCode = acc.ShippingPostalCode;
                    acc.BillingState = acc.ShippingState;
                    acc.BillingStreet = acc.ShippingStreet;
            }
        }
    }
    
    // Q2 HELPERS
    //return true if account billing fields are null
    public static Boolean billingFieldsBlank (Account acc) {
        return (acc.BillingStreet == null && acc.BillingCity == null && acc.BillingState == null && acc.BillingPostalCode == null && acc.BillingCountry == null);
    }
    
     //return true if account shipping fields are not null
    public static Boolean shippingFieldsNotBlank (Account acc) {
        return (acc.ShippingStreet != null || acc.ShippingCity != null || acc.ShippingState != null || acc.ShippingPostalCode != null || acc.ShippingCountry != null);
    }

    // Q3 handler method: Sets the inserted account's rating to Hot if the phone, website, and fax field are populated.
     public static void setHotRating (List <Account> accounts) {
        for (Account acc : accounts) {
            if (setToHotRating(acc)) {
                acc.Rating = 'Hot';
            }
        }
     }

     // Q3 HELPER - return true if phone, webiste, fax are not null.
     public static Boolean setToHotRating (Account acc){
        return (acc.Phone != null && acc.Website != null && acc.Fax != null);
     }
     
     // Q4 Handler method - when an account is inserted, creates a contact record related to account fields. Contact record to hold default values.
     public static void createContact (List <Account> accounts) {
        List <Contact> newContacts = new List<Contact>();
        for (Account acc : accounts) {
            Contact con = new Contact(AccountId = acc.Id);
            con.LastName = 'DefaultContact';
            con.Email = 'default@email.com';
            newContacts.add(con);
        }
        insert newContacts;
       }
}