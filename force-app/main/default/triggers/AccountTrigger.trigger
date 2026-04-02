trigger AccountTrigger on Account (before insert, after insert) {
    //TR - Before Insert
    if (Trigger.isBefore && Trigger.isInsert){
            handlerAccount.updateToProspect(Trigger.new);
            handlerAccount.copyShippingAddress(Trigger.new);
            handlerAccount.setHotRating(Trigger.new);
        }

    // TR - After Insert
    if (Trigger.isAfter && Trigger.isInsert){
        handlerAccount.createContact(Trigger.new);
    }
}