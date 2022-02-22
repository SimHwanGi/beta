@RestResource(urlMapping='/faxconnects')
global class faxconnect{	
    
    /*
    * @HttpGet
    global static String doGet(){
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    system.debug('*****res******' + res);	
    system.debug('*****req******' + req);	
    
    }
	*/

    @HttpPost
    global static returnOk doPost(){
        
        RestRequest req = RestContext.request;
        RestResponse response = RestContext.response;
        
        system.debug('*****req******' + req);	
        system.debug('*****response******' + response);	        
        
        faxConnectResult faxConnectResults = (faxConnectResult) JSON.deserialize(req.requestBody.toString(),faxConnectResult.class);
        
        system.debug('faxConnectResults' + faxConnectResults);
        String sendResult = 'OK';
        
        if(response.statusCode == 200){
            /*
             * 
             * 
             *  insert log
             * 
             * 
             *
             * 
             */    
           
        }else{
            sendResult ='Fail';
        }
        returnOk obj = new returnOk(sendResult);
        return obj;
    }
    
    // Return Result
    global class returnOk {
        public String result;
        public returnOk(String s) {
            this.result = s;
        }
    }
    
    // FAX Result 
    global class faxConnectResult{
        
        global String requestNum{get;set;}
        global Integer serialNum{get;set;}
        global Integer chargePageCnt{get;set;}
        global String receiptNum{get;set;}
        global Integer tiffFileSize{get;set;}
        global String receiptDT{get;set;}
        global Integer failPageCnt{get;set;}
        global String eventType{get;set;}
        global Integer refundPageCnt{get;set;}
        global Integer successPageCnt{get;set;}
        global Integer result{get;set;}
        global String corpNum{get;set;}
        global String resultDT{get;set;}
        global Integer sendPageCnt{get;set;}
        global Integer convState{get;set;}
        global String sendDT{get;set;}
        global Integer state{get;set;}
        global String receiveNum{get;set;}
        global String sendNum{get;set;}
        global String eventDT{get;set;}
        global String reserveDT{get;set;}
    }
    
}