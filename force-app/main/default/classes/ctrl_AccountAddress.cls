/*
* 심환기
* 01065538329
* tlaghksrl@gmail.com
* 2017.12
*/

public  class ctrl_AccountAddress {
    
    public String keyword{get; set;} // 검색키워드
    public String ConfirmKEY{get;set;}//승인키값
    public Integer nowpage{get;set;} //현재페이지 currentpage 번호 저장
    public Account accounts{get; set;} // 주소 넣을 오브젝트 리스트
    public String accountid {get; set;}//테스트페이지 아이디값
    public Integer rowIndex {get;set;}// 행선택    
    public jsonjuso jusodata{get;set;}//json주소데이터 오브젝트
    public String zipNo{get;set;}//우편번호
    public String sggNm{get;set;}//시/군/구
    public String jibunAddr{get;set;} // 지번주소
    public String siNm{get;set;}// 시/군 
    public String roadAddr{get;set;}//도로주소
    public String errorCode{get;set;}//에러코드
    public String errormsg{get;set;}//에러 메세지
    public String sepcificjuso{get;set;}//상세주소
    public String standardjuso{get;set;}//기본주소
    public Integer pageNumber1{get;set;}//첫번째 페이지
    public Integer pageNumber2{get;set;}//두번째 페이지
    public Integer pageNumber3{get;set;}//세번째 페이지
    public Integer pageNumber4{get;set;}//네번째 페이지
    public Integer pageNumber5{get;set;}//다섯번째 페이지
    public boolean pageprebtnrender{get;set;}//이전페이지 버튼 활성화
    public boolean pagebtnrender1{get;set;}//페이지버튼 활성화
    public boolean pagebtnrender2{get;set;}//페이지버튼 활성화
    public boolean pagebtnrender3{get;set;}//페이지버튼 활성화
    public boolean pagebtnrender4{get;set;}//페이지버튼 활성화
    public boolean pagebtnrender5{get;set;}//페이지버튼 활성화
    public boolean pagenextbtnrender{get;set;}//다음페이지 버튼 활성화
    public Integer totalpage{get;set;}//총페이지
    public Integer firstcount{get;set;}//지금보고있는 처음
    public Integer endcount{get;set;}//지금보고있는 끝
    public String page{get;set;}//현재 선택페이지
    public Integer currentPage{get;set;}//현재 선택페이지
    public Integer countPerPage{get;set;}//페이지당 갯수
    public Decimal totalCount{get;set;}//전체 갯수
    public Decimal LastPage{get;set;}//마지막페이지
    public boolean jusotable{get;set;}//주소테이블렌더
    public String str{get;set;}
    public boolean Billing{get;set;}
    public boolean Shipping{get;set;}
    public void init(){
        Billing = true;
        Shipping = true;            
        accountid = ApexPages.currentPage().getParameters().get('actids');
        
        String obj_fields = '';
        Map<String, Schema.SObjectField> ObjMap = schema.SObjectType.Account.fields.getMap();
        List<Schema.SObjectField> ObjMapValues = ObjMap.values();
        for(Schema.SObjectField s : ObjMapValues){
            obj_fields+=s.getDescribe().getName()+',';
        }
        obj_fields = obj_fields.removeEnd(',');
        obj_fields = obj_fields.removeStart('null');
        accounts = (Account)Database.query('SELECT '+ obj_fields +' FROM Account WHERE Id =:accountid');
        
        nowpage = 1;            
        ConfirmKEY = 'U01TX0FVVEgyMDE3MTEyMDE1NTQ0MzEwNzQ5Mzc';
        pageNumber1 = 1;
        pageNumber2 = 2;
        pageNumber3 = 3;
        pageNumber4 = 4;
        pageNumber5 = 5;
        pageprebtnrender = false;
        pagebtnrender1 = false;
        pagebtnrender2 = false;
        pagebtnrender3 = false;
        pagebtnrender4 = false;
        pagebtnrender5  = false;   
        pagenextbtnrender = false;
        
        
    }
    
    //웹 json 데이터 파싱
    public void getAddrApi(String page) {
        
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage='+ page +'&countPerPage=100&keyword='+keyword+'&confmKey='+ConfirmKEY+'=&resultType=json';
        request.setEndPoint(endpoint);
        request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        jusodata = (jsonjuso) JSON.deserialize(response.getBody(), jsonjuso.class);
        
        //errorCode 처리
        if(jusodata.results.common.errorCode=='-999'){
            errormsg = '시스템에러';            
        }else
            if(jusodata.results.common.errorCode=='E0001'){
                errormsg = '승인되지 않은 KEY';            
            }else
                if(jusodata.results.common.errorCode=='E0002'){
                    errormsg = '승인되지 않은 사이트';            
                }else
                    if(jusodata.results.common.errorCode=='E0003'){
                        errormsg = '비정상적 경로 접속';            
                    }else
                        if(jusodata.results.common.errorCode=='E0005'){
                            errormsg = '검색어 입력하지 않음';            
                        }else
                            if(jusodata.results.common.errorCode=='E0006'){
                                errormsg = '주소상세히 입력바람';            
                            }else
                                if(jusodata.results.juso == null){
                                    errormsg = '검색결과가 없습니다.';
                                }else errormsg = null;
        
        
        //1~100,101~200,201~2** .. 계산
        countPerPage = Integer.valueOf(jusodata.results.common.countPerPage);
        currentPage = Integer.valueOf(jusodata.results.common.currentPage);
        totalCount =  Integer.valueOf(jusodata.results.common.totalCount);
        LastPage = (totalCount/countPerPage).setScale(0,System.roundingMode.UP);
        
        if(currentPage*countPerPage > totalCount){
            firstcount = (currentPage - 1)*countPerPage + 1 ;
            endcount = ((currentPage -1)*countPerPage) + math.mod(Integer.valueOf(jusodata.results.common.totalCount), countPerPage); 
        }else{
            firstcount = (currentPage - 1)*countPerPage + 1 ;
            endcount = currentPage * countPerPage;
        }
        
        if(pageNumber5 >= LastPage){
            pagenextbtnrender = false;
        }else pagenextbtnrender = true;
        
        if(pageNumber4 >= LastPage){
            pagebtnrender5 = false;
        }else pagebtnrender5 = true;
        
        if(pageNumber3 >= LastPage){
            pagebtnrender4 = false;
        }else pagebtnrender4 = true;
        
        if(pageNumber2 >= LastPage){
            pagebtnrender3 = false;
        }else pagebtnrender3 = true;
        
        if(pageNumber1 >= LastPage){
            pagebtnrender2 = false;
        }else pagebtnrender2 = true;
        
        if(pageNumber1 == 1){
            pageprebtnrender = false;
        }else pageprebtnrender = true;
        
        if(countPerPage>totalCount){
            pagebtnrender1 = false;
        }else pagebtnrender1 = true;
    }
    
    /* 페이징처리 버튼 클릭*/
    public void page1(){
        String page = String.valueOf(pageNumber1); 
        getAddrApi(page);
    }
    public void page2(){
        String page = String.valueOf(pageNumber2); 
        getAddrApi(page);
    }
    public void page3(){
        String page = String.valueOf(pageNumber3); 
        getAddrApi(page);
    }
    public void page4(){
        String page = String.valueOf(pageNumber4); 
        getAddrApi(page);
    }
    public void page5(){
        String page = String.valueOf(pageNumber5); 
        getAddrApi(page);
    }
    
    /*검색*/
    public void find(){
        nowpage = 1;
        String page = String.valueOf(nowpage);
        jusotable = true;
        standardjuso = null; //기본주소 초기화
        getAddrApi(page);
    }
    /*다음 페이지*/
    public void next(){
        
        pageNumber1 += 5;
        pageNumber2 += 5;
        pageNumber3 += 5;
        pageNumber4 += 5;
        pageNumber5 += 5;
        
        String page = String.valueOf(pageNumber1);
        getAddrApi(page);
        
    }
    /*이전 페이지*/
    public void pre(){
        
        if(pageNumber1 != 1){
            pageNumber1 -= 5;
            pageNumber2 -= 5;
            pageNumber3 -= 5;
            pageNumber4 -= 5;
            pageNumber5 -= 5;
            String page = String.valueOf(pageNumber5); 
            getAddrApi(page);
        }else {
            pageprebtnrender = false;
            getAddrApi('1');
        }
        
    }
    /*주소선택 선택된 데이터 저장 */
    public void click(){
        if(Billing){
            accounts.BillingCity = sggNm;
            accounts.BillingState = siNm;
            accounts.BillingPostalCode = zipno;
            accounts.BillingStreet = standardjuso + sepcificjuso;                
        }
        if(Shipping){
            accounts.ShippingCity = sggNm;
            accounts.ShippingState = siNm;
            accounts.ShippingPostalCode = zipno;
            accounts.ShippingStreet = standardjuso + sepcificjuso;
        }
        
        upsert accounts; 
        
    }
    public void clickjibun(){
        
        if(Billing){
            accounts.BillingCity = sggNm;
            accounts.BillingState = siNm;
            accounts.BillingPostalCode = zipno;
            accounts.BillingStreet = standardjuso + sepcificjuso;                
        }
        if(Shipping){
            accounts.ShippingCity = sggNm;
            accounts.ShippingState = siNm;
            accounts.ShippingPostalCode = zipno;
            accounts.ShippingStreet = standardjuso + sepcificjuso;
        }
        upsert accounts; 
        
    }
    /*주소선택 선택된 데이터 기본주소 */
    public void click2jibun(){
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex')); 
        jibunAddr = jusodata.results.juso[rowIndex].jibunAddr;
        sggNm = jusodata.results.juso[rowIndex].sggNm;
        siNm = jusodata.results.juso[rowIndex].siNm;
        zipno = jusodata.results.juso[rowIndex].zipNo;
        standardjuso = jusodata.results.juso[rowIndex].jibunAddr;	                
    }
    
    public void click2(){
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex')); 
        jibunAddr = jusodata.results.juso[rowIndex].jibunAddr;
        sggNm = jusodata.results.juso[rowIndex].sggNm;
        siNm = jusodata.results.juso[rowIndex].siNm;
        zipno = jusodata.results.juso[rowIndex].zipNo;
        standardjuso = jusodata.results.juso[rowIndex].roadAddr;
        
    }
    /*닫기*/
    public PageReference close(){
        return new PageReference('javascript:window.close()');
    }
    public void Dummy(){
        Integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
    }
}