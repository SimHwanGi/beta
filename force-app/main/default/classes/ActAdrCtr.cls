/*
 * 심환기
 * 01065538329
 * tlaghksrl@gmail.com
 * 2018.1
 */

public with sharing class ActAdrCtr {
      
        public String keyword{get; set;} // 검색키워드
   		public String ConfirmKEY{get;set;}//승인키값
        public Integer nowpage{get;set;} //현재페이지 currentpage 번호 저장
        public Account accounts{get; set;} // 주소 넣을 오브젝트 리스트
    	public String accountid {get; set;}//테스트페이지 아이디값
        public String zipNo{get;set;}//우편번호
		public String sggNm{get;set;}//시/군/구
		public String jibunAddr{get;set;} // 지번주소
		public String siNm{get;set;}// 시/군 
   		public String roadAddr{get;set;}//도로주소
    	public String errorCode{get;set;}//에러코드
    	public String errormsg{get;set;}//에러 메세지
    	public String sepcificjuso{get;set;}//상세주소
    	public String standardjuso{get;set;}//기본주소
    	
    	
		//웹 json 데이터 파싱
		@AuraEnabled
    	public static Object getAddrApi() {
           
            Http httpProtocol = new Http();
            HttpRequest request = new HttpRequest();
            //String endpoint = 'http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage='+ page +'&countPerPage=100&keyword='+keyword+'&confmKey='+ConfirmKEY+'=&resultType=json';
            String endpoint = 'http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage=1&countPerPage=100&keyword=왕궁길&confmKey=U01TX0FVVEgyMDE3MTEyMDE1NTQ0MzEwNzQ5Mzc=&resultType=json';
            request.setEndPoint(endpoint);
            request.setHeader('Content-type', 'application/json');
            request.setMethod('GET');
            HttpResponse response = httpProtocol.send(request);
            Object jusodata = (jsonjuso) JSON.deserialize(response.getBody(), jsonjuso.class);
            return jusodata;
            	
            }
    	}