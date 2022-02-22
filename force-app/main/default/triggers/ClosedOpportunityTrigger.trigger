trigger ClosedOpportunityTrigger on Opportunity (before insert,before update) {
    List<Opportunity> opList = new List<Opportunity>();
    for(Integer i  = 0 ; i < trigger.new.size() ;i++){
        if(Trigger.new[i].StageName == 'Closed Won')    {
            
            opList.add(Trigger.new[i]);
        }
    }
    
    List<Task> taskList = new List<Task>();
    for(Opportunity op : opList){
        Task ta = new Task();
        ta.Subject = 'Follow Up Test Task';
        ta.WhatId = op.Id;
        taskList.add(ta);
    }
    
    insert taskList;

}