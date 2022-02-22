public class sampleCon {
    String country = null;
     public List<Campaign> Campaigns {get;set;} // 캠페인리스트    
    
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
         Campaigns = [SELECT Id, Name  FROM Campaign ];
        List<SelectOption> options = new List<SelectOption>(); 
         options.add(new SelectOption('', '---캠페인 선택---'));
        for(Campaign c : Campaigns) 
        {
            options.add(new SelectOption(c.Id, c.Name));
            
        }
        return options; 
    }
                   
    public String getCountry() {
        return country;
    }
                    
    public void setCountry(String country) 
    { this.country = country; }
}