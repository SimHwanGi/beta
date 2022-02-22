public class shoturl {
    
    public string result{get;set;}
    
    public void main(){
        
        HttpRequest req = new HttpRequest();
        Http httpProtocol = new Http();
        
        String tinyurl = 'http://tinyurl.com/api-create.php?url=';
        String longurl = 'http://samboonil.force.com/review?Id=0066F00000sBadB';
        
        req.setEndpoint(tinyurl+longurl);
        req.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        response = httpProtocol.send(req);
        result = response.getBody();
        
        
    }
    
    
    
}