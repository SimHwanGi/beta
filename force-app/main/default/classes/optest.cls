public class optest {

    public Opportunity op{get;set;}
    public void main(){
        op = [SELECT ID, aaaa__c, bano__c, dddd__c FROM Opportunity WHERE ID= '0067F00000Hq0XV' ];
                
    }
}