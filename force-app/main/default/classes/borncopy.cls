public class borncopy {
    public String accountfield{get;set;} 
    public Account act{get;set;}
    public PageReference start(){
      
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Account.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        accountfield = '';
        fldObjMap = schema.SObjectType.Account.fields.getMap();
            fldObjMapValues = fldObjMap.values();
            for(Schema.SObjectField s : fldObjMapValues){
                accountfield+=s.getDescribe().getName()+',';
            }
            accountfield = accountfield.removeEnd(',');
        
        String account_id = ApexPages.currentPage().getParameters().get('acids');
        List<String> account_ids = EncodingUtil.urlDecode(account_id, 'utf-8').split(','); 
        List<AccountCopy__c> accp_list = new List<AccountCopy__c>();
        for(Integer i = 0; account_ids.size() > i ; i ++){
            AccountCopy__c acpy = new AccountCopy__c();
            List<Account> actli = (List<Account>)Database.query('SELECT '+ accountfield +' FROM Account WHERE Id = \'' + account_ids[i] +'\'' );
        	acpy.Account__c = account_ids[i];
            acpy.Name= actli[0].Name;
            acpy.Owner__c= actli[0].Owner__c;
            accp_list.add(acpy);
			upsert accp_list;
            system.debug(actli);
        }
        return new PageReference('/001');
        
    }
	
    /*
    public PageReference start(){
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Account.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        accountfield = '';
        fldObjMap = schema.SObjectType.Account.fields.getMap();
            fldObjMapValues = fldObjMap.values();
            for(Schema.SObjectField s : fldObjMapValues){
                accountfield+=s.getDescribe().getName()+',';
            }
            accountfield = accountfield.removeEnd(',');
       String account_id = ApexPages.currentPage().getParameters().get('acids');
        List<String> account_ids = EncodingUtil.urlDecode(account_id, 'utf-8').split(','); 
        List<AccountCopy__c> accp_list = new List<AccountCopy__c>();
        for(Integer i = 0; account_ids.size() > i ; i ++){
            AccountCopy__c acpy = new AccountCopy__c();
            List<Account> actli = (List<Account>)Database.query('SELECT '+ accountfield +' FROM Account WHERE Id = \'' + account_ids[i] +'\'' );
          	
            accp_list.add(actli.clone());
            upsert accp_list;
        }
        
        
		return null;        
    }
     */
}