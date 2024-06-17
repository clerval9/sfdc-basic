trigger DomainEventTrigger on Domain_Event__e (after insert) {
  DomainEventTriggerHandler.handleDomainEvent();
}