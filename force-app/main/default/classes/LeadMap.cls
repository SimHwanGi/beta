public class LeadMap {
    public Lead leads{get;set;}
    public String str{get;set;}
    public LeadMap (){
        leads = [
        SELECT Id, Street
        FROM Lead 
        WHERE Id =
            :ApexPages.currentPage().getParameters().get('id')
   		];
        str = leads.Street;
        
    }
}