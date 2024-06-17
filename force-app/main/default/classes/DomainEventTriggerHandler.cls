/**
 * This class serves as an entry points for specific domains to consume events in the Domain_Event__e channel
 */
public with sharing class DomainEventTriggerHandler {
    // All types of Domain events that this class handles
    public enum DomainEventType {
        ROLLUP_NUMBER_OF_EMPLOYEES
    }

    /**
     * group events' playloads by event type, then dispatch payload to consumers in appropriate domains
     * @return - void
     */
    public static void handleDomainEvent(){
        List<String> rollupNumberOfEmployeesPayloads = new List<String>();
        for(Domain_Event__e e: (List<Domain_Event__e>)Trigger.new){
            // collect specific event types' payloads
            if(DomainEventType.ROLLUP_NUMBER_OF_EMPLOYEES.name().equals(e.Type__c)){
                rollupNumberOfEmployeesPayloads.add(e.Payload__c);
            }
        }
        // dispatch specific collection of events payloads to appropriate domains
        dispatchRollupNumberOfEmployeesEventToAppropriateDomains(rollupNumberOfEmployeesPayloads);
    }

    /**
     * dispatch ROLLUP_NUMBER_OF_EMPLOYEES' event payloads to appropriate domains for consumption
     * @param payloads - payloads to dispatch to consumers
     * @return 
     */
    public static void dispatchRollupNumberOfEmployeesEventToAppropriateDomains(List<String> payloads){
        Set<Id> ids = new Set<id>();
        for(String payload: payloads){
            ids.addAll((Set<Id>) JSON.deserialize(payload, Set<Id>.class));
        }
        // Account Domain class consumes ROLLUP_NUMBER_OF_EMPLOYEES' event payload
        Accounts.setNumberOfAcmeEmployees(ids);
    }
}
