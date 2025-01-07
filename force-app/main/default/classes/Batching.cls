public with sharing class Batching implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
   public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('select id from account');
   }
   public void execute(Database.BatchableContext context, List<sObject> scope){

   }
   public void execute(System.SchedulableContext context){
       Database.executeBatch(new Batching(), 100););
   }
   public void finish(Database.BatchableContext context){

   }
}