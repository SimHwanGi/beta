public class ctrl_site {
    public String category{get;set;}
    public String actId{get;set;}
    public String testStr{get;set;}
    public void main(){
        
    }
    public void send(){
        actId = ApexPages.currentPage().getParameters().get('id');
        List<Account> actList = new List<Account>();
        actList = [SELECT ID, Owner__c FROM Account WHERE ID =:actId Limit 1];
        actList[0].Owner__c = testStr;
        system.debug(testStr);
        upsert actList;
        
    }
    public List<SelectOption> getMenu(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('EXCHANGE','교환'));
        options.add(new SelectOption('RETURN','반품'));
        return options;
    }
}