public class coi2 {

    public String returnId{get;set;}
    
    public coi2(){
        returnId = ApexPages.currentPage().getParameters().get('Id');
        
    }
}