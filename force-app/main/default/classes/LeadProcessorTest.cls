@isTest
private class LeadProcessorTest {
    @isTest
    private static void testBatchClass() {
        // Crear 200 Leads de prueba
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Conneck', Company = 'Salesforce'));
        }
        insert leads; // Insertar Leads en la base de datos

        // Iniciar la prueba
        Test.startTest();
        LeadProcessor lp = new LeadProcessor(); // Instanciar la clase batch
        Database.executeBatch(lp, 200); // Ejecutar el batch con un solo lote
        Test.stopTest();

        // Verificar que los Leads fueron actualizados
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Debe haber 200 Leads actualizados');
    }
}