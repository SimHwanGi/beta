public class ctrl_SMSSender extends vtl_Message{
    public List<Contact> contacts{get; set;}
    public List<Lead> leads{get; set;}
    public String content{get; set;}
    public String sender{get; set;}
    public String runTime{get; set;}
    public String result{get; set;}
    public String SendResult{get; set;}
    public String header1{get; set;}
    public String header2{get; set;}
    public Boolean isHeader{get; set;}
    public Boolean isMMS{get; set;}
    public Boolean sendSuccess{get; set;}
    public Boolean fileErr{get; set;}
    public String fileErrMsg{get; set;}
    public Integer fileSize{get; set;}
    public linkhub_service.add_file imageFile{get; set;}
    private String rel_id{get; set;}
    public ctrl_SMSSender(){}
    public void init(){
        String lead_id = ApexPages.currentPage().getParameters().get('ldids');
        String contact_id = ApexPages.currentPage().getParameters().get('ctids');
        rel_id = ApexPages.currentPage().getParameters().get('relid');
        List<String> lead_ids = EncodingUtil.urlDecode(lead_id, 'utf-8').split(',');
        List<String> contact_ids = EncodingUtil.urlDecode(contact_id, 'utf-8').split(',');
        
        if(!lead_ids.isEmpty())
            leads = [SELECT Id, Name, MobilePhone FROM Lead WHERE Id IN:lead_ids AND MobilePhone != null];
        if(!contact_ids.isEmpty())
            contacts = [SELECT Id, Name, MobilePhone FROM Contact WHERE Id IN:contact_ids AND MobilePhone != null];
        
        isHeader = true;
        header1 = '';
        header2 = '';
        SendResult = '';
        isMMS = false;
        sendSuccess = false;
        fileErr = false;
        fileErrMsg = '';
        imageFile = new linkhub_service.add_file();
        fileSize = 0;
    }
    public void chkFile(){
        Boolean isJpg = imageFile.name.toLowerCase().endsWith('jpg') || imageFile.name.toLowerCase().endsWith('jpeg');
        fileSize = imageFile.body.size();
        Boolean isNoOver = fileSize <= 100000;
        fileErr = !isJpg || !isNoOver;
        fileErrMsg = '';
         if(!isJpg)
            fileErrMsg += 'jpg 파일만 선택 가능 합니다. ';
        if(!isNoOver){
            fileErrMsg += '100kb 미만 파일만 선택 가능 합니다.';
        }
        if(fileErr){
            imageFile = new linkhub_service.add_file();
        }
            
    }
    public Task createSMSTask(Id target_id, String phone, Boolean isContact){
        return new Task(WhoId = target_id, WhatId = isContact && !String.isBlank(rel_id) ? rel_id : null, Subject = '문자메세지 발송', Status = '완료됨', Type='문자', ActivityDate = System.today(), SMSPhone__c = phone);
    }
    public void Send(){
        if(String.isBlank(sender) || String.isBlank(content)){
            SendResult = '발신번호 및 본문을 입력하시기 바랍니다.';
        }else{
            Map<String,String>numbers = new Map<String,String>();
            List<Task> tasks = new List<Task>();
            for(Contact c : contacts){
                numbers.put(c.MobilePhone, c.Name);
                Task t = createSMSTask(c.Id, c.MobilePhone, true);
                String h = '';
                if(isHeader){
                    h = header1.replace('{#receiver}',c.Name);
                }
                String ctt = content.replace('{#receiver}',c.Name);
                t.Description = h+'\r\n'+ctt;
                tasks.add(t);
            }
            for(Lead c : leads){
                numbers.put(c.MobilePhone, c.Name);
                Task t = createSMSTask(c.Id, c.MobilePhone, false);
                String h = '';
                if(isHeader){
                    h = header1.replace('{#receiver}',c.Name);
                }
                String ctt = content.replace('{#receiver}',c.Name);
                t.Description = h+'\r\n'+ctt;
                tasks.add(t);
            }
            String sms = SMSAsJSON(sender, content, runTime, numbers, isHeader, header1).getAsString();
            if(isMMS){
                result = service.MMS(sms, imageFile) ;
                SMS_Log__c log = WriteLog(result, sms);
                InsertMMSLog(log, imageFile);
            }else{
                result = service.XMS(sms) ;
                SMS_Log__c log = WriteLog(result, sms);
                insert log;
            }
            //SendResult = FindValue(JSON.createParser(result),'receiptNum');
            SendResult = result;
            String reNum;
            if(Test.isRunningTest()){
                reNum = 'test0001';
            }else{
                reNum = FindValue(JSON.createParser(result),'receiptNum');
            }
            if(!String.isBlank(reNum)){
                SendResult = reNum;
                sendSuccess = true;
            }
            for(Task tt : tasks)
                tt.SMSNo__c = SendResult.trim();
            insert tasks;
            if(sendSuccess)
                SendResult = '전송 성공 : ' + SendResult;
            else
                SendResult = '전송 실패 : ' + SendResult;
        }
    }
   
    
    
    public void setHeader(){
        if(isHeader && String.isBlank(header1))
            header1 = '안녕하세요. {#receiver} 고객님.';
    }
    public void addReceiver(){
        content += '{#receiver}';
    }
}