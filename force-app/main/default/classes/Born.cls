public class Born {

    public Account act{get;set;}
    
    public Company__c company{get;set;}
    public List<Contact> contact{get;set;}
    public List<CompanyContact__c> cnt{get;set;}
    public List<CompanyContact__c> addmr{get;set;}
    public List<CompanyContact__c> delmr{get;set;}
    public List<CompanyContact__c> delmrs{get;set;}
    public CompanyContact__c del{get;set;}
    public Product_Service__c pservice{get;set;}
    public List<Product_Service__c> pservicelist{get;set;}
    
    public String code {get;set;}// 회사아이디
    public String name {get;set;}//회사 이름
    public String tec {get;set;}//회사기술
    public String ser {get;set;}//회사 서비스
    public String own {get;set;}//회사 창업
    public String tel {get;set;}//회사 전화
    public Integer rowIndex {get;set;}
    
    public void init(){
        cnt = new List<CompanyContact__c>(); 
        delmr = new List<CompanyContact__c>(); 
        delmrs = new List<CompanyContact__c>();
        company = new Company__c();
        act = new Account();
        contact = new List<Contact>();
		pservicelist = new List<Product_Service__c>();       
		pservicelist = (List<Product_Service__c>)Database.query('SELECT Name,Industry__c,BriefIntro__c,AccountProduct__c,Status__c FROM Product_Service__c' );
  		system.debug(pservicelist);        
	}
    public void find(){// 계정 아이디 조회후 신청서와 신청연락처로 데이터 전송
       
        if(code != null && code != ''){
           act = (Account)Database.query('SELECT Name, Tech__c, Service__c, Owner__c, Phone FROM Account WHERE ID = \''+ code + '\'');
            company.Name = act.Name;
            company.CompanyTech__c = act.Tech__c;
            company.CompanyService__c = act.Service__c;
            company.CompanyPhone__c = act.Phone;
            company.CompanyOwner__c = act.Owner__c;
            
           contact = (List<Contact>)Database.query('SELECT Name, LastName , MobilePhone, AccountId FROM Contact WHERE AccountID = \''+ code + '\'ORDER BY Name');
            for(Integer i = 0; i < contact.size(); i++){
               cnt.add(new CompanyContact__c());
               cnt[i].Name =  contact[i].LastName;
               cnt[i].CompanyContactPhone__c =  contact[i].MobilePhone;
              }
            
       		}else
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'입력코드없음'));
      
    }
    public void add(){//행추가
        addmr = new List<CompanyContact__c>();
        cnt.add(new CompanyContact__c());
    }
    public void del(){//행삭제
			rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex')); 
        	del = cnt.remove(rowIndex);
        	delmrs.add(del);
    }
    public void sub(){//제출
        if(code != null && code != ''){
            company.AccountLook__c = code;
        }
        upsert company;
        for(Integer i = 0; i < cnt.size(); i++){
        cnt[i].CompanyAccount__c = company.Id;    
        }
        upsert pservicelist;
        
        upsert cnt;
        delete delmrs;
    }
    public void productadd(){
        pservicelist.add(new Product_Service__c());
    }
    
    
}