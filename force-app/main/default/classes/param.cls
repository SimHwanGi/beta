public class param {
    
    public List<Wrapper> wpList {get;set;}
    public class Wrapper{
        public String a{get;set;}
        public String b{get;set;}
        public String c{get;set;}
    }
    public void main(){
        wpList = new List<Wrapper>();
        Wrapper wp = new Wrapper();
        for(Integer i = 0; i < 10 ; i ++){
            
            wp.a = 'asd'+ String.valueOf(i) ;
            wp.b = 'azcx' + String.valueOf(i);
            wp.c = 'azcx' + String.valueOf(i);
            wpList.add(wp.clone());    
        }
        
        List<Account> acList = new List<Account>();
        acList = [SELECT  ID, (SELECT LastName , FirstName FROM Contacts ) FROM Account];
        for(Account ac : acList){
            system.debug('ac' + ac);   
            for(Contact ct : ac.Contacts){
                system.debug('ct'+ ct);
            }
        }
        
        
    }
    public void delBtn(){
        String key = ApexPages.currentPage().getParameters().get('paramId');
        system.debug('key' + key);
    }
}