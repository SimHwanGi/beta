@RestResource(urlMapping='/showpage')
global class rest {

    @HttpGet
    global static String doGet(){
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    system.debug('*****res******' + res);	
    system.debug('*****req******' + req);	
        return 'Sim';
    
    }
    
    @HttpPost
    global static returnOk doPost(){
        RestRequest req = RestContext.request;
        RestResponse response = RestContext.response;
        
        system.debug('*****req******' + req);	
        system.debug('*****response******' + response);	        
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
            
		Blob tempblob = req.requestBody;
        sendResult =tempblob.toString();
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


    
}