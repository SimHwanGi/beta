public class ViewPageController {
    public Id proID{get;set;}
    public List<columnProfile__c> columnProfileList{get;set;}
    public List<Contact> contactList{get;set;}
    public List<String> proColumList{get;set;}
    public void init(){
        
        proID = UserInfo.getProfileId();
        columnProfileList = [SELECT ID,pId__c, profielColumn__c FROM columnProfile__c WHERE pId__c =: proID];
        if(columnProfileList.isEmpty()==true){
            columnProfileList = [SELECT ID,pId__c, profielColumn__c FROM columnProfile__c WHERE Name ='defalt'];
        }
     	contactList = (List<Contact>)Database.query('SELECT '+ field('Contact') +' FROM Contact');
        system.debug(schema.SObjectType.Contact.fields.getMap());
        system.debug(schema.SObjectType.Contact.fields);
        system.debug(schema.SObjectType.Contact);
        
        
    }
   
    
    public List<String> getFields(){
        
        List<String> proColumList = new List<String>();
        String proColum = columnProfileList[0].profielColumn__c;
        proColum =  proColum.removeStart('[');
        proColum = proColum.removeEnd(']');
        proColumList = proColum.split(', ');
        system.debug(proColumList);
        List<String> fieldlist = new List<String>();
        fieldlist.addAll(proColumList);
        return fieldlist;
    }  
    public String field(String obj){ 
        String fields = '';
        SObjectType objType = Schema.getGlobalDescribe().get(obj);
        Map<String,Schema.SObjectField> fldObjMap = objType.getDescribe().fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        fields = '';
            fldObjMapValues = fldObjMap.values();
            for(Schema.SObjectField s : fldObjMapValues){
                fields+=s.getDescribe().getName()+',';
            }
            fields = fields.removeEnd(',');
        return fields;
        
    }
    
    
}