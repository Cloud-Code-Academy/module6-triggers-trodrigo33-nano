trigger AccountTrigger on Account (before insert) {

    if (Trigger.isBefore && Trigger.isInsert){
            handlerAccount.updateToProspect(Trigger.new);
        }
    }