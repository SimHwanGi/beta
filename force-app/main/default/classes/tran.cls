public class tran {
    
    DateTime t1;
    transient DateTime t2;
    
    public String getT1() {
        if (t1 == null) t1 = System.now();
        return '' + t1;
    }
    
    public String getT2() {
        if (t2 == null) t2 = System.now();
        return '' + t2;
    }
    public Opportunity op{
        get{
          return [SELECT Id, Name FROM Opportunity LIMIT 1];
         }
        set;
            }
}