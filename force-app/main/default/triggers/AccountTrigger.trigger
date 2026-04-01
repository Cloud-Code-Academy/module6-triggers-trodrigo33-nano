trigger AccountTrigger on Account (before insert) {

    if (Trigger.isBefore && Trigger.isInsert){
        //check if i can put in an if condition and chain so that if trigger.new.(records in it contains )
            handlerAccount.updateToProspect(Trigger.new);
            handlerAccount.copyShippingAddress(Trigger.new);
            handlerAccount.setHotRating(Trigger.new);

        }

    /*
    * Question 3
    * Account Trigger
	* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    * Trigger should only fire on insert.
    */


    }