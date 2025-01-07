public with sharing class ApexTutorial {
    String bob = 'any';
    public enum Season {ETE, AUTOMN, HIVER, PRINTEMPS}

    public static void nullCheckAndNullCoallesing(){
        Account acc = new Account (Name = 'Dum Dum');

        String testAccount = [select name from Account where id = '001000000012345']?.Name;

        System.debug((testAccount??acc.Name)?.countMatches('Dum'));
        System.debug(acc.Name);
    }
}