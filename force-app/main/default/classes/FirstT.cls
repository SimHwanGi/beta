public class FirstT {

    public String cpid {get; set;} //처음화면에서 캠페인값
    public List<Campaign> Campaigns {get;set;} // 캠페인리스트
    List<SelectOption> options {get;set;} // 캠페인선택
    public date nowday {get;set;}//현재날짜
    
    //초기값
    public void init(){
        nowday = date.today();
        Campaigns =[SELECT ID, Name, StartDate, EndDate, IsActive FROM Campaign  ]; // 시작일,만료일,활성값
        
    
    }
    
    //Option 
    public List<SelectOption> getItems() {
         
        List<SelectOption> options = new List<SelectOption>(); 
        for(Campaign c : Campaigns) 
        {
            if((c.StartDate <= nowday) && (c.EndDate >= nowday) && (c.IsActive == true)) // 시작일만료일,활성 확인
               {
                options.add(new SelectOption(c.Id, c.Name));
            }
            
        }
         
        return options; 
    }
    
  
    //페이지 이동
    public PageReference click(){
        
        String url = '/apex/tab?cpid=' + cpid;
        PageReference ref = new PageReference(url);
        
        return ref;
        
    }
    
}