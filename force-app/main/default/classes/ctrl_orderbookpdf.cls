public class ctrl_orderbookpdf {
    public Boolean pdf{get;set;}
    String pdfdata = ApexPages.currentPage().getParameters().get('data');
    public ctrl_orderbook  cob = new ctrl_orderbook();  
    public void init(){
        
        pdf= true;
        oData  = (ctrl_orderbook.orderbookData) JSON.deserialize(pdfdata, ctrl_orderbook.orderbookData.class);     
        
    }

    public ctrl_orderbook.orderbookData oData{
        get{
            if(oData == null){
                oData = new ctrl_orderbook.orderbookData();
            }
            return oData;
        }
        set;
    }
    
}