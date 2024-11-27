@isTest
private class TestVerifyDate {
    @isTest static void IsWithinRange(){
        Date date1 = Date.newInstance(2024, 11, 1); 
        Date date2 = Date.newInstance(2024, 11, 20); 
        Date dateTest = VerifyDate.CheckDates(date1, date2);
        Date expectedDate = Date.today().addDays(20);
        System.assertEquals(date2,dateTest, 'Debería devolver date2 porque está dentro de los próximos 30 días.');
    }
    @isTest static void isOutRange(){
        Date date1 = Date.newInstance(2024, 11, 1); 
        Date date2 = Date.newInstance(2024, 12, 10); 
        Date dateTest = VerifyDate.CheckDates(date1, date2);
        Date expectedDate = Date.newInstance(2024, 11, 30);
        System.assertEquals(expectedDate,dateTest, 'Debería devolver ultimo da del mes porque no está dentro de los próximos 30 días.');
    }
    @isTest static void isOutMinorRange(){
        Date date1 = Date.newInstance(2024, 11, 1); 
        Date date2 = Date.newInstance(2024, 10, 10); 
        Date dateTest = VerifyDate.CheckDates(date1, date2);
        Date expectedDate = Date.newInstance(2024, 11, 30);
        System.assertEquals(expectedDate,dateTest, 'Debería devolver ultimo da del mes porque no está dentro de los próximos 30 días.');
    }
}