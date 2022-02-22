public class KY {
    
    public String asdf{get;set;}
    
    public void doinit(){
        asdf = String.valueOf(solution('123456', 2));
        
    }
    public Integer solution(String num, Integer k){
        
        Integer sum;
        Integer numlength = num.length(); //문자열 길이
        Integer m = math.mod(numlength, k) == 0 ? numlength/k-1 : numlength/k; // 평균적으로 자를단위
        Integer mock = numlength/m; 
        Integer namug = math.mod(numlength, m);//마지막 단위
        Integer total = namug == 0 ? mock : mock+1; //총 list 갯수
        
        Integer realSum = 0;
        
        for(Integer i  = 1 ; i <  total ; i++){
            Integer nowSum = makeSum(i ,total ,m,  namug ,num);
            realSum  = realSum  > nowSum ? nowSum : realSum;   
        }
        
        return realSum;
    }
    
    public Integer makeSum(Integer order ,Integer total ,Integer m, Integer namug ,  String num){
        Integer sum= 0;
        Integer startNum = 0;
        Integer endNum = 0;
        
        for(Integer i  = 1 ; i <  total ; i++){
            Integer plus = m;
            if(order == i)  plus = namug;
            endNum = startNum + plus;
            sum += Integer.valueOf(num.substring(startNum, endNum));
            endNum = startNum;
            system.debug('i'+sum);
        }
        return sum;
    }
    
    
    
}