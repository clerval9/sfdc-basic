public with sharing class BatchTest implements Database.Batchable<Account> {
    public static Integer batch = 0;
    public Iterable<Account> start(Database.BatchableContext info){
        return new CustomIterable();
    }
    public void execute(Database.BatchableContext context, List<Account> scope){
        system.debug('Batch: '+ ++batch);
        system.debug('Scope size: '+ scope.size());
        for(Account acc: scope){
            system.debug(acc);
        }
    }
    public void finish(Database.BatchableContext context){

    }
}