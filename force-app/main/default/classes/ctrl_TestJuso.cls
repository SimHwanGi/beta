@RestResource(urlMapping='/json')
global with sharing class ctrl_TestJuso {

    /**
        String currentPage = ApexPages.currentPage().getParameters().get('currentPage');
        String countPerPage = ApexPages.currentPage().getParameters().get('countPerPage');
        String confmKey = ApexPages.currentPage().getParameters().get('confmKey'); 
        String resultType = ApexPages.currentPage().getParameters().get('resultType');
    	public static String keyword{get; set;}
  		public static String currentPage{get; set;}
	**/	
    	public static String jsondata{get; set;} 
        public static Integer zipno{get;set;}
    @future(callout=true)
    public static void getAddrApi(){
      
		/*String endpoint = 'http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage='+currentPage+'&countPerPage='+countPerPage+'&keyword='+keyword+'&confmKey='+confmKey+'&resultType='+resultType ;     */
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage=1&countPerPage=10&keyword=왕궁길&confmKey=U01TX0FVVEgyMDE3MTEyMDE1NTQ0MzEwNzQ5Mzc=&resultType=json';
        request.setEndPoint(endpoint);
     	request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        System.debug('json 데이터' + response.getBody());
        
        jsondata = response.getBody();
        
        JSONParser parser = JSON.createParser(response.getBody());
        
        while(parser.nextToken() != null){
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'zipNo')){
                    parser.nextToken();
                    zipno += parser.getIntegerValue();
                
            }
        }
        
              
        
}
}