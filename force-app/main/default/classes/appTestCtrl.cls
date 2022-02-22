public with sharing class appTestCtrl {

    @AuraEnabled
    public static List<wanggi__c >  wanggiobj(){
        List<wanggi__c> wgList = new List<wanggi__c>();
        wgList = [SELECT Id, email__c, Name__c, password__c, mani__c, 
                  Names__c, engName__c, weight__c, update__c, onlydate__c 
                  from wanggi__c ];
        
        return wgList;
    }
    
    @AuraEnabled
    public static String echoStr(){
        return 'Hi';
        
    }
    
    @AuraEnabled
    public static String varString(String varStr){
        return 'Get var String : ' + varStr;
    }
    
}