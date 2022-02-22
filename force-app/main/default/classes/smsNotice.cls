public class smsNotice {
    public String result{get;set;}
    public void action(){
        
        smsJson kJson = new smsJson();
        
        kJson.msgid = 'SPttttz2';
        kJson.profile_key = '47f379c64a9697dff239e9ae7aaa173f17fceef9';
        kJson.reserved_time = '00000000000000';
        KJson.sms_only = 'Y';
        kJson.sms_kind = 'S';
        kJson.sms_message = '문자메세지입니다';
        kJson.receiver_num = '01065538329';
        kJson.sender_num = '07043340800';    
        
        String jsonstr = JSON.serialize(kJson);  
        
        String profilekey = '47f379c64a9697dff239e9ae7aaa173f17fceef9';
        String url = 'https://alimtalk-api.sweettracker.net';// baseURL
        String path = '/v2/'+profilekey+'/sendMessage';// + EndPoint
        
        HttpRequest req = new HttpRequest();
        Http httpProtocol = new Http();
        
        req.setEndpoint(url+path);
        req.setHeader('Content-type', 'application/json');
        req.setHeader('userId', '3boon1sf');
        req.setMethod('POST');
        req.setBody('['+jsonstr+']'); //단건일때
        HttpResponse response = new HttpResponse();
        response = httpProtocol.send(req);
        String result = response.getBody();
        
        system.debug(result);
    }
    
    
}