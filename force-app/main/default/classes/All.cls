public class All {
    //Wrapper Class 이용 방법
    /**
    private static List<RecordType> listRecordType{
        get{
            if(listRecordType==null) listRecordType = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SobjectType='Opportunity'];
            return listRecordType;
        }
        private set;
    }
    private static Map<String, Id> mapRecordTypeIdWithDeveloperName{
        get{
            if(mapRecordTypeIdWithDeveloperName==null){
                mapRecordTypeIdWithDeveloperName = new Map<String, Id>();
                for(RecordType obj:listRecordType) mapRecordTypeIdWithDeveloperName.put( obj.Id, obj.DeveloperName);
            }
            return mapRecordTypeIdWithDeveloperName;
        }
        private set;
    }
    
**/
    public class testWrapper{
        public String str{get;set;}
        public Integer num{get;set;}
        public testWrapper(String s, Integer i){
            this.str =s;
            this.num = i;
        }   
    }
    
    public List<testWrapper> testWrapper_item{get; set;}   
    public void wrappertest(){
        // 만약 리스트로 쓰고 싶을때
        testWrapper_item = new List<testWrapper>();
        testWrapper_item.add(new testWrapper('Hello',100));
        
    }
    /*
    Map<Id, Account> acc = new Map<Id,Account>([SELECT Id, Name FROM Account]);
    system.debug(acc);
    
    public void init(){
        //UserInfo.getProfileId() 사용자 아이디
    }
    //문자만들기
    public void msgservice(){
        /*
1. SMS 로그 커스텀 개체
2. 사용자 ETAX ID 필드
3. 활동 커스텀 필드
4. 개체 사용자 정의설정
5. 원격 사이트 등록
6. 클래스, 비주얼포스, 프로필 권한추가
7. 프로세스빌더
8. 목록버튼 활성화

}
**/
    
    
    
    //한글,영어 번역
    public void transfer(){
        boolean isEn = UserInfo.getLanguage().contains('en');
        String title=isEn?'title':'제목';
        String subTitle=isEn?'subTitle':'부제목';
    }
    
    //변수 타입 변경하기
    public void changetype(){
        Integer iint = 0;
        String sint = '';
        
        sint = String.valueOf(iint);
        iint = Integer.valueOf(sint);
    }
    
    //하위역할 ID 가져오기 
    public  Set<ID> getRoleSubordinateUsers(Id userId) {
        
        Id roleId = [select UserRoleId from User where Id = :userId].UserRoleId;
        Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
        Map<Id,User> users = new Map<Id, User>([Select Id, Name From User where UserRoleId IN :allSubRoleIds]);
        return users.keySet();
    }
    public  Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        
        Set<ID> currentRoleIds = new Set<ID>();
        for(UserRole userRole :[select Id from UserRole where ParentRoleId IN :roleIds AND ParentRoleID != null])
            currentRoleIds.add(userRole.Id);
        if(currentRoleIds.size() > 0)
            currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        return currentRoleIds;
    }
    
    //String값 다루기
    public void makestring(){
        String str = 'abcdefg';
        str += 'hi';
        str = str.remove('cde');
        str = str.removeStart('a');
        str = str.removeEnd('g');
        str = str.replace('b', 'bbbb');
        //String.join(iterableObj, separator)i
    }
    
    //Object field값 추출하기
    public String obj_fields{get;set;}
    public String objfield(){
        obj_fields = null;
        Map<String, Schema.SObjectField> ObjMap = schema.SObjectType.Test__c.fields.getMap();//Test__c에 뽑고싶은 Obj Api
        List<Schema.SObjectField> ObjMapValues = ObjMap.values();
        for(Schema.SObjectField s : ObjMapValues){
            obj_fields+=s.getDescribe().getName()+',';
        }
        obj_fields = obj_fields.removeEnd(',');
        obj_fields = obj_fields.removeStart('null');
        return obj_fields; 
    }
    //더 나은 field 값 추출하기
    // 필드명 빼내기 반복적으로 많이 할때 사용
    public String field(String obj){ 
        String fields = '';
        SObjectType objType = Schema.getGlobalDescribe().get(obj);
        Map<String,Schema.SObjectField> fldObjMap = objType.getDescribe().fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        fields = '';
        fldObjMapValues = fldObjMap.values();
        for(Schema.SObjectField s : fldObjMapValues){
            fields+=s.getDescribe().getName()+',';
        }
        fields = fields.removeEnd(',');
        return fields;
        // List<HR__C> hr = (List<HR__C>)Database.query('SELECT '+ field('HR__C') +' FROM HR__C WHERE Account__c = \'' + account_ids[i] +'\'' );
    }
    //추출한 Object field값으로 리스트 만들기
    public void makelist(){
        objfield();
        List<Test__c> test = (List<Test__c>)Database.query('SELECT'+ obj_fields +' FROM Test__c ');
        //tid = ApexPages.currentPage().getParameters().get('id');
        //Truck = (List<TruckMaster__c>)Database.query('SELECT'+ obj_fields +' FROM Test__c WHERE Id =: tid ');
        //다이나믹 sql 오류시 : 빼고 = 만 해서 \' \' 이거 사용해서 하면 됨
    }
    //복사후 고객이력 연결 list clone
    /**
for(Integer j = 0 ; hr.clone().size() > j; j++){
hr.clone()[j].AccountCopy__c = acpy.Id;
hr.clone()[j].Account__c = null;
hr.clone()[j].ID = null;
insert hr.clone()[j];
}
**/
    
    //반올림,내림 setscale
    public void scale(){
        //decimal 가능
        Decimal dec = 12.623;
        Decimal dec2 = 12.535;
        system.debug(dec.setScale(0));
        system.debug(dec.setScale(1));
        system.debug(dec.setScale(2));
        system.debug(dec2.setScale(2, System.roundingMode.UP));
    }
    
    //오류메세지
    public void errormsg(){
        boolean stat = true;
        stat = false;
        String msg = '오류메세지';
        ApexPages.addMessage(new ApexPages.Message(stat?ApexPages.Severity.CONFIRM:ApexPages.Severity.INFO,msg));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ERROR 메세지'));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'WARNING 메세지')); 
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'INFO 메세지'));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'CONFIRM 메세지'));
        
    }
    
    //오브젝트 리스트, 하나오브젝트로 가져오기
    public TEST__c tests{get; set;}
    public List<TEST__c> testlist{get;set;}
    
    //json데이터 불러오고 파싱하기
    public void jsonparse(){
        
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        // 추출할 페이지는 원격사이트 설정
        String endpoint = 'json데이터 담고있는 url ex) http://www.juso.go.kr/~~~';
        request.setEndPoint(endpoint);
        request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        //json.deserialize 할때 http://json2apex.herokuapp.com/ 가서 json data 입력하면 class 출력됨
        //jusodata = (jsonjuso) JSON.deserialize(response.getBody(), jsonjuso.class);
        
        
    }
    
    //현재 팝업 페이지 닫기 
    public PageReference close(){
        return new PageReference('javascript:window.close()');
    }
    
    //기본 PageReference 사용
    public PageReference standardpagereference(){
        PageReference pageRef = new PageReference('https://naver.com');
        return pageRef;
    }
    
    //Set, List, Map, Loop
    public void setlistmap(){
        
        Set<String> set1  = new Set<String>();//set 중복을 피하려고사용 ID
        Set<Integer> set2  = new Set<Integer>(); 
        Set<Id> set3 = new Set<Id>();
        set1.add('element'); set1.add('element'); set1.add('element'); set1.add('element2'); set1.add('element3');
        system.debug(set1);//{element, element2, element3}
        for(String s : set1){
            system.debug(s);
        }
        for(Integer i : set2){
            system.debug(i);
        }
        for(String s : set3){
            system.debug(s);
        }
        
        Map<Integer,String> map1 = new Map<Integer,String>();
        map1.put(1,'First Item');
        map1.put(2,'Second Item');
        system.debug(map1.keySet());//{1,2}
        system.debug(map1.values());//{First Item,Second Item}
        system.debug(map1.size());//{2}
        system.debug(map1.get(2));//{Second Item}
        
        Map<Integer, String> map2 = new Map<Integer, String>(map1);    
        
        //map list 활용
        Map<Integer,List<String>> maplist = new Map<Integer,List<String>>();
        List<String> list1 = new List<String>();
        List<String> list2 = new List<String>();
        list1.add('1-1');
        list1.add('1-2');
        list1.add('1-3');
        list2.add('2-1');
        list2.add('2-2');
        list2.add('2-3');
        maplist.put(1,list1);
        maplist.put(2,list2);
        system.debug(maplist);// {1=(1-1, 1-2, 1-3), 2=(2-1, 2-2, 2-3)}
        
        //list 초기화
        List<Account> act = new List<Account>();
        act = [select Id from Account ];
        
        //list에 list 넣기
        list1.addAll(list2);
        system.debug(act);
        List<Test__c> test = (List<Test__c>)Database.query('SELECT'+ obj_fields +' FROM Test__c ');
        
        
    }
    
    //for응용
    public void forloop(){
        
        Set<String> forset = new Set<String>();
        for(UserRole userRole :[select Id from UserRole where  ParentRoleID != null])
            forset.add(userRole.Id);
    }
    
    //select options radiobutton 활용
    //regist 참고
    
    //object 새로운 값 넣기
    public void newobject(){
        String newname = 'newname';
        String newmobile = '01012345678';
        Lead lead = new Lead(LastName = newname,  MobilePhone = newmobile );
        insert lead;
        //CampaignMember cm = new CampaignMember(Campaignid=campaignids, Leadid=lead.id);
        //Insert cm;
    }
    public void alldate(){
        
        Date selectedDate = System.today(); //Give your date
        Date firstDate = selectedDate.toStartOfMonth();
        Date lastDate = firstDate.addDays(date.daysInMonth(selectedDate.year() , selectedDate.month())  - 1);
        
    }
    
     	// Batch Job Query
        /*AsyncApexJob apexJob = [SELECT Id, CreatedById, JobItemsProcessed,MethodName,Status,TotalJobItems,ApexClass.name
			                    FROM AsyncApexJob
			                    WHERE Id = :jobId];
		*/
    
    /**
* 
*  valueOf(doubleToDecimal)
Returns a Decimal that contains the value of the specified Double.
valueOf(longToDecimal)
Returns a Decimal that contains the value of the specified Long.
valueOf(stringToDecimal)
Returns a Decimal that contains the value of the specified String. As in Java, the string is interpreted as representing a signed Decimal.

* /    
/**
public class pdfcontroller {
public String tid{get;set;}
public Account ac{get;set;}
public List<Account> act{get;set;}
public List<Product_Service__c> product{get;set;}
public List<FundingHist__c> funding {get;set;}
public List<OverseasExpansionPlan__c> over {get;set;}
public List<FinancialRecord__c> finan {get;set;}
public List<HumanResources__c> human{get;set;}
public List<HR__c> hr{get;set;}
public List<AdditionalPoint__c> ap{get;set;}
public List<ContentVersion> cv{get;set;}
public List<ContentDocument> cd{get;set;}
public boolean vfunding{get;set;}
public boolean vover{get;set;}
public boolean vfinan{get;set;}
public boolean vhuman{get;set;}
public boolean vhr{get;set;}
public boolean vap{get;set;}
public boolean vcompetitors{get;set;}
public String prurl{get;set;}
public String bsurl{get;set;}

public pdfcontroller(ApexPages.StandardController stdController){
vfunding= true;
vover= true;
vfinan= true;
vhuman= true;
vhr= true;
vap= true;
vcompetitors=true;
LIst<String> fields = new List<String>();
fields.add('Name');
if(!Test.isRunningTest()){stdController.addFields(fields);}
ac = (Account)stdController.getRecord();

tid = ApexPages.currentPage().getParameters().get('id');
funding = (List<FundingHist__c>)Database.query('SELECT '+ field('FundingHist__c') +' FROM FundingHist__c WHERE Account__c = \'' + tid +'\' LIMIT 6' );
product	= (List<Product_Service__c>)Database.query('SELECT '+ field('Product_Service__c') +' FROM Product_Service__c WHERE Account__c = \'' + tid +'\' LIMIT 1');
over = (List<OverseasExpansionPlan__c>)Database.query('SELECT '+ field('OverseasExpansionPlan__c') +' FROM OverseasExpansionPlan__c	 WHERE Account__c = \'' + tid +'\' LIMIT 6');
finan = (List<FinancialRecord__c>)Database.query('SELECT '+ field('FinancialRecord__c') +' FROM FinancialRecord__c	 WHERE Account__c = \'' + tid +'\' LIMIT 6');
human = (List<HumanResources__c>)Database.query('SELECT '+ field('HumanResources__c') +' FROM HumanResources__c	 WHERE Account__c = \'' + tid +'\' LIMIT 6');
hr = (List<HR__c>)Database.query('SELECT '+ field('HR__c') +' FROM HR__c WHERE Account__c = \'' + tid +'\' LIMIT 6');
ap = (List<AdditionalPoint__c>)Database.query('SELECT '+ field('AdditionalPoint__c') +' FROM AdditionalPoint__c WHERE Account__c = \'' + tid +'\' LIMIT 6');
if(funding.size() == 0){vfunding = false;}
if(over.size() == 0){vover = false;}
if(finan.size() == 0){vfinan = false;}
if(human.size() == 0){vhuman = false;}
if(hr.size() == 0){vhr = false;}
if(ap.size() == 0){vap = false;}
if(product[0].Competitors_kor__c == null || product[0].Competitors_kor__c == ''){vcompetitors=false;}
}
public String field(String obj){ 
String fields = '';
SObjectType objType = Schema.getGlobalDescribe().get(obj);
Map<String,Schema.SObjectField> fldObjMap = objType.getDescribe().fields.getMap();
List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
fields = '';
fldObjMapValues = fldObjMap.values();
for(Schema.SObjectField s : fldObjMapValues){
fields+=s.getDescribe().getName()+',';
}
fields = fields.removeEnd(',');
return fields;
}
public void findurl(){
String fileid;
String fileid2;
tid = ApexPages.currentPage().getParameters().get('id');
act	= (List<Account>)Database.query('SELECT Id, Name FROM Account WHERE Id = \'' + tid +'\'');
cv = (List<ContentVersion>)Database.query('SELECT Id, PathOnClient FROM ContentVersion WHERE PathOnClient LIKE \'%'+act[0].Name+'%\'');
for(ContentVersion cvv : cv){
String proname = cvv.PathOnClient;
if(proname.contains('제품사진')){ fileid = cvv.ID; 
}else if(proname.contains('모델')){fileid2 = cvv.ID;}
}
//cd = (List<ContentDocument>)Database.query('SELECT '+ field('ContentDocument') +' FROM ContentDocument');  
/*
Integer size = cd.size();
for(Integer msize = 0; msize < size ; msize+= 100){
if(size>msize+100){
for(Integer i = msize ; i < msize+100 ; i ++){
String proname = cv[i].PathOnClient;
if(proname.contains(ac.Name)){
if(proname.contains('제품사진')){ fileid = cv[i].ID; 
}else if(proname.contains('모델')){fileid2 = cv[i].ID;}     
}
}  
}else
for(Integer i = msize ; i < size ; i ++){
String proname = cv[i].PathOnClient;
if(proname.contains(ac.Name)){
if(proname.contains('제품사진')){ fileid = cv[i].ID; 
}else if(proname.contains('모델')){fileid2 = cv[i].ID;}     
}
}  

}

prurl = '/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=' + fileid; 
bsurl = '/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=' + fileid2; 
}

}
**/
    /**
<apex:page showheader="false" applybodytag="false" applyhtmltag="false" sidebar="false" renderas="pdf" standardcontroller="Account" extensions="pdfcontroller" action="{!findurl}">
<head>
<style type="text/css" media="print">
@page{
margin:1.3em;
}
body{
align:center;
}
td{
align:center;
font-size:8pt;
padding-left:4px;
border:0.5px solid;
max-width: 0;
white-space:normal; 
overflow: hidden;
text-overflow: ellipsis;
vertical-align:top;
}
.noborder{
align:center;
font-size:11pt;
border:none;
}
table{
width:750px;
border-spacing: 0px;
border:1px solid;
table-layout:fixed;
}
tr{
align:center;
}
.sectionHeight{
height:155px;
}
.sectionHeight2{
height:181px;
}
.maxHeight{
max-height:145px;
}
.oneHeight{
max-height:75px;
}
.imgHeight{
height:225px;
}
.sectionTitle{
font-size:10pt;
}
.reviewText{
font-size:9pt;
}
.page1{width:100%; height:100%; page-break:none;margin-bottom:30px;}
.page2{width:100%; height:100%; page-break:none;}

.repeattitle{
font-family: 'Arial Unicode MS';
font: bold 13pt;
}
</style>
</head>
<body style="font-family: Arial Unicode MS;">
<div class="page1" style="">
<table style="border:none;">
<tr>
<td rowspan="2" style="border:none;width:96px;height:84px;">
<img src="/servlet/servlet.FileDownload?file=0157F000000gLGN" style="width:96px;height:84px;"/>
</td>
</tr>
</table>
<table>
<tr class="oneHeight">
<td rowspan="6" width="247.5px;" class="reviewText" style="text-align:left; valign:top;max-width:247.5px;overflow-x: hidden;white-space:normal; max-height:810px;padding-top:5px;">
<br/>
<br/>
<apex:outputtext value="{!Account.Name}" escape="false"/><br/>
<apex:outputtext value="{!Account.Name_eng__c}" escape="false"/><br/>
<apex:outputlabel value="{!Account.Region__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!Account.Website}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!Account.CeoEmail__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!Account.OffererPhone__c}" style="font-family: Arial Unicode MS;"/><br/>
<br/>
<apex:outputlabel value="Keyword1 : {!product[0].Technic_Keyword1_ko__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="Keyword2 : {!product[0].Technic_Keyword2_ko__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="Keyword3 : {!product[0].Technic_Keyword3_ko__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="Industry : {!product[0].Industry__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="Category : {!product[0].Product_Service_Category__c}" style="font-family: Arial Unicode MS;"/><br/>
<br/>
<apex:outputText value="투자정보" styleClass="repeattitle" rendered="{!vfunding}" /><br/>
<apex:repeat value="{!funding}" var="f">
<apex:outputlabel value="{!f.Sector__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!f.Name}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputText value="{0,date,yyyy'년 'MM'월 'dd'일'}" style="font-family: Arial Unicode MS;">
<apex:param value="{!f.Date__c}"/>
</apex:outputText><br/>
<apex:outputlabel value="투자단계 : {!f.Funding_Round__c}" style="font-family: Arial Unicode MS;"/> <br/>
<apex:outputlabel value="금액 : {!f.Funding_Won__c} (백만원)" style="font-family: Arial Unicode MS;"/><br/>
<br/>
</apex:repeat>
<br/>
<apex:outputlabel value="제품명 : {!product[0].Name}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="제품단계 : {!product[0].Status__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputText value="제품출시(예정)일 : {0,date,yyyy'년 'MM'월 'dd'일'}" style="font-family: Arial Unicode MS;">
<apex:param value="{!product[0].ReleaseDate__c}" /> 
</apex:outputText><br/>

<br/>


</td>
<td class="oneHeight">
<div class="sectionTitle">
1줄 요약
</div>
<apex:outputtext value="{!product[0].BriefIntro_kr__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight">
<td class="maxHeight">
<div class="sectionTitle">
제품 및 기업 설명
</div>
<apex:outputtext value="{!product[0].ElevatorPitch_kor__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight">
<td class="maxHeight">
<div class="sectionTitle">
제품(서비스) 개발 배경
</div>
<apex:outputtext value="{!product[0].Problem_kor__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight">
<td class="maxHeight">
<div class="sectionTitle">
문제점 해결방안
</div>
<apex:outputtext value="{!product[0].Solution_kor__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight">
<td class="maxHeight">
<div class="sectionTitle">
제품(서비스) 구현 방법
</div>
<apex:outputtext value="{!product[0].Technology_kor__c}" escape="false"/>
</td>
</tr>
<tr class="imgHeight">
<td class="imgHeight">
<div class="sectionTitle">
제품이미지
</div>
<apex:image url="{!prurl}" style="width:280px;height:210px;" />
</td>
</tr>
</table>
</div>
<div class="page2" style="">
<table>
<tr class="sectionHeight2">
<td rowspan="6" width="247.5px;" class="reviewText" style="text-align:left; valign:top;max-width:247.5px;overflow-x: hidden;white-space:normal; max-height:810px;padding-top:5px;">
<br/>
<br/>
<apex:outputText value="해외진출" styleClass="repeattitle" rendered="{!vover}" /><br/>
<apex:repeat value="{!over}" var="f">
<apex:outputlabel value="{!f.Field1__c} / " style="font-family: Arial Unicode MS;"/>
<apex:outputText value="{0,date,yyyy'년 'MM'월 'dd'일'} / " style="font-family: Arial Unicode MS;">
<apex:param value="{!f.OverseasExpansionDate__c}"/>
</apex:outputText>
<apex:outputlabel value="{!f.Stage__c}" style="font-family: Arial Unicode MS;"/>
<br/>
</apex:repeat>
<br/>
<apex:form rendered="{!vcompetitors}">
<apex:outputText value="경쟁 현황" styleClass="repeattitle"   /><br/>
<apex:outputlabel value="{!product[0].Competitors_kor__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!product[0].Competitors2_kor__c}" style="font-family: Arial Unicode MS;"/><br/>
</apex:form>
<br/>
<apex:outputText value="자본금" styleClass="repeattitle" rendered="{!vfinan}" /><br/>
<apex:repeat value="{!finan}" var="f">
<apex:outputlabel value="{!f.Year__c} / " style="font-family: Arial Unicode MS;"/>
<apex:outputText value="자본금 : {0, number, ###,###,##0}" style="font-family: Arial Unicode MS;">
<apex:param value="{!f.Capital__c}"/>
</apex:outputText>
<br/>
<apex:outputText value="국내 : {0, number, ###,###,##0} / " style="font-family: Arial Unicode MS;">
<apex:param value="{!f.Sales_domestic__c}"/>
</apex:outputText>
<apex:outputText value="해외 : {0, number, ###,###,##0} " style="font-family: Arial Unicode MS;">
<apex:param value="{!f.Sales_overseas__c}"/>
</apex:outputText><br/>
<apex:outputText value="합계 : {0, number, ###,###,##0}" style="font-family: Arial Unicode MS;">
<apex:param value="{!f.Sales_total__c}"/>
</apex:outputText><br/>
</apex:repeat>
<br/>
<br/>
<apex:outputText value="주요인력" styleClass="repeattitle" rendered="{!vhuman}" /><br/>
<apex:repeat value="{!human}" var="f">
<apex:outputlabel value="{!f.LastName__c}{!f.FirstName__c} /" style="font-family: Arial Unicode MS;"/>
<apex:outputlabel value="입사연도 : {!f.YearOfEmployment__c}" style="font-family: Arial Unicode MS;"/><br/>
<apex:outputlabel value="{!f.Expertise__c} / " style="font-family: Arial Unicode MS;"/>
<apex:outputlabel value="{!f.Language__c}" style="font-family: Arial Unicode MS;"/><br/>
</apex:repeat>
<br/><br/>
<apex:outputText value="신규채용 인원" styleClass="repeattitle" rendered="{!vhr}" /><br/>
<apex:repeat value="{!hr}" var="f">
<apex:outputlabel value="{!f.Year__c}" style="font-family: Arial Unicode MS;"/>
<apex:outputlabel value="{!f.NewEmp__c}" style="font-family: Arial Unicode MS;"/>
<br/>
</apex:repeat>
<br/>
<apex:outputText value="가점사항" styleClass="repeattitle" rendered="{!vap}"  /><br/>
<apex:repeat value="{!ap}" var="f">
<apex:outputlabel value="{!f.Type__c}" style="font-family: Arial Unicode MS;"/>
<apex:outputlabel value="{!f.Year__c}" style="font-family: Arial Unicode MS;"/>
<apex:outputlabel value="{!f.Recommendation__c}" style="font-family: Arial Unicode MS;"/>
<apex:outputText value="{0,date,yyyy'년 'MM'월 'dd'일'}" style="font-family: Arial Unicode MS;">
<apex:param value="{!f.RecommendationDate__c}" /> 
</apex:outputText><br/>

</apex:repeat>
</td>
<td class="maxHeight">
<div class="sectionTitle">
진출 목표 시장
</div>
<apex:outputtext value="{!product[0].TargetMarket_kor__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight2">
<td class="maxHeight">
<div class="sectionTitle">
진출 목표 시장 검증
</div>
<apex:outputtext value="{!product[0].MarketValidation_kor__c}" escape="false"/>
</td>
</tr>

<tr class="imgHeight">
<td class="imgHeight">
<div class="sectionTitle">
비즈니스 모델 그림
</div>
<apex:image url="{!bsurl}" style="width:280px;height:210px;" />
</td>
</tr>
<tr class="sectionHeight2">
<td class="maxHeight">
<div class="sectionTitle">
팀 역량 현황
</div>
<apex:outputtext value="{!product[0].HumanResources_kor__c}" escape="false"/>
</td>
</tr>
<tr class="sectionHeight2">
<td class="maxHeight">
<div class="sectionTitle">
B2G 프로그램 참가 이유
</div>
<apex:outputtext value="{!product[0].WhyInvest_kor__c}" escape="false"/>
</td>
</tr>
</table>
<table style="border:none;">
<tr>
<td colspan="2" style="border:none;">
Born2Global has been setting the standard for successful startup ecosystem as the main Korean government agency since 2013.
</td>
</tr>
</table>
</div>
</body>
</apex:page>
**/
    
    
    /**

$( document ).ready(function() {
$("select[id*='Consulting__c.Stage__c'] option:selected").each(function() {
if(jQuery(this).val() == "1.신청"){
$( "#Consulting__c\\.Category__c" ).removeAttr("disabled");
$( "#Consulting__c\\.ServiceItem__c" ).removeAttr("disabled");
$( "#Consulting__c\\.RequestContents__c" ).removeAttr("readonly");
$( "#Consulting__c\\.UsePlan__c" ).removeAttr("readonly");
$( "#Consulting__c\\.ServicePeriod__c" ).removeAttr("readonly");
//$( "#" ).removeAttr("readonly");
//$( "#Consulting__c\\.ApplicationContents__c" ).attr("readonly","readonly"); 

}else if(jQuery(this).val() == "5.기업부담금 납입"){


$( "#Consulting__c\\.PayDate_Comp__c" ).removeAttr("disabled");
$( "#Consulting__c\\.PayDate_Comp__c" ).addClass('hasDatepicker');
$( "#Consulting__c\\.Field12__c" ).removeAttr("readonly");
$( "#Consulting__c\\.Payment_Comp__c" ).removeAttr("readonly");

}

});	
});


**/
    /**
<apex:repeat value="{!oData.ProductList}" var="f">
<tr>
<td align="center" >
<apex:outputText value="{!f.no}"></apex:outputText>
</td>
<td align="center" >
<apex:outputText value="{!f.name}"></apex:outputText>
</td>

<td align="center" style="width:250px;">
<div style="overflow-wrap:break-word; word-break:break-all;">
{!IF(ISBLANK(f.detail),'',f.detail)}
</div>
</td>


// E-mail 전송
public void sendemail(Attachment at){

String[] toemail = new String[]{ToEmail};
htmlBody = '안녕하세요,&nbsp;삼성전자&nbsp;한국총괄&nbsp;'+oData.Ownername +'&nbsp;입니다.<br>';
htmlBody +=  '<br>&nbsp;<br><br>'+oData.Title+'&nbsp;첨부문서와&nbsp;같이&nbsp;발주요청드립니다.<br>';
htmlBody += '<br>납품/설치&nbsp;완료되면&nbsp;아래&nbsp;메일주소로&nbsp;납품/설치확인증&nbsp;메일&nbsp;회신&nbsp;부탁드립니다.<br><br>&nbsp;<br><br>';
htmlBody += '납품/설치확인증&nbsp;:&nbsp;납품/설치완료&nbsp;후&nbsp;납품/설치확인증&nbsp;스캔본&nbsp;회신(금액기재&nbsp;X,&nbsp;인수자&nbsp;싸인&nbsp;및&nbsp;명판날인&nbsp;必)<br>';
htmlBody += '<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
htmlBody += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;택배&nbsp;배송일&nbsp;경우&nbsp;배송도착&nbsp;화면&nbsp;캡쳐&nbsp;후&nbsp;회신<br>';
htmlBody += '<br>&nbsp;<br>[영업담당]&nbsp;<br><br>';
htmlBody += '부서:&nbsp;B2B영업팀<br><br>담당자:&nbsp;'+oData.Ownername+'&nbsp;프로/';
htmlBody += '&nbsp;'+oData.OwnerPhone+'<br><br>이메일:&nbsp;'+oData.Owneremail; 

//EmailTemplate et=[Select id from EmailTemplate where name = 'EmailTemplatename' limit 1];
Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
semail.setToAddresses(toemail);
semail.setSubject('[PO]' + oData.Title);
//semail.setPlainTextBody(MainText);
semail.setHtmlBody(htmlBody);
semail.setCharset('UTF-8');

List<Messaging.EmailFileAttachment> efalist = new List<Messaging.EmailFileAttachment>();
Messaging.EmailFileAttachment efa =  new Messaging.EmailFileAttachment();
efa.setFileName(at.Name);
efa.setBody(at.body);
efa.setContentType(at.ContentType);
efa.setInline(false);
efalist.add(efa);
semail.setFileAttachments(efalist);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});


}
// PDF 변경 및 첨부
public void changepdf(){

try{
errMsg = '';
pdf= true;

oData.ProductList = Prolist;
if(dateop.QualifiedDt__c != null){oData.Orderdate = dateop.QualifiedDt__c.year() + '.' + dateop.QualifiedDt__c.month()+'.'+dateop.QualifiedDt__c.day();}

if(oData.Orderdate == '' || oData.Orderdate == null){errMsg='발주일을 입력해주세요.';return;}
if(oData.Title == '' || oData.Title == null){errMsg='제목을 입력해주세요.'; return;}
if(oData.DeliveryTime == '' || oData.DeliveryTime == null){errMsg='납품기한을 입력해주세요.';return;}
if(oData.Delinquencyrate == '' || oData.Delinquencyrate == null){errMsg='계약이행 보증금율을 입력해주세요.';return;}
if(oData.Freewarrantyperiod == '' || oData.Freewarrantyperiod == null){errMsg='지체상금율을 입력해주세요.';return;}
if(oData.BondPerformanceDepositRate == '' || oData.BondPerformanceDepositRate == null){errMsg='무상보증기간을 입력해주세요.';return;}
if(oData.Paymentterms == '' || oData.Paymentterms == null){errMsg='하자이행 보증금율을 입력해주세요.';return;}
if(oData.Shippingaddress == '' || oData.Shippingaddress == null){errMsg='배송주소을 입력해주세요.';return;}
if(oData.manager == '' || oData.manager == null){errMsg='수령담당자을 입력해주세요.';return;}
//if(oData.etc == '' || oData.etc == null){errMsg='기타사항을 입력해주세요.';}

for(Integer i = 0; Prolist.size() > i ; i++){
if(Prolist[i].Quantity > SolList[i].Quantity__c){
errMsg = '발주수량은 견적수량보다 클 수 없습니다.';
return;
}

}
PageReference pdf = Page.OrderBookPagePdf;
pdf.getParameters().put('data',JSON.serialize(oData));

Attachment at = new Attachment(Name = '발주서_'+oData.Buyer+'_'+oData.BuyerManager+'_'+System.today().format()+'.pdf', IsPrivate = false, ParentId = Opid, Body = pdf.getContentAsPDF(), Description='OrderBook');
//insert at;
ContentVersion cv = new ContentVersion(Title = at.Name, PathOnClient = at.Name, VersionData = at.Body);
insert cv;
ContentVersion cvid = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id LIMIT 1];
ContentDocumentLink cl = new ContentDocumentLink(ContentDocumentId = cvid.ContentDocumentId, LinkedEntityId = Opid, ShareType = 'V');
insert cl;
sendemail(at);   

}catch(Exception e){
errMsg = e.getMessage() + '/' + e.getLineNumber();
}
}
// 미리보기
public void preview(){

oData.ProductList = Prolist;
if(dateop.QualifiedDt__c != null){oData.Orderdate = dateop.QualifiedDt__c.year() + '.' + dateop.QualifiedDt__c.month()+'.'+dateop.QualifiedDt__c.day();}

PageReference prepdf = Page.OrderBookPagePdf;
prepdf.getParameters().put('data',JSON.serialize(oData));
pdfurl = prepdf.getUrl();

}
public class OrderBookPagePdf {
public Boolean pdf{get;set;}
public String pdfdata{get;set;}
public void init(){
pdfdata = ApexPages.currentPage().getParameters().get('data');
pdf= true;
oData  = (OrderBookPage.orderbookData) JSON.deserialize(pdfdata, OrderBookPage.orderbookData.class);     

}

public OrderBookPage.orderbookData oData{
get{if(oData == null){oData = new OrderBookPage.orderbookData();}return oData;}
set;
}
}

<script>

function cal(){
CalFunction(); 
//calcomma();
}
function calcomma(){
var ProTb = j$("[id$='ProTb']");
var realsum = j$("[id$='realsum']");
var Totalsum = 0;
j$(ProTb).find("[id$='no']").each(function() {
//if(j$(this).val() == ){
var Quantity = j$(this).parent().parent().find("[id$='Quantity']").val();
var Price = j$(this).parent().parent().find("[id$='Price']").val();
j$(this).parent().parent().find("[id$='Total']").text(commaSplit(removeComma(Quantity)*removeComma(Price)));
Totalsum += removeComma(Quantity)*Price;
j$(this).parent().parent().find("[id$='Quantity']").val(commaSplit(Quantity));
j$(this).parent().parent().find("[id$='Price']").val(commaSplit(Quantity));
//}
});

realsum.text(commaSplit(Totalsum));
}
function commaSplit(n) {

var txtNumber = '' + n;
var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
var arrNumber = txtNumber.split('.');
arrNumber[0] += '.';
do {
arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
}
while (rxSplit.test(arrNumber[0]));
if(arrNumber.length > 1) {
return arrNumber.join('');
} else {
return arrNumber[0].split('.')[0];
}
}
function removeComma(n) {  // 콤마제거
if ( typeof n == "undefined" || n == null || n == "" ) {
return "";
}
var txtNumber = '' + n;
return txtNumber.replace(/(,)/g, "");
}

/*
function cal2(No){
var ProTb = j$("[id$='ProTb']");
var TotalSumSet = j$("[id$='TotalSumSet']");
var TotalSum =j$("[id$='TotalSum']");
var sumTotal = 0;
console.log('No : ' + No);
console.log('ProTb : '+ ProTb);
j$(ProTb).find("[id$='no']").each(function() {
var Quantity = j$(this).parent().parent().find("[id$='Quantity']").val();
var Price = j$(this).parent().parent().find("[id$='Price']").val();
var Total = j$(this).parent().parent().find("[id$='Total']").val();

var calTotal = Quantity*Price;
sumTotal += calTotal;
j$(this).parent().parent().find("[id$='TotalSet']").text(calTotal);
j$(this).parent().parent().find("[id$='Total']").val(calTotal);

TotalSumSet.text(sumTotal);
TotalSum.val(sumTotal);

});
}

function setContact(){
setCnt();
}
function complete(msg){
if(msg == ''){
alert('발주서 전송 완료되었습니다.');
window.opener.location.href='{!URLFOR($Action.Opportunity.View,Opid)}';
window.close();
}else{
alert(msg);
}
}
function pdfPreview(url){
window.open(url,'PDF Preview','width=800,height=600,scrollbars=yes');
}
</script>

<apex:form id="mainFrm">
<apex:actionFunction name="doSave" action="{!doSave}" status="blockUI" rerender="mainFrm" />
<apex:pageblock id="PageBlock">
<apex:pageBlockButtons location="top">
<apex:commandButton value="{!$Label.COM_BTN_Save}" rerender="false" onclick="doSavePre();" rendered="{!NOT(isPageError)}"/>
<apex:commandButton value="{!$Label.COM_BTN_Close}" rerender="false" onclick="doClosePop();"/>
</apex:pageBlockButtons>

<apex:pageMessages id="pageMessages"/>  <!--메세지 -->

<apex:repeat value="{!dataList}" var="row" rendered="{!NOT(isPageError)}">
<apex:pageBlockSection title="{!row.data.Header__c}" columns="2" showHeader="true">
<apex:repeat value="{!row.fsms}" var="f" >
<apex:pageBlockSectionItem rendered="{!NOT(f.isField)}">
<apex:outputLabel value=""/>
<apex:outputText value=""/>	
</apex:pageBlockSectionItem>
<!--
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.05.23  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크 (추가요청사항) 삼판매출 DISABLE
-->
<apex:inputfield value="{!Opportunity[f.field]}" required="{!OR(f.field.required, f.field.dbrequired)}" rendered="{!f.isField && f.field != 'SamsungsalesRevenue__c'}"/>
<apex:outputField value="{!Opportunity[f.field]}" rendered="{!f.isField && f.field == 'SamsungsalesRevenue__c'}"/>
</apex:repeat>
</apex:pageBlockSection>
</apex:repeat>
</apex:pageblock>
<script>
if({!isSaved}==true) doSaveComplete();
</script>

</apex:form>
<!--
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.04.30  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크
-->
<apex:form id="mainFrm2">
<apex:pageBlock title="사전 활동 계획서"  rendered="{!IsContribute==true}" id="fileblock">
<apex:inputFile value="{!objAttachment.body}" filename="{!objAttachment.name}" />
<apex:commandButton action="{!plus}" value="추가"/>
<apex:pageBlockTable value="{!attachList}" var="f" id="filetable">
<apex:column headerValue="삭제">
<apex:commandLink action="{!doDeleteAttachment}" value="delete" onclick="return confirm('Are you sure?');">
<apex:param name="rowIndex" value="{!f.atch.Id}" assignTo="{!rowId}"/>
</apex:commandLink>
</apex:column>
<apex:column headerValue="제목">
<apex:outputLink value="{!URLFOR($Action.Attachment.Download, f.atch.id)}" target="_blank">{!f.atch.name}</apex:outputLink>
</apex:column>
<apex:column >
<apex:facet name="header">Last Modified</apex:facet>
<apex:outputField value="{!f.atch.LastModifiedDate}" style="width:90%;"/>
</apex:column>                        
</apex:pageBlockTable>
</apex:pageBlock>
</apex:form>
</apex:define>
</apex:composition>
</apex:page>

/****************************************************************************************
* File Name   : OpportunityOptionsEdit
* Description : Opportunity 옵션 저장
* Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
* Author      : kichang.heo
* Test 		: OpportunityOptionsEdit_Test
* Modification Log
* ===============================================================
* Ver  	Date 		Author 			Modification
* ===============================================================
1.0  	2016.06.23  kichang.heo 	Create
1.1  	2016.07.04	kichang.heo 	MultiSelect 로 변경에 따른 로직 변경 : ModelGroup
1.2  	2016.10.05	taiho0523 		Modify
1.3		2016.03.22	yohan.kang 		Mobile Option - Knox/BB Status가 3번째 Black~~이면 QtyBbReplacement__c 권한이 있는 곳이면 필수로 체크해야함
2.0		2018.04.30	hwangi.sim		기여BO저장시 첨부파일 유무 필수값 체크
****************************************************************************************/
    /*
public with sharing class OpportunityOptionsEdit extends CommonExtendController {

public final ApexPages.StandardController		sc;			// 표준 Controller
public Id oppId {get;set;}
public Opportunity Opportunity {get;set;}


public List<dataWrapper> dataList {get;set;}

private Boolean isPrintOption{get; set;}

public String pUrl {										// parentUrl
get {
return ApexPages.currentPage().getHeaders().get('referer');
}
set;
}

/**
* 생성자
*/
    /*
public OpportunityOptionsEdit(ApexPages.StandardController cont) {
this.sc = cont;
this.oppId = this.sc.getId();
system.debug('######## this.oppId:'+ this.oppId);
}

/**
* 초기화
*/
    /*
public void init() {
isPrintOption = false;

Opportunity opp = [SELECT Id, Name, ModelGp__c, Division__c , fm_X1stChannelSoldtoCd__c FROM Opportunity WHERE Id = :this.oppId LIMIT 1];

String modelGp = opp.ModelGp__c;
String division = opp.Division__c;
//		if(modelGp != null) {

// whitespace, '', null check	
if( String.isNotBlank(modelGp) || String.isNotBlank(division)) {
String[] modelGroups = modelGp!=null ? modelGp.split(';') : new List<String>();
String[] divisionGroups = division!=null ? division.split(';') : new List<String>(); 

//modelGroups.add('360CST');
//divisionGroups.add('MP3');

String[] totalGroup = new List<String>();
totalGroup.addAll(modelGroups);
totalGroup.addAll(divisionGroups); 

if(totalGroup.size() > 0) {
// multipicklist를 문자열 조합 구성
String modelGpStr = String.join(totalGroup, ',');
String modelGpStr2 = '\''+String.join(totalGroup, '\',\'')+'\'';
System.debug('modelGpStr1 : ' + modelGpStr);
System.debug('modelGpStr2 : ' + modelGpStr2);
//'PHONE','HHP MD','WEARABLE','TABLET','MID','B_김치냉장고','INK';
dataList = new List<dataWrapper>();
List<fieldWrapper> fieldList = new List<fieldWrapper>();
Map<String, String> fieldSetMap = new Map<String, String>();
String fields = '';
String query = '';
query += ' SELECT ';
query += ' 	Id, 					';
query += ' 	ModelGroup__c, 			';
query += ' 	Division__c, 			';
query += ' 	Header__c, 				';
query += ' 	FieldSet__c,			';
query += ' 	Blank__c				';
query += ' FROM OpportunityManageProductOptions__c ';
query += ' 	WHERE Id!=null ';
query += ' 	AND ( ModelGroup__c includes ('+modelGpStr2+') OR Division__c includes ('+modelGpStr2+') )';

system.debug('@@@@@ OpportunityOptionsEdit query : ' + query);

List<OpportunityManageProductOptions__c> tempList = database.query(query);
for(OpportunityManageProductOptions__c ompo : tempList
//					[
//					SELECT 
//							Id, 					// ID
//							ModelGroup__c, 			// ModelGroup__c
//							Header__c, 				// Header
//							FieldSet__c,			// FieldSet
//							Blank__c				// Blank
//					FROM OpportunityManageProductOptions__c
//					WHERE ModelGroup__c IN : modelGroups
//					WHERE ModelGroup__c includes (:modelGp)
//					WHERE ModelGroup__c includes (:modelGpStr)
//					WHERE ModelGroup__c includes (:modelGpStr)
//					WHERE ModelGroup__c includes ('PHONE','HHP MD','WEARABLE','TABLET','MID','B_김치냉장고','INK')
//					]
) {
if(!fieldSetMap.containsKey(ompo.FieldSet__c)) {
fieldSetMap.put(ompo.FieldSet__c, ompo.FieldSet__c);
Schema.FieldSet fs = Schema.SObjectType.Opportunity.fieldSets.getMap().get(ompo.FieldSet__c);

if(ompo.FieldSet__c=='KR_PRT_Opt_Q') isPrintOption = true;
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.04.30  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크
// 기여매출이 존재하는 필드집합
if(ompo.FieldSet__c=='KR_Mobile_Opt_Q') IsContribute = true;

fieldList = new List<fieldWrapper>();
String[] blanks = null;
if(!Util.isNull(ompo.blank__c)) {
blanks = ompo.blank__c.split(',');
}
Integer ino = 1;
for(Schema.FieldSetMember f : fs.getFields()) {
fields += f.getFieldPath() + ', ';
if(blanks != null) {
for(String n : blanks) {
if(ino == Integer.valueOf(n)) {
fieldList.add(new fieldWrapper(false, Null));
ino++;
break;
}
}
}
fieldList.add(new fieldWrapper(true, f));
ino++;
}
dataList.add(new dataWrapper(ompo, fieldList));
}
}
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.05.23  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크 (추가요청사항) 
// 1. 판매처 코드(fm_X1stChannelSoldtoCd__c)가 C1L0로 시작하는경우 무조건 삼판매출(SamsungsalesRevenue__c)에 체크 요청 
//(기여매출(ContributeBO__c)에 체크된 경우, 기여매출 해제하고, 삼판매출 체크 저장)
String queryField = 'SELECT ' + fields + ' Id, Name, IsCompletePrintOption__c, Division__c, fm_IsGlobal__c, fm_X1stChannelSoldtoCd__c FROM Opportunity WHERE Id =: oppId LIMIT 1';
Opportunity = Database.query(queryField);
String salesCode = Opportunity.fm_X1stChannelSoldtoCd__c;
if(!String.isEmpty(salesCode) && salesCode.startsWith('C1L0') == true){
Opportunity.SamsungsalesRevenue__c = true; 
Opportunity.ContributeBO__c = false;
}
}
} else {
isPageError = true;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,Label.OPP_MSG_NotManagedOptionModel));
}
}
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.04.30  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크
/****************************************************************************************************
*   Attachment Wrapper
****************************************************************************************************/
    /*
public Boolean IsContribute{get; private set;}

public class AttachmentWrapper {
public Attachment atch{get; private set;}
public AttachmentWrapper(Attachment atchment){
this.atch = atchment;
}

}

public List<AttachmentWrapper> attachList {
get{
if(attachList == null){
attachList = new List<AttachmentWrapper>();
for(Attachment a : [SELECT Id, Name, ParentId, Description, LastModifiedDate FROM Attachment WHERE ParentId=:Opportunity.Id AND Description='System:OpportunityOptionsEdit']){
attachList.add(new AttachmentWrapper(a));    
}
}
return attachList;
}
set;
}


/****************************************************************************************************
*   올릴 첨부파일
****************************************************************************************************/
    /*
public Attachment objAttachment{
get{
if(objAttachment==null){
objAttachment = new Attachment();
}
return objAttachment;
}
set;
}
/****************************************************************************************************
*   추가
****************************************************************************************************/
    /*

public void plus(){
if(objAttachment.body != null && objAttachment.name != null){
objAttachment.ParentId = Opportunity.Id;
objAttachment.Description='System:OpportunityOptionsEdit';
insert objAttachment;
}
objAttachment = null;
attachList = null;

}

/****************************************************************************************************
*   파일 삭제
****************************************************************************************************/
    /*
public Id rowId{get;set;} //인덱스

public Void doDeleteAttachment() {
Boolean beforeContribute = [SELECT ContributeBO__c FROM Opportunity WHERE Id=:Opportunity.Id LIMIT 1].ContributeBO__c;
if(attachList.size() <= 1 && beforeContribute == true){
ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'기여매출 건은 사전활동계획서를 1건이상 첨부해야 합니다.'));
return;
}
for(AttachmentWrapper aa : attachList){
if(aa.atch.Id ==  rowId){
delete aa.atch;
break;
}
}
objAttachment = null;
attachList = null;
}
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.04.30  , HwanGi Sim - END

/**
* BO Option 저장
* /*
public Boolean isSaved{
get{if(isSaved==null) isSaved = false; return isSaved;}
set;
}
public PageReference doSave() {
try{
//프린터 품목군 추가 정보인 경우 AMPV 옵션정보를 다 입력했는지를 체크한다.
if(isPrintOption){
if(!isCompleteInputAmpvOption()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'AMPV 옵션정보를 모두 입력해야 합니다.'));
return null;
}
else Opportunity.IsCompletePrintOption__c = true;
}

//Division=='Mobile Phone' AND (KNOX_BB_Status__c=='KNOX trial/win' OR KNOX_BB_Status__c=='KNOX trial/win + Blackberry replacement') 
//이면 KNOX_License_QTY__c, KNOX_License_AMT_USD__c는 필수
if(Opportunity.fm_IsGlobal__c && Opportunity.Division__c<>null){
List<String> listStrDivisionUnit = Opportunity.Division__c.split(';');
Set<String> setStrDivisionUnit = new Set<String>();
setStrDivisionUnit.addAll(listStrDivisionUnit);
if(setStrDivisionUnit.contains('Mobile Phone')){
Boolean isError = false;
if(Opportunity.KNOX_BB_Status__c=='Blackberry replacement(Without KNOX)'){
if(Schema.SObjectType.Opportunity.fields.getMap().get('QtyBbReplacement__c').getDescribe().isUpdateable()){
if(Opportunity.QtyBbReplacement__c==null){
Opportunity.QtyBbReplacement__c.addError('BB Replacement Qty is Required when KNOX / BB Status is ' + Opportunity.KNOX_BB_Status__c);
isError = true;
}
}
}
else if(Opportunity.KNOX_BB_Status__c=='KNOX trial/win' || Opportunity.KNOX_BB_Status__c=='KNOX trial/win + Blackberry replacement'){

if(Opportunity.KNOX_License_QTY__c==null){Opportunity.KNOX_License_QTY__c.addError('KNOX License QTY is Required when KNOX / BB Status is ' + Opportunity.KNOX_BB_Status__c);
//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'KNOX License QTY is Required when KNOX / BB Status is ' + Opportunity.KNOX_BB_Status__c));
isError = true;	}
if(Schema.SObjectType.Opportunity.fields.getMap().get('KNOX_License_AMT_USD__c').getDescribe().isUpdateable()){
if(Opportunity.KNOX_License_AMT_USD__c==null){Opportunity.KNOX_License_AMT_USD__c.addError('KNOX License AMT USD is Required when KNOX / BB Status is ' + Opportunity.KNOX_BB_Status__c);
//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'KNOX License AMT USD is Required when KNOX / BB Status is ' + Opportunity.KNOX_BB_Status__c));
isError = true;}
}
}

if(isError) return null;
}
}
// **** 한국총괄ABC시스템 유지보수 과제 - 2018.04.30  , HwanGi Sim
// 44) 기여BO저장시 첨부파일 유무 필수값 체크
if(attachList.size() <= 0 && Opportunity.ContributeBO__c == true){
ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'기여매출 건은 사전활동계획서를 1건이상 첨부해야 합니다.'));
return null;
}

upsert Opportunity;
isSaved = true;
}
catch(Exception e){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
}
return null;
}

/****************************************************************************************************
*	AMPV옵션정보를 모두 입력했는지 확인
****************************************************************************************************/
    /*
private Boolean isCompleteInputAmpvOption(){
Boolean isReturn = true;
List<OpportunityLineItem> listOpportunityLineItem = database.query(getQry());
for(OpportunitylineItem obj:listOpportunityLineItem){
if(obj.Product2.GSCMColorTypeCode__c=='COLOR' && obj.AmpvColor__c==null) isReturn = false;
else if(obj.Product2.GSCMColorTypeCode__c=='MONO' && obj.AmpvMono__c==null) isReturn = false;
}

return isReturn;
}

private String getQry(){
String query = '';

query  = ' SELECT ';

query += ' Id';
query += '	, IsSetItem__c';
query += '	, ItemNo__c, ParentItemNo__c, ListPrice__c';
query += ' 	, Quantity';
query += ' 	, UnitPrice, TotalPrice';
query += '	, Product2.Name, Product2.ProductCode,ModelGroup__c';
query += '	, AmpvMono__c, AmpvColor__c ';
query += '	, Product2.GSCMColorTypeCode__c, Product2Id ';

query += ' FROM OpportunityLineItem';
query += ' WHERE OpportunityId=\'' + Opportunity.Id + '\'';
// 2016.10.5. 수정: PRODUCT_TYPE_CD__c 의 값을 Prodh__c값으로 수정 수식 필드 fm_Prodh__c
//query += ' AND Product2.PRODUCT_TYPE_CD__c =\'' + 'SET' + '\'';
query += ' AND Product2.fm_Prodh__c =\'' + 'S' + '\'';
query += ' AND IsSetItem__c=false';

system.debug(Logginglevel.DEBUG, '@@@ ListQuery ==> [' + query + ']');   

return query;
}

/**
* 데이터 필드 리스트.
*/
    /*
public class dataWrapper {
public OpportunityManageProductOptions__c	data	{get;set;}
public List<fieldWrapper> 					fsms 	{get;set;}

public dataWrapper(OpportunityManageProductOptions__c data, List<fieldWrapper> fsms) {
this.data = data;
this.fsms = fsms;
}
}

/**
* 데이터 필드 정보
*/
    /*
public class fieldWrapper {
public Boolean 					isField		{get;set;}
public Schema.FieldSetMember	field		{get;set;}

public fieldWrapper (Boolean isField, Schema.FieldSetMember fieldMember) {
this.isField	= isField;
this.field		= fieldMember;
}
}

public void testMe(Opportunity objOp) {
PageReference pageRef = Page.OpportunityOptionsEdit;
// PageReference pageRef = Page.OpportunityApprovalSubcontract_apr;
Test.setCurrentPage(pageRef);		

ApexPages.currentPage().getParameters().put('Id', objOp.Id);

System.debug(oppId);
System.debug(isSaved);
System.debug(dataList);
System.debug(pUrl);		

init();

doSave();	

isCompleteInputAmpvOption();
}
}
**/
    
}