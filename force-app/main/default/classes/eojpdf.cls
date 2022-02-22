public class eojpdf {

    
    public ApexPages.StandardController ap;
    public string reason{get;set;}
    public eojpdf( ApexPages.StandardController ap){
        this.ap = ap;
    }
   
    public student__c st{get;set;}
    public void init(){
        String stId   = ApexPages.currentPage().getParameters().get('Id');
        List<student__c> stList = new List<student__c>();
        stList = [SELECT  Id, name , grade__c, class__c, reason__c FROM  student__c WHERE Id= : stId limit 1];
        st = stList[0];
    }
    
    public void save(){
       
        st.reason__c = reason;
        update st;
        
    }
}