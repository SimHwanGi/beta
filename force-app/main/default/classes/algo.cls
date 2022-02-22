public class algo{
    public String jsondata{get;set;}
    public List<contents> cts{get;set;}
    public contents c{get;set;}
    public void main(){
        contents cts1 =  new contents();
        cts1.a = 'gg';
        cts1.b = 'gas';
     
        jsondata = JSON.serialize(cts1);
        
        contents c = (contents) JSON.deserialize(jsondata,contents.class);
        system.debug(c);
        
    }
    public class contents{
        public String a{get;set;}
        public String b{get;set;}
        
       
    }
}