public class Jsoup_Test {
    //nop jsoup 안대네 ㅋㅋ
    public String urlarea{get;set;}
    public String result{get;set;}
    public void search(){
        Manufacture(urlarea);
    }
    
    public void Manufacture(String url){
        
        PageReference page = new PageReference(url);
        
        String allContent = page.getContent().toString(); 
        
        String src = allContent.substringAfter('<frame id=\"mainFrame\" name=\"mainFrame\" src=\"');
        
        String realSrc = src.substringBefore('\" scrolling=\"auto\"');
        //String realSrc = src.substringBefore('&redirect');
        
        String realurl = 'https://blog.naver.com' + realSrc;
        
		PageReference realpage = new PageReference(realurl);  
        
        result = realpage.getContent().toString(); 
        
    }
}