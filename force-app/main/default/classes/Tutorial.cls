public class Tutorial {
    
    public List<Account> actList{get;set;}
    public List<Contact> ctList{get;set;}
    public List<myClass> myClassList{get;set;}
    public myClass myCls{get;set;}
    public Integer no{get;set;}
    public void init(){
        no = 0;
        myCls = new myClass();
        myCls.str1 = 'a';
        myCls.str2 = 'b';
        myCls.str3 = 'c';
        myClassList = new List<myClass>();
        myClassList.add(myCls);
        
        actList = [SELECT ID FROM Account];
        ctList = [SELECT ID FROM Contact];
        
    }
    public void plus(){
        myCls = new myClass();
        myClassList.add(myCls);
    }
    public void del(){
        system.debug(Integer.valueOf(ApexPages.currentPage().getParameters().get('recindex')));
        
        
    }
    public class myClass{
        public String str1{get;set;}        
        public String str2{get;set;}        
        public String str3{get;set;}        
        
    }
}