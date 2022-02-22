public without sharing class owd {
    public List<wanggi__c> wList{get;set;}
    public date beforedate{get;set;}
    public owd(){
        Datetime beforedatetime  = system.now();
        
		beforedate         = system.today().addDays(-14);
        
        //wList = [SELECT Id, update__c, onlydate__c FROM wanggi__c WHERE onlydate__c >=: beforedate AND onlydate__c <=: system.today() ];
        wList = Database.query('SELECT Id, update__c, onlydate__c FROM wanggi__c WHERE onlydate__c >=: beforedate AND onlydate__c <= TODAY');
            
    }
    
    
}