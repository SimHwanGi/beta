public class showPage {
    
    public String showtxt{get;set;}
    public String result{get;set;}
    public showPage(){
        showtxt = 'Before';
    }
    
    public void main(){
        body  testbody = new body();
        testbody.body1= 'ok';
        String josnStr = JSON.serialize(testbody);
        HttpRequest req = new HttpRequest();
        Http httpProtocol = new Http();
        
        req.setEndpoint('https://sm2test-developer-edition.ap5.force.com/rest/services/apexrest/showpage');
        req.setHeader('Content-type', 'application/json');
        req.setMethod('POST');
        req.setBody(josnStr);
        HttpResponse response = new HttpResponse();
        response = httpProtocol.send(req);
       //result = String.valueOf(response);
        result = String.valueOf(response.getBody());
        
        
        
    }
    
    public class body{
        public String body1;
    }

}