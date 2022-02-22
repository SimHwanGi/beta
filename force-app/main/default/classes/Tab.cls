public class Tab {

    // TAB1
    public String campaignids {get; set;} //처음화면에서 캠페인값
    public List<Contact> contacts {get; set;} // 연락처리스트
    public List<CampaignMember> CampaignMembers  {get;set;} //캠페인구성원리스트
    public List<Campaign> Campaigns {get;set;} // 캠페인리스트
    List<SelectOption> options {get;set;} // 캠페인선택
    public Integer rowIndex {get;set;}
    public String cmradio{get;set;}//검색 라디오버튼 값
    public String cmval{get;set;}//검색 스트링 값
    public String CampaignName{get;set;}
    
    // TAB2
    public String newname{get;set;}
    public String newemail{get;set;}
    public String newcompany{get;set;}
    public String newtitle{get;set;}
    public String newphone{get;set;}
    public String newmobile{get;set;}
    public Lead lead{get;set;}
    public CampaignMember cm{get;set;}
    
    public void init(){
      
    }
    public  Tab(){
        cmradio = 'cmname';
        campaignids = ApexPages.currentPage().getParameters().get('cpid'); 
        Campaigns = [SELECT Id, Name FROM Campaign WHERE Id =: campaignids ];
    	CampaignName = Campaigns.get(0).Name;
    }
    //TAB1 
    public void searchresult(){
        
        //campaignids = ApexPages.currentPage().getParameters().get('cpid');
               
        String cmqry = 'SELECT Id, CampaignId, ContactId, MobilePhone, Phone, Name, Title, CompanyOrAccount, Email, Status, Attend__c  FROM CampaignMember WHERE CampaignId =: campaignids';
        if(cmradio == 'cmname'){
            cmqry += (' AND Name LIKE \'%'+ cmval +'%\'');
        }else if(cmradio == 'cmemail'){
            cmqry += (' AND Email LIKE \'%'+ cmval +'%\'');
        }else if(cmradio == 'cmmobile'){
            cmqry += (' AND MobilePhone LIKE \'%'+ cmval +'%\'');
        }
        
        CampaignMembers = (List<CampaignMember>)Database.query(cmqry);
            
	
    }
    //참석버튼
    public PageReference attend(){
        
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        
        if(CampaignMembers.get(rowIndex).Status == '송년회불참'){
           CampaignMembers.get(rowIndex).Status = '송년회참석'; 
        }else{
            CampaignMembers.get(rowIndex).Status = '송년회불참';
        }
        
        update CampaignMembers;
        
        PageReference pageRef = new PageReference('/apex/tab?cpid=' + campaignids);
		return pageRef;   
        
    }
    //TAB2 Component
    
    //등록버튼
    public void register(){
      
      Lead lead = new Lead(LastName = newname, Email = newemail, Company = newcompany, Title= newtitle, Phone = newphone, MobilePhone = newmobile );
      insert lead;
      CampaignMember cm = new CampaignMember(Campaignid=campaignids, Leadid=lead.id);
	  Insert cm;
      
     		lead = null;
        	newname = null;
        	newemail = null;
            newcompany = null;
            newtitle = null;
            newphone = null;
            newmobile = null;
      		//cm = null;
      		
        
    }
    
}