public class fieldclass {
    public List<ob> oblist{get;set;}
    public void init(){
     
        oblist = new List<ob>();
        ob ob1 = new ob();
        ob1.a = 0;
        ob1.b = 1;
        oblist.add(ob1);
        oblist.add(ob1);
        oblist.add(ob1);
        oblist.add(ob1);
        oblist.add(ob1);oblist.add(ob1);oblist.add(ob1);
        oblist.add(ob1);
        oblist.add(ob1);oblist.add(ob1);
        oblist.add(ob1);
        
        
    }
    
    public class ob{
        public Decimal a {get;set;}
        public Decimal b {get;set;}
        public Decimal c {get;set;}
        
    }
}