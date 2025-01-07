public with sharing class CustomIterator implements Iterator<Account>{
    List<Account> accs;
    Integer index;
    public CustomIterator(List<Account> accs){
        this.accs = accs;
        this.index = 0;
        system.debug('iterator size: ' + accs.size());
    }
    public boolean hasNext(){
        return index < accs.size();
    }
    public Account next(){
        return accs[index++];
    }
}