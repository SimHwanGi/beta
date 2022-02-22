public class Regist {
    
    public String radio{get;set;}
    public Campaign Campaigns{get;set;}
    public CampaignMember CampaignMembers{get;set;}
    public String campaign_id {get;set;}
    public String campaignmember_id {get;set;}
    public List<String> sel{get;set;}
    public List<String> nosel{get;set;}
    public String a{get;set;}
    public String b{get;set;}
    public String c{get;set;}
    public String d{get;set;}
  
    public Regist (){
        // 처음 초기값 캠페인멤버에 필드값 추가불가
    }
   
    public void init(){
        
        campaign_id = ApexPages.currentPage().getParameters().get('cpid');
        campaignmember_id = ApexPages.currentPage().getParameters().get('cpmid');
        Campaigns = [SELECT Id, Select__c, NotSelect__c, RegistrationStartDate__c, RegistrationEndDate__c  FROM Campaign WHERE Id =: campaign_id ]; 
		CampaignMembers = [SELECT Id , Status  FROM CampaignMember WHERE CampaignId  =:campaign_id AND ((LeadId =: campaignmember_id) OR (ContactId =: campaignmember_id))];
        system.debug(CampaignMembers);
        sel = new List<String>(); 
        nosel = new List<String>();
        
        for(String s : Campaigns.Select__c.split('=')){
         	sel.add(s);
            system.debug(sel);
        }
        for(String s : Campaigns.NotSelect__c.split('=')){
           nosel.add(s);
            system.debug(nosel);
        }
        
        a = sel.get(0);//화면에 보이는 참석
        b = sel.get(1);//켐페인멤버 상태값에 참석경우 들어갈 값
        c = nosel.get(0);//화면에 보이는 불참
        d = nosel.get(1);//캠페인 멤버 상태값에 불참일 경우 들어갈 값
  		   
		     
    }
    
    //라디오버튼
    public List<SelectOption> getItems() {
        
        List<SelectOption> options = new List<SelectOption>(); 
         options.add(new SelectOption('true',a));
         options.add(new SelectOption('false',c));
		 radio =  CampaignMembers.Status;
        
        return options; 
    }
   
    //등록하면 참석 등록이면 감사합니다. 아니면 
    public void register(){
       		
        
        if(radio == 'true'){
            CampaignMembers.Status = b;
                        
        }else if(radio == 'false'){
            
            CampaignMembers.Status = d;
        }
        
        system.debug(CampaignMembers);
        
        upsert CampaignMembers;
        
        //return new PageReference('javascript:window.close()');// 리턴값 ref 참석이면 감샇바니다... 등등등
        
    }
    
}