public class opSc implements Schedulable {
    
    public void execute(SchedulableContext sc){
        opSc opsctest = new opSc(); 	//Schedule apex class name
        String sch = '0 05 11 0 ? 2018'; 															//schedule interval time
        system.schedule('opsctest', sch, opsctest); 						//system method to schedule apex class
          }
    /*
    public static String CRON_EXPR ='0 57 10 19 12 ? 2018' ;
     
    global static String scheduleIt() {
        opSc batchSc = new opSc();
        return System.schedule('Something Descriptive', CRON_EXPR, batchSc);
    }
    
    global void execute(SchedulableContext sc) {
        // This is good practice if you are likely to be processing a
        // lot of records at a time
        opBa batch = new opBa();
        Database.executeBatch(batch);
    }

*/


    
}