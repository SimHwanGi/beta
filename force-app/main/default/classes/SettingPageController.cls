public class SettingPageController {

    public List<Profile> profileList{get;set;}
    public List<columnProfile__c> columnProfileList{get;set;}
    public String profileId{get;set;}
    public String fields{get;set;}
    public void init(){
        profileList = [SELECT ID, Name FROM Profile];
        
    }
   public List<SelectOption> getprofile() {
        
        List<SelectOption> options = new List<SelectOption>();
        for(Profile p : profileList){
        options.add(new SelectOption(p.ID,p.Name)); 
        }
        return options;
        
    }
    public List<SelectOption> getItems() {
        
        //contact field
        Map<String, Schema.SObjectField> ObjMap = schema.SObjectType.Contact.fields.getMap();
        Set<String> nameset = new Set<String>();
        nameset = ObjMap.Keyset();
        List<SelectOption> options = new List<SelectOption>();
        for(String s : nameset){
            options.add(new SelectOption(String.valueOf(ObjMap.get(s)),s)); 
            
        }
        return options;
        
    }
    public void selectField(){
        
        columnProfileList = [SELECT ID,pId__c, profielColumn__c FROM columnProfile__c WHERE pId__c =: profileId];
        
        if(columnProfileList.isEmpty() == true){
           columnProfile__c colProfile = new columnProfile__c(pId__c = profileId, profielColumn__c = fields);
            insert colProfile;
        }else{
            columnProfileList[0].profielColumn__c = fields;
            update columnProfileList;
        }
    }
}