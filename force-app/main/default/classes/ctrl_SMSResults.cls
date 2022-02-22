public class ctrl_SMSResults extends vtl_Message{
    public Map<String,String> sStatus{
        get{
            return SendStatus;
        }
        set;
    }
  public Map<String,String> vStatus{
        get{
            return VendorStatus;
        }
        set;
    }
    public List<SMS_Log__c> logs{get; set;}
    public Map<String, List<linkhub_class.sms_Result>> results{get; set;}
    public List<String> resKeys{get; set;}
    public Boolean detailPopup{get; set;}
    public String paramName{get; set;}
    public Integer paramNum{get; set;}
    public linkhub_class.sms_Result detail{get; set;}
    private String ids;
    private String type;
    private String num;
    public ctrl_SMSResults(){
        ids = ApexPages.currentPage().getParameters().get('ids');
        type = ApexPages.currentPage().getParameters().get('type');
        num = ApexPages.currentPage().getParameters().get('num');
        detailPopup = false;
    }
    public void search(){
        resKeys = new List<String>();
        results = new Map<String, List<linkhub_class.sms_Result>>();
        if(type=='task'){
      List<String> sNum = ids.split(',');
            for(String n : sNum){
                resKeys.add(n);
                JSONParser parser = JSON.createParser(service.GetMessages(n));
                List<linkhub_class.sms_Result> res;
                if(Test.isRunningTest()){
                    res = new List<linkhub_class.sms_Result>();
                    linkhub_class.sms_Result resu = new linkhub_class.sms_Result();
                    resu.receiveNum = 'test';
                    res.add(resu);
                }else{
                    res = (List<linkhub_class.sms_Result>)parser.readValueAs(List<linkhub_class.sms_Result>.class);   
                }
                if(!String.isBlank(num)){
                    List<linkhub_class.sms_Result> filter = new List<linkhub_class.sms_Result>();
                    for(linkhub_class.sms_Result r : res){
                        if(r.receiveNum == num){
                            detail = r;
                            detailPopup = true;
                        }
                    }
                }
                results.put(n,res);
            }
        }
        else{
            logs = [SELECT Name FROM SMS_Log__c WHERE Id IN:EncodingUtil.urlDecode(ids, 'utf-8').split(',') ORDER BY Name DESC];
            for(SMS_Log__c log : logs){
                if(!log.Name.contains('fault')){
                    resKeys.add(log.Name);
                    JSONParser parser = JSON.createParser(service.GetMessages(log.Name));
                    if(Test.isRunningTest()){
                        List<linkhub_class.sms_Result> res = new List<linkhub_class.sms_Result>();
                        linkhub_class.sms_Result resu = new linkhub_class.sms_Result();
                        resu.receiveNum = 'test';
                        res.add(resu);
                        results.put(log.Name,res);
                    }else{
                        results.put(log.Name,(List<linkhub_class.sms_Result>)parser.readValueAs(List<linkhub_class.sms_Result>.class));
                    }
                }
            }
        }
    }
    public void getDetail(){
        detail = results.get(paramName)[paramNum-1];
        detailPopup = true;
    }
    public void closeDetail(){
    detailPopup = false;
    }
}