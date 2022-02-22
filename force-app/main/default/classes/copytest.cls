public class copytest {
    
    public List<item> itemList{get;set;}
    public class item{
        public String str1{get;set;}
        public String str2{get;set;}
        public String str3{get;set;}
    }
    
    public copytest(){
        itemList =  new List<item>();
        Integer i  = 0;
        item it = new item();
        while(i < 10){
            it.str1 = 'str1 : ' + i;
            it.str2 = 'str2 : ' + i;
            itemList.add(it.clone());
            
            i++;
        }
        
    }
}