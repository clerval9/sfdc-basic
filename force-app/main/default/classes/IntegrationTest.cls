@isTest
public with sharing class IntegrationTest {
    @isTest
    private static void testWhenContactEventThenSetAcmeEmployees(){
        Account positiveTestRecord = new Account(Name = 'Acme Inc');
        Account negativeTestRecord = new Account(Name = 'Random');
        insert new list<Account>{positiveTestRecord, negativeTestRecord};

        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'john doe', AccountId = positiveTestRecord.Id),
            new Contact(LastName = 'john doe2', AccountId = negativeTestRecord.Id)
        };

        Test.startTest();
            // test when new contact is inserted and related to Acme Inc; Also Asserts that no affect on other account records
            insert contacts;
            Test.getEventBus().deliver();
            //assert that NumberOfEmployees is updated on Account record with name 'Acme Inc' when a new contact record is linked to it
            system.assertEquals(1, [Select NumberOfEmployees FROM Account WHERE Id = :positiveTestRecord.Id].NumberOfEmployees, 'NumberOfEmployees field should have updated to 1');
            //assert that NumberOfEmployees is not set when account record is not 'Acme Inc'
            system.assertEquals(null, [Select NumberOfEmployees FROM Account WHERE Id = :negativeTestRecord.Id].NumberOfEmployees, 'NumberOfEmployees field should have updated to null');
            
            // test when contact get reparented to Acme Inc
            update new Contact(AccountId = positiveTestRecord.Id, Id = contacts[1].Id);
            Test.getEventBus().deliver();
            // assert that NumberOfEmployees is updated on 'Acme Inc' Account record when an existing Contact get reparented to it
            system.assertEquals(2, [Select NumberOfEmployees FROM Account WHERE Id = :positiveTestRecord.Id].NumberOfEmployees, 'NumberOfEmployees field should have updated to 2');

            // test when contact record gets deleted
            delete contacts[0];
            Test.getEventBus().deliver();
            // assert that NumberOfEmployees is updated on 'Acme Inc' Account record when its related contact record is deleted;
            system.assertEquals(1, [Select NumberOfEmployees FROM Account WHERE Id = :positiveTestRecord.Id].NumberOfEmployees, 'NumberOfEmployees field should have updated to 1');
            
            // test when contact record gets reparented
            update new Contact (Id = contacts[1].Id, AccountId = null);
            Test.getEventBus().deliver();
            // assert that NumberOfEmployees is updated on 'Acme Inc' Account record when all of its related contact record removed;
            system.assertEquals(0, [Select NumberOfEmployees FROM Account WHERE Id = :positiveTestRecord.Id].NumberOfEmployees, 'NumberOfEmployees field should have updated to 0');
        Test.stopTest();
    }
}
