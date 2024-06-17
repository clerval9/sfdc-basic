public with sharing class ContactTriggerHandler {
    // events to be pushed to the Domain_Event__e channel
    static List<Domain_Event__e> events;

    // Handle Contact trigger events
    public static void handleTrigger(){
        events = new List<Domain_Event__e>();
        switch on Trigger.operationType {
            when AFTER_INSERT {
                produceDomainEvent(Trigger.new);
            }
            when AFTER_UPDATE {
                produceDomainEvent((Map<Id, Contact>) Trigger.oldMap, (Map<Id, Contact>) Trigger.newMap);
            }
            when AFTER_DELETE {
                produceDomainEvent(Trigger.old);
            }
            when else {
                //do nothing 
            }
        }
        // publish domain events
        EventBus.publish(events);
    }

    /**
     * produces Domain events for non Contact object domains
     * @param contacts - contact records in either after insert or after delete trigger contexts
     * @return void
     */
    public static void produceDomainEvent(List<Contact> contacts){
        Set<Id> contactIds = new Set<Id>();
        for(Contact c: contacts){
            contactIds.add(c.AccountId);
        }
        events.add(new Domain_Event__e(Type__c = DomainEventTriggerHandler.DomainEventType.ROLLUP_NUMBER_OF_EMPLOYEES.name(), Payload__c = JSON.serialize(contactIds)));
    }

    /**
     * produces Domain events for non Contact object domains
     * @param oldContacts - contact records in after update trigger context
     * @param newContacts - contact records in after update trigger context
     * @return void
     */
    public static void produceDomainEvent(Map<Id, Contact> oldContacts, Map<Id, Contact> newContacts){
        Set<Id> contactIds = new Set<Id>();
        for(Contact c: newContacts.values()){
            if(c.AccountId != oldContacts.get(c.Id).AccountId){
                contactIds.add(c.AccountId);
                contactIds.add(oldContacts.get(c.Id).AccountId);
            }
        }
        events.add(new Domain_Event__e(Type__c = DomainEventTriggerHandler.DomainEventType.ROLLUP_NUMBER_OF_EMPLOYEES.name(), Payload__c = JSON.serialize(contactIds)));
    }
}
