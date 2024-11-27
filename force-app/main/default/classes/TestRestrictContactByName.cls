@isTest
private class TestRestrictContactByName {
    @isTest static void validContactInsert(){
        Contact validContact = new Contact(FirstName ='Juana', LastName='Rodriguez');
        insert validContact;
        System.assertNotEquals(null, validContact.Id);
    }
    @isTest static void invalidContactInsert(){
        Contact invalidContact = new Contact(FirstName='Maria', LastName='INVALIDNAME');
        try {
        insert invalidContact;
        System.assert(false, 'El disparador debería haber lanzado un error y no permitir la inserción.');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'),
                      'El mensaje de error no coincide con el esperado.');
    }
        
    }
    
    @isTest static void validContactUpdate(){
        Contact contactUpdate = new Contact(FirstName ='Heidy', LastName='Roma');
        insert contactUpdate;
        contactUpdate.LastName = 'Parra';
        update contactUpdate;
        System.assertEquals('Parra', contactUpdate.LastName);
    }
    @isTest static void invalidContactUpdate(){
        Contact contactUpdate = new Contact(FirstName='Maria', LastName='INVALIDNAME');
        insert contactUpdate;
        contactUpdate.LastName = 'INVALIDNAME';
        try {
            update contactUpdate;
            System.assert(false, 'El disparador debería haber lanzado un error y no permitir la actualización.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'),
                          'El mensaje de error no coincide con el esperado.');
        }
        
    }
}