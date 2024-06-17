/**
 * This is the Account domain class that maintains logics that directly impact account records
 * Any entry point to Account record other than Account trigger itself must go through this domain class
 */
public with sharing class Accounts {

    /**
     * filter for Acme Inc account and rollup the numberOfEmployees field
     * @param accountIds - Id of account records for which a contact record has been created, deleted or has been reparented
     * @return void
     */
    public static void setNumberOfAcmeEmployees(Set<Id> accountIds){
        // query contact record, aggregate the number of contact records by accountId filtered by accountIds and Account record Name of 'Acme Inc'
        List<Account> records2Update = new List<Account>();
        for(AggregateResult result:[SELECT AccountId, COUNT(ID) FROM Contact WHERE AccountId IN :accountIds AND Account.Name = 'Acme Inc' GROUP BY AccountId]){
            records2Update.add(new Account(Id = (Id) result.get('AccountId'), NumberOfEmployees = Integer.valueOf(result.get('expr0'))));
        }
        // In the scenario where all contact records under Acme Inc are deleted or reparented, the above query won't calculate its number of employees
        // below query will find those account records and set NumberOfEmployees to 0
        for(Account acc: [SELECT Id FROM Account WHERE Id IN :accountIds AND Id NOT IN :records2Update AND Name = 'Acme Inc']){
            records2Update.add(new Account(Id = acc.Id, NumberOfEmployees = 0));
        }
        update records2Update;
    }
}
