public class kakao {
    // height 4	width 5	[“CCBDE”, “AAADE”, “AAABF”, “CCBBF”]	14
    //  6	6	[“TTTANT”, “RRFACC”, “RRRFCC”, “TRRRAA”, “TTMMMF”, “TMMTTJ”]	15
    //'TTTANT', 'RRFACC', 'RRRFC', 'TRRRAA', 'TTMMMF', 'TMMTTJ'
    public Integer height{get;set;}
    public Integer width{get;set;}
    public String mainstring{get;set;}
    public List<String> mainlist{get;set;}
    public List<List<String>> sublist{get;set;}
    public Integer del{get;set;}
    public kakao(){
        del = 0;
        sublist = new List<List<String>>();
    }
    public void main(){
        height = 6;
        width = 6;
         
        String mainstring = 'TTTANT,RRFACC,RRRFCC,TRRRAA,TTMMMF,TMMTTJ';
        mainlist = mainstring.split(',');
        
        for(String s : mainlist){
            List<String> a = s.split('',0);
            sublist.add(a);
        }
        
        plusd(height,width,sublist);
        
        for(Integer h = 0 ; h < height-1 ; h++){
            for(Integer w = 0; w < width-1 ; w++){
                String itsmedown = sublist[h+1][w].substring(0,1);
                if(itsmedown=='0'){
                    sublist[h+1][w] += sublist[h][w];
                } 
            }
        }        
        
    }
    
    public void plusd(Integer height,Integer width, List<List<String>> sublist){
          for(Integer h = 0 ; h < height-1 ; h++){
            for(Integer w = 0; w < width-1 ; w++){
                String itsme = sublist[h][w].substring(0,1);
                String n1 = sublist[h][w+1].substring(0,1);
                String n2 = sublist[h+1][w].substring(0,1);
                String n3 = sublist[h+1][w+1].substring(0,1);
              
                if(itsme==n1&&itsme==n2&&itsme==n3){
                    sublist[h][w] += 'd';
                    sublist[h][w+1] += 'd';
                    sublist[h+1][w] += 'd';
                    sublist[h+1][w+1] += 'd';
                }
                if(sublist[h][w].substring(1,1) == 'd'){del+=1;}
            }
        }
    }
    public void deletearr(){
        
    }
}