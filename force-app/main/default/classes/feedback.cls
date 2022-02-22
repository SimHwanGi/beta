public class feedback {
    
    public String dcId{get;set;}
    public String dcId2{get;set;}
    public String dcId3{get;set;}
    
    
    public feedback(){
        
       List<Attachment> atcm = new List<Attachment>();
        atcm = [SELECT Id FROM  Attachment WHERE Id IN('00P7F00000EG7Sy','00P7F00000EG7nR','00P7F00000EG7nb') ];
        dcId = atcm[0].Id;
        dcId2 = atcm[1].Id;
        dcId3 = atcm[2].Id;
    }
    
    public void act1(){
        return ;
    }
}