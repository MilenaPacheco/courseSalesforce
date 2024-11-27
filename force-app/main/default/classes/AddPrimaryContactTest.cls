@isTest
private class AddPrimaryContactTest {
    @isTest
    static void testQueueableInsertContacts() {
        // Insertar 50 cuentas con BillingState 'NY' y 50 con 'CA'
        List<Account> accountsNY = new List<Account>();
        List<Account> accountsCA = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accountsNY.add(new Account(Name = 'Test NY ' + i, BillingState = 'NY'));
            accountsCA.add(new Account(Name = 'Test CA ' + i, BillingState = 'CA'));
        }
        insert accountsNY;
        insert accountsCA;

        // Crear el contacto que será insertado
        Contact primaryContact = new Contact(FirstName = 'Primary', LastName = 'Contact', Email = 'primary@example.com');

        // Poner en cola la clase AddPrimaryContact para el estado 'CA'
        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(primaryContact, 'CA');
        System.enqueueJob(job);
        Test.stopTest();

        // Verificar que se insertaron los contactos solo para las cuentas en 'CA'
        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'primary@example.com'];
        System.assertEquals(50, insertedContacts.size(), 'Debe haber 50 contactos insertados para el estado CA');

        // Verificar que los contactos están asociados a las cuentas correctas
        Set<Id> accountIdsCA = new Map<Id, Account>([SELECT Id FROM Account WHERE BillingState = 'CA']).keySet();
        for (Contact contact : insertedContacts) {
            System.assert(accountIdsCA.contains(contact.AccountId), 'El contacto debe estar asociado a una cuenta de CA');
        }
    }
}