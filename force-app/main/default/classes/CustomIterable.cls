public with sharing class CustomIterable implements Iterable<Account>{
    public Iterator<Account> iterator(){
        return new CustomIterator([select id, name from account]);
    }
}