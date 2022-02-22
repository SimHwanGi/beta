public class ltcmpapex {
    
    public ltcmpapex(){
        
    }
    public class Wrapper{
        
        @AuraEnabled public Integer index {get; set;}
        @AuraEnabled public X1__c x {get; set;}
        @AuraEnabled public boolean del{get;set;}
        
    }
    
    @AuraEnabled
    public static List<Wrapper> wrapperList(){
        List<Wrapper> wrapperList = new  List<Wrapper>();
        Integer ix = 0;
        
        for(X1__c x : [select Id , obj1no__c ,obj1txt__c ,Q1__c ,Q2__c ,Q3__c, Q4__c ,year__c
                       from  X1__c ]){
                           Wrapper w = new Wrapper();
                           w.index = ix;
                           w.del = false;
                           w.x = x;
                           wrapperList.add(w);
                           ix++;
                       }
        return wrapperList;
    }
    
    @AuraEnabled
    public static List<Wrapper> addObjwrapper(String wrapperListstr){
        
        Integer ix = 0;
        
        List<Wrapper> wrapperList = new List<Wrapper>();
        for(Wrapper w : (List<Wrapper>) JSON.deserialize(wrapperListstr, List<Wrapper>.class)){
            w.index = ix;
            wrapperList.add(w);
            ix++;
        }
        Wrapper wp = new Wrapper();
        wp.index = ix;
        wrapperList.add(wp);
        return wrapperList;
        
    }
       
    @AuraEnabled
    public static List<X1__c> ObjList(){
        List<X1__c> obj1List = new List<X1__c>();
        obj1List =  [select Id , obj1no__c ,obj1txt__c ,Q1__c ,Q2__c ,Q3__c, Q4__c , year__c
                     from  X1__c ] ;
        
        return obj1List;
    }
    
}