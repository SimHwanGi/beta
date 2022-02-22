trigger tri_Account on Account (before update) {
    
    if(Trigger.isBefore && Trigger.isUpdate){
        Set<Id> sel_acc = new Set<Id>();
        for(Integer i = 0 ; i < Trigger.size ; i++){
            if(Trigger.old[i].Rating != Trigger.new[i].Rating){
                sel_acc.add(Trigger.new[i].Id);
            }
        }
        if(!sel_acc.isEmpty()){
            List<Contact> cont = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN:sel_acc];
            for(Integer i = 0 ; i < cont.size() ; i++){
                for(Integer j = 0 ; j < Trigger.size ; j++){
                    if(cont[i].AccountId == Trigger.new[j].Id){
                        cont[i].LastName = Trigger.new[j].Rating + '/' + cont[i].LastName;   
                    }
                }
            }
            if(!cont.isEmpty()){
                update cont;
            }
        }
    }

}