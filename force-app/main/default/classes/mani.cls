global  without sharing class mani {
    
    public List<wanggi__c> wanggiList{get;set;}
    public String msg{get;set;}
    public Boolean setMani {get;set;}
    public String pageEmail{get;set;}
    public String pageName{get;set;}
    public wanggi__c createwang{get;set;}
    public mani(){
        setMani = false;
        msg = '';
        
        wanggiList = [SELECT Id, mani__c, Names__c, email__c, password__c FROM wanggi__c];
        
    }
    
    public void init(){
        wanggiList = [SELECT Id, mani__c, Names__c, email__c, password__c FROM wanggi__c];
        
        
    }
    
    public List<String> getPickListValuesIntoList(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = wanggi__c.Names__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        List<String> nameList = getPickListValuesIntoList();
        for(String str : nameList){
            options.add(new SelectOption(str,str));
        }
        system.debug('*****options******' + options);
        return options;
    }
    
    
    public void sendEmail(){
        
        for(wanggi__c wang : wanggiList){
            if(wang.Names__c == pageName){
                msg = '이미 가입된 아이디입니다.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,msg));
                return ;
            }
        }
        
        createwang = new wanggi__c();
        createwang.Names__c = pageName;
        createwang.email__c = pageEmail;
        
        insert createwang;
        
        wanggi__c wang = new wanggi__c();
        wang = [SELECT Id, mani__c, Names__c, email__c, password__c FROM wanggi__c WHERE Names__c =: pageName];
        
        String tempStr = wang.Id;
        
        List<String> emailList = new List<String>();
        emailList.add(wang.email__c);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailList);
        mail.setSenderDisplayName('왕지관리자');
        mail.setSubject('인증코드가 왔습니다.');
        mail.setReplyTo('tlaghksrl@gmail.com');
        mail.setPlainTextBody('인증 코드는 : ' + tempStr.right(6));
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
        
    }
    
    public void check(){
        
    }
}