public class ctrl_orderbook {
    
    public string renderas {get;set;}
    public boolean pdf{get;set;}
    public List<pro> prolist {get;set;}
    public Integer order{get;set;}
    public Integer ordersum{get;set;}
    public Decimal sum{get;set;}
    
    
    public class orderbookData{
        
        public String Title{get;set;}
        public String Orderdate{get;set;}
        public String DeliveryTime{get; set;}
        public String Depositrate{get;set;}
        public String Delinquencyrate{get;set;}
        public String Freewarrantyperiod{get;set;}
        public String BondPerformanceDepositRate {get;set;}
        public String Paymentterms{get;set;}
        public String Shippingaddress{get;set;}
        public String manager{get;set;}
        public String etc{get;set;}
        public Decimal realsum{get;set;}
        
        /**
public String Spec{get;set;}
public String Quantity{get;set;}
public String Price{get;set;}
**/
        public List<pro> productlist{get;set;}
    }
    
    public orderbookData oData{
        get{
            if(oData == null){
                oData = new orderbookData();
            }
            return oData;
        }
        set;
    }
    
    public void init(){
        prolist = new List<pro>();
        prolist.add(new pro('pro1','spec1',0,1000,0));
        prolist.add(new pro('pro2','spec2',0,2000,0));
        prolist.add(new pro('pro3','spec3',0,3000,0));
        
        sum = 0;
        oData.productlist = new List<pro>();
    }
    // 발주내역	계산
    public void cal(){
        sum = 0;
        if(prolist.isEmpty() != true){
            for(pro pr : prolist){
                if(pr.Quantity > 0){
                    pr.Total = pr.Quantity*pr.Price;
                    sum += pr.Total;
                    oData.realsum = sum;
                }else{
                    return;
                }
            }
        }return;
        
    }
    
    public PageReference changepdf(){
        
        renderas = 'pdf';
        pdf= true;
        if(prolist.isEmpty() != true){
            for(pro pr : prolist){
                oData.productlist.add(pr);
            }    
        }
        system.debug('+++++++++++++++++++++++++++++++'+oData.productlist);        
        PageReference pdf = Page.orderbookpdf;
        pdf.getParameters().put('data',JSON.serialize(oData));
        insert new Attachment(Name = 'tesst.pdf', IsPrivate = false, ParentId = '0017F00000Rjn2E', Body = pdf.getContentAsPDF());
        return null;
        
    }
    public class pro{
        public String name{get;set;}
        public String spec{get;set;}
        public Decimal Quantity{get;set;}
        public Decimal Price {get;set;}
        public Decimal Total{get;set;}
        public pro(String na, String sp, Decimal qu, Decimal pr, Decimal to){
            this.name = na;
            this.spec = sp;
            this.Quantity = qu;
            this.Price = pr;
            this.Total = to;
        }
    }
}