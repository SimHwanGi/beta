public class ctrl_Multi 
{
    public MR__c del;
    public List<MR__c> mrrecord {get;set;}
    public List<MR__c> addmr{get;set;}
    public List<MR__c> delmrs{get;set;}
    public List<MR__c> delmr{get;set;}
    public Integer total {get;set;}
    public Integer rowIndex {get;set;}
  
    public ctrl_Multi( ){
         mrrecord = [SELECT Name, Text__c, Number__c, Date__c FROM MR__c ORDER BY Name ];
         total = mrrecord.size();
         delmrs = new List<MR__c> ();
         delmr = new List<MR__c> ();
       
    }
    public PageReference save(){
        upsert mrrecord;
        delete delmrs;
        PageReference pageRef = new PageReference('https://ap5.salesforce.com/a07/o');
        return pageRef;
    }
    public void plus(){
        addmr = new List<MR__c>();
        mrrecord.add(new MR__c());
        
    }
    public void del(){
            rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex')); 
        
            del = mrrecord.remove(rowIndex);
            delmrs.add(del);
    }
    
}