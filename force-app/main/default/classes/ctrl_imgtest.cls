public class ctrl_imgtest {

    
    public Contact contact{get;set;}
    public ctrl_imgtest(ApexPages.StandardController controller){}
    
    public void init(){
        
     contact = (Contact)Database.query('SELECT CompanyLogo__c FROM Contact WHERE ID = \'0037F00000CTQQt\'');
    
    }
}