public class sl {
    public wanggi__c w {get;set;}
    public String wgId;
    public void init(){
        wgId = ApexPages.currentPage().getParameters().get('wgId');
        w = [SELECT ID, Name__c FROM wanggi__c WHERE ID =: wgId];
        
    }
        
        
}