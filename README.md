# Overview of this codebase

> Link to this [README.md](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/README.md) file.
>
> Explore this readme before going through the code itself.
-------------------------------------------------------------------------

## Problem being solved

> Link to the [Code Challenge](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/trigger-challenge).

### First step

> - Before anything, review the test class that test for every use cases of the challenge.
> - Link to the [IntegrationTest](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/classes/IntegrationTest.cls) class.
> - This test validates that `Account.NumberOfEmployees` field is only set on `'Acme Inc'` account record.
> - The test also validates that `Account.NumberOfEmployees` field is set on `'Acme Inc'` account record.

### Second step

> - Ascertain that the above integration code runs successfully.
> - I have included an [Apex log file](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/apex-07Lak000002IcbxEAC.log) of the successful run of this test class.
> - Alternatively, you can deploy this package into a playground instance of salesforce and run the test class.

### Description of artifacts

[ContactTrigger.trigger](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/triggers/ContactTrigger.trigger)
: Consumes after insert, after update and after delete trigger events on contact object.

[ContactTriggerHandler.cls](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/classes/ContactTriggerHandler.cls)
: This class handles contact's trigger insert, update and delete events. It also produces Domain event for logics unrelated to the Contact Domain.

[Domain_Event__e](https://github.com/clerval9/sfdc-basic/tree/trigger_update_account_employees_field/force-app/main/default/objects/Domain_Event__e)
: This platform event is a channel for produced Domain events. It has a `Type__c` and `Payload__c` attributes. Example domain could be one produced by Contact trigger for logic on Account object.

[DomainEventTrigger.trigger](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/triggers/DomainEventTrigger.trigger)
: This trigger notifies the dispatcher that a new domain event is produced in the channel; so that the dispatch can orchestrate the dispatching of the event to their consumers.

[DomainEventTriggerHandler.cls](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/classes/DomainEventTriggerHandler.cls)
: This class dispatches domain events to appropriate consumer domains. Example domain event is the `ROLLUP_NUMBER_OF_EMPLOYEES` event which is produced when a contact record is created, deleted or re-parented.

[Accounts.cls](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/classes/Accounts.cls)
: This is the Account domain class that maintains logics that directly impact account records. Any entry point to Account record other than Account trigger itself must go through this domain class. For example, in this case, this class consumes the `ROLLUP_NUMBER_OF_EMPLOYEES` events by updating the `Account.NumberOfEmployees` field on `'Acme Inc'` account record.

[IntegrationTest.cls](https://github.com/clerval9/sfdc-basic/blob/trigger_update_account_employees_field/force-app/main/default/classes/IntegrationTest.cls)
: This is the integration test class to validate that this package satisfies the requirements.