public class scr {
    public String str{get;set;}
    public String var{get;set;}
    public String var2{get;set;}
    public  scr(){
        var = '';
        var2 = '';
    }
    public void goAction(){
        if(!String.isEmpty(str)) var = str;
        var = 'Action Start';
        system.debug('var : ' +  var);
        afteraction();
        
    }
    public void afteraction(){
        var2 = 'Afteraction End';
    }
}