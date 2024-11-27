@isTest
private class DailyLeadProcessorTest {
	@isTest
    static void testScheduledLeadUpdate(){
        // Insertar 200 Leads de prueba con LeadSource vacío
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            testLeads.add(new Lead(LastName='TestLead'+i, Company = 'Salesforce'));
        }
        insert testLeads;
        
        List<Lead> leadsBeforeUpdate = [SELECT Id, LeadSource FROM Lead Where LeadSource = NULL];
        System.assertEquals(200, leadsBeforeUpdate.size());
        
        Test.startTest();
        String cronExpression = '0 0 0 * * ?';
        System.schedule('Test DailyLeadProcessor', cronExpression, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> leadsAfterUpdate = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, leadsAfterUpdate.size(), 'Todos los Leads deben haber sido actualizados a LeadSource = Dreamforce');
    }
}