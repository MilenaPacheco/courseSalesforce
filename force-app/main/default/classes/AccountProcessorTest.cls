@isTest
private class AccountProcessorTest {
    @isTest
    static void testIsUpdate() {
        // Crear datos de prueba
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            accounts.add(new Account(Name = 'Test ' + i));
        }
        insert accounts;

        // Crear contactos asociados a las cuentas
        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id); // Agregar los IDs a la lista
            contacts.add(new Contact(FirstName = acc.Name, LastName = 'TestContact', AccountId = acc.Id));
        }
        insert contacts; // Insertar los contactos en la base de datos

        // Iniciar la prueba
        Test.startTest();
        AccountProcessor.countContacts(accountIds); // Llamar al método futuro
        Test.stopTest();

        // Verificar resultados
        List<Account> accs = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds];
        for (Account acc : accs) {
            System.assertEquals(1, acc.Number_of_Contacts__c, 'El número de contactos no coincide para la cuenta ' + acc.Id);
        }
    }
}