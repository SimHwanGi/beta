public class numtest {
    
    public String num{get;set;}
    public Account ac{get;set;}
    public String nowdate{get;set;}
    public void main(){
        
        ac = [SELECT Id , phone__c FROM Account WHERE id ='0017F00000Rjn2E'];
        num = ac.phone__c;
        nowdate = String.valueOf(system.now().millisecond());
        
        
    }
}