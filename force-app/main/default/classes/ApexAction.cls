public with sharing class ApexAction {

    @InvocableMethod(label='label')
    public static List<Integer> act(List<Account> objects) {
        // return [select id, name from account];
        return new List<Integer>{1,2,3,4,5};
    }
}