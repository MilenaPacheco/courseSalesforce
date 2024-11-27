public without sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> listId){
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :listId];
        for(Account acc: accounts){
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        update accounts;
    }
}