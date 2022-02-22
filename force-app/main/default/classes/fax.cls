public class fax {
    protected linkhub_service service;
    public linkhub_FAXclass faxclass{get;set;}
    public Blob pdf{get;set;}
    public String result{get;set;}
    public String result2{get;set;}
    
    public linkhub_service.add_file pdfFile{get; set;}
    public  List<faxresult> faxresultList{get;set;}    
    public fax(){
        faxclass = new linkhub_FAXclass();
        service = linkhub_service.getInstance();
        result = service.RunHttpRequest('https://popbill.linkhub.co.kr/FAX/019040308352500001');
        
        faxresultList= faxresult.parse(result);
        //fxre=  (faxresult) JSON.deserialize(result, faxresult.class);
        system.debug('fxrefxre'+ faxresultList);
    }
    
    
    public void getsender(){
        
        Datetime dt = system.now();
        dt= dt.addSeconds(30);
        String dtformat = dt.format('yyyyMMddHHmmss');
        pdfFile = new linkhub_service.add_file();
        
        faxclass.snd = '0314781599';
        faxclass.fCnt = 1;
        faxclass.sndnm = '심환기';
        faxclass.title ='테스테 팩스';
        faxclass.sndDT =dtformat;
        faxclass.requestNum = 'faxno4';
        faxclass.adsYN = false;
        linkhub_FAXclass.rcvobj robj= new linkhub_FAXclass.rcvobj();
        robj.rcv = '0310000000';
        faxclass.rcvs.add(robj);
        pdfFile.body = pdf;
        pdfFile.name = 'test.pdf';
        String tempStr = JSON.serialize(faxclass);
        result = tempStr;
        result2 = service.FAX(tempStr,pdfFile);
        
    }
    
    
}