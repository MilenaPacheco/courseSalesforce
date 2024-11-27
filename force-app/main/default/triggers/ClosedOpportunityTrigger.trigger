trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskLists = new List <Task>();
    for(Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won'){
            Task taskList = new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id
            );
            taskLists.add(taskList);
        }
       }
        if(!taskLists.isEmpty()){
            insert taskLists;
        }
}