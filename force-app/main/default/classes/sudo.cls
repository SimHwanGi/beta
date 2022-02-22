public class sudo {
    
    public List<List<Integer>> board{get;set;}
    public String comple{get;set;}
    public sudo(){
        comple = '아직은..';
        /*board = new List<List<Integer>>{
new List<Integer>{8,0,0,0,5,4,0,6,0},
new List<Integer>{0,0,5,0,7,0,0,0,3},
new List<Integer>{2,0,4,0,0,9,5,8,0},
new List<Integer>{6,7,0,0,0,2,0,0,4},
new List<Integer>{0,8,2,7,4,0,0,0,0},
new List<Integer>{4,0,0,6,0,0,7,2,8},
new List<Integer>{0,2,1,5,0,0,0,0,9},
new List<Integer>{3,0,0,4,2,0,8,0,0},
new List<Integer>{0,4,8,1,0,0,0,0,2}};*/
        board = new List<List<Integer>>{
            new List<Integer>{9,6,3,7,2,8,5,1,4},
                new List<Integer>{5,8,4,3,6,1,9,2,7},
                    new List<Integer>{1,2,7,4,5,9,8,3,6},
                        new List<Integer>{8,7,5,2,3,4,1,6,9},
                            new List<Integer>{2,9,6,1,7,5,3,4,8},
                                new List<Integer>{3,4,1,9,8,6,7,5,2},
                                    new List<Integer>{6,3,8,5,9,2,4,7,1},
                                        new List<Integer>{7,1,2,8,4,3,6,9,5},
                                            new List<Integer>{4,5,9,6,1,7,2,8,3}};
                                                
                                                
                                                }
    public void main(){
        
        
        
    }
    public void click(){
        comple = complete(board) ? '성공': '실패';      
    }
    public Boolean complete(List<List<Integer>> boards){
        Boolean row = true;
        Boolean col = true;
        Boolean seq = true;
        // row chk
        /*
for(List<Integer> ilist : boards){
if(!row) continue;
Integer rowSum = 0;
for(Integer i : ilist){
rowSum += i;
}
if(rowSum != 45) row = false;
}
*/
        
        for(Integer i  = 0 ; i < 9 ; i++){
            if(!row) continue;
            if(!col) continue;
            Integer rowSum = 0;
            Integer colSum = 0;
            for(Integer j  = 0 ; j < 9 ; j++)  {
                colSum += boards[j][i];
                rowSum +=  boards[i][j];
            }   
            system.debug('@@@ colSum' + colSum);
            system.debug('@@@ rowSum' + rowSum);
            
            if(rowSum != 45) row = false;
            if(colSum != 45) col = false;
        }
        
        for(Integer k = 2 ; k < 9; k+3){
            if(!seq) continue;
            for(Integer i  = k-2 ; i <= k ; i++){
                
                Integer seqSum1 = 0;
                Integer seqSum2 = 0;
                Integer seqSum3 = 0;
                
                for(Integer j  = 0 ; j < 9 ; j++)  {
                    if(j<=2) 	seqSum1 += boards[i][j];              
                    if(j<=5)	seqSum2 += boards[i][j];
                    if(j<=8)	seqSum3 += boards[i][j];
                }   
                if(seqSum1 != 45 || seqSum2 != 45 || seqSum3 != 45 ) seq = false;
            }
        }
        
        
        return row && col && seq;
    }
    
}