public class pie {
    
    public final Decimal r = 5;
    public final Decimal r2 = 25;
    public String str{get;set;}
    public String str2{get;set;}
    public pie(){
        Decimal cd = calDist(makeMap());
        
        system.debug('원둘레' + cd*4);        
        system.debug('원둘레' + 2*3.14*r);
       
        str =String.valueOf(cd*4);
        str2 = String.valueOf(2*3.14*r);
    }
    public Map<Integer,List<Decimal>> makeMap(){
        Map<Integer,List<Decimal>> mapToDList = new Map<Integer,List<Decimal>>();
        Integer index = 0;
        
        Decimal d1 = 0;
        Decimal d2 = 0;
        Decimal d3 = 0;
        Decimal d4 = 0;
        
        Decimal d22 = 0;
        Decimal d44 = 0;
        List<Decimal> tempList = new List<Decimal>();
        
        while(d1 <= 5 || d3 <= 5){
            
            d22 = (25 >= (d1*d1)) ? r2 - (d1*d1) : (d1*d1)- r2;
            d2 = Math.sqrt(d22);
            d3 = d1 +0.01;
            d44 = (25 >= (d3*d3)) ? r2 - (d3*d3) : (d3*d3) - r2;
            d4 = Math.sqrt(d44);
            
            tempList.add(d1);
            tempList.add(d2);
            tempList.add(d3);
            tempList.add(d4);
            mapToDList.put(index, tempList.clone());
            index ++;
            d1 += 0.01;
            
        }
        
        return mapToDList;
    }
    public Decimal calDist(Map<Integer,List<Decimal>> qMap){
        
        Decimal sumDis = 0;
        for(Integer i : qMap.keySet()){
            
            List<Decimal> dList = qMap.get(i);
            Decimal w = dList[2] - dList[0];
            Decimal h = dList[1] - dList[3];
            system.debug('w' + w);
            system.debug('h' + h);
            
            
            sumDis += Math.sqrt(w*w+h*h); 
            system.debug('sumDis' + sumDis);
        }
        return sumDis;
        
    }
}