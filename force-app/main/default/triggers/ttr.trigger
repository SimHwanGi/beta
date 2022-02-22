trigger ttr on TEST__c (before update) {
    
    
    for(TEST__c t : trigger.new) {
        t.zipno__c ='a';
    }
    
    
    
}