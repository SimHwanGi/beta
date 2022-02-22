trigger tri_make on MakeObj__c (After insert) {
    
    List<X1__c> obj1List = new List<X1__c>();
    List<X2__c> obj2List = new List<X2__c>();
    List<X3__c> obj3List = new List<X3__c>();
    
    for(MakeObj__c mo : Trigger.new){
        X1__c obj1 = new X1__c();
        obj1.Name = mo.obj1name__c;
        obj1.obj1no__c = mo.obj1no__c;
        obj1.obj1txt__c = mo.obj1txt__c;
        
        obj1List.add(obj1);
        
    }
    insert obj1List;
    system.debug(obj1List);
    
    Integer i = 0;
    for(MakeObj__c mo : Trigger.new){
        
        X2__c obj2 = new X2__c();
        obj2.Name = mo.obj2name__c;
        obj2.obj1__c = obj1List[i].Id;
        obj2List.add(obj2);
        i++;
        
    }
    insert obj2List;
    Integer ii = 0;
    for(MakeObj__c mo : Trigger.new){
        
        X3__c obj3 = new X3__c();
        obj3.Name = mo.obj3name__c;
        obj3.obj2__c = obj2List[ii].Id;   
        obj3.obj3date__c = system.today();
        obj3List.add(obj3);
        ii++;
        
    }
    insert obj3List;
    
}