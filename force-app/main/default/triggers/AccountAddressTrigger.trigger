trigger AccountAddressTrigger on Account (before insert,before update) {
    
    for(Integer i  = 0 ; i < trigger.new.size() ;i++){
        
        if(trigger.new[i].Match_Billing_Address__c == true){
            trigger.new[i].ShippingPostalCode = trigger.new[i].BillingPostalCode;
        }
        
    }
}