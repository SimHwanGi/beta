public class Objectapi {
    public  String truck_fields{get;set;}
    public void main(){
            Map<String, Schema.SObjectField> TruckObjMap = schema.SObjectType.TEST__c.fields.getMap();
            List<Schema.SObjectField> TruckObjMapValues = TruckObjMap.values();
            for(Schema.SObjectField s : TruckObjMapValues){
                truck_fields+=s.getDescribe().getName()+',';
            }
          truck_fields = truck_fields.removeEnd(',');
            
        system.debug(truck_fields);
    }
        
            
}