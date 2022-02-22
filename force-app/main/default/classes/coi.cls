public class coi {
    
    public Boolean isTrue{get;set;}
    public Boolean isSave{get;set;}
    public Boolean isCheck{get;set;}
    public String inp1{get;set;}
    public coi(){
        isSave = false;
        isCheck = false;
    }
    public void doSave(){
        valChk();
    }
    
    public void valChk(){
        
        isTrue= true;
    }
    
    
    public void doSave2(){
        isSave = true;
        
        anoFunc();
        
    }
    public void anoFunc(){
        if(inp1 != 'no') isCheck = true;
    }
    
    
    
}