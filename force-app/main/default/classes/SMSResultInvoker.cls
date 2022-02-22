global class SMSResultInvoker {
    public static linkhub_service service = linkhub_service.getInstance();
    public static Map<String,String> VendorStatus = new Map<String,String>{NULL => '전송대기',
                                                                       'NULL' => '전송대기',
                                                                       '' => '전송대기',
                                                                       '0' => '전송성공',
                                                                       '1' => '전송시간 초과',
                                                                       '2' => '잘못된 수신번호',
                                                                       'A' => '핸드폰 호 처리중',
                                                                       'B' => '수신 불량지역',
                                                                       'C' => '전원꺼짐',
                                                                       'D' => 'SMS저장개수 초과',
                                                                       'a' => '서비스중지된 번호',
                                                                       'b' => '기타 단말기 문제',
                                                                       'c' => '발신번호 거부',
                                                                       'd' => '기타',
                                                                       'e' => '문자형식 오류',
                                                                       'f' => 'IB자체형식 오류',
                                                                       'g' => '수신불가 단말기',
                                                                       'h' => '핸드폰 호 불가상태',
                                                                       'i' => '기타형식 오류',
                                                                       'j' => '기타 이통사 오류',
                                                                       'k' => '이통사가 스팸문자로 처리',
                                                                       'l' => 'Nospam',
                                                                       'm' => '허브사가 스팸 문자로 처리',
                                                                       'n' => '문자 전송 제한량 초과',
                                                                       'o' => '문자 길이 오류',
                                                                       'p' => '잘못된 수신번호',
                                                                       'F' => '필드형식 오류(내용 없음)',
                                                                       'R' => '080 수신거부 대상',
                                                                       '8' => '잘못된 발신번호',
                                                                       't' => '통합 수신거부 대상'};
    global class SendInfo{
        @InvocableVariable(label='RESULT ID' required=false)
        public String rid;
    }
    @InvocableMethod(
        label='Receive SMS Results'
        description='Receive SMS Results')
    global static void invokeAction(List<SendInfo> infos){
        for(SendInfo si : infos){
            ResultToTask(si.rid);
        }
    }
    @future(callout=true)
    global static void ResultToTask(String rNum){
        SMS_Log__c log = [SELECT Id, Name, InComplete__c FROM SMS_Log__c WHERE Name =:rNum LIMIT 1];
        JSONParser parser = JSON.createParser(service.GetMessages(rNum.trim()));
        List<linkhub_class.sms_Result> res;
        if(Test.isRunningTest()){
            res = new List<linkhub_class.sms_Result>();
            linkhub_class.sms_Result resu = new linkhub_class.sms_Result();
            resu.receiveNum = 'test';
            resu.state = '3';
            res.add(resu);
        }else{
            res = (List<linkhub_class.sms_Result>)parser.readValueAs(List<linkhub_class.sms_Result>.class);
        }
        Set<String> pNums = new Set<String>();
        for(linkhub_class.sms_Result r : res){
            pNums.add(r.receiveNum);
        }
        if(!pNums.isEmpty()){
            List<Task> tsk = [SELECT Id, SMSPhone__c, SMSNo__c, SMSSendResult__c, Description, SMSDetail__c, ResultDone__c FROM Task WHERE SMSNo__c =:rNum AND SMSPhone__c IN:pNums AND ResultDone__c =false];
            if(!tsk.isEmpty()){
                Boolean inComplete = false;
                for(Integer i = 0 ; i < tsk.size() ; i++){
                    if(pNums.contains(tsk[i].SMSPhone__c)){
                        for(linkhub_class.sms_Result r : res){
                            if(tsk[i].SMSPhone__c == r.receiveNum){
                                if(r.state=='3' || r.state=='4'){
                                    tsk[i].SMSDetail__c +='접수시간:'+r.receiptDT+'\r\n';
                                    tsk[i].SMSDetail__c +='발송시간:'+r.sendDT+'\r\n';
                                    tsk[i].SMSDetail__c +='결과수신시간:'+r.resultDT+'\r\n';
                                    tsk[i].SMSDetail__c +='처리결과:'+r.sendResult+'('+VendorStatus.get(r.sendResult)+')\r\n';
                                    tsk[i].SMSDetail__c +='통신사:'+r.tranNet+'\r\n';
                                    tsk[i].ResultDone__c = true;
                                    tsk[i].SMSSendResult__c = r.sendResult;
                                }else{
                                    inComplete = false;
                                }
                            }
                        }
                    }
                    //else{inComplete = false;}
                }
                log.InComplete__c = inComplete;
                update log;
                update tsk;
            }
        }
    }
}