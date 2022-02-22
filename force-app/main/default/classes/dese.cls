public class dese {
    
    
    public void main(){
        String result = '{"result":"N","code":"E109","kind":"","msgid":"SMS9878MLw","error":"DuplicatedMsgId","sendtime":"2018-07-23 14:09:52"}';
        
        resultJson rJson = (resultJson) JSON.deserialize(result, resultJson.class);
        String t1 = rJson.code;
        String t2 = rJson.error;
        system.debug(t1);
        system.debug(t2);
        
    }
}