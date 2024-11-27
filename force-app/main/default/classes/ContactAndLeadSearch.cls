public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String stringSearch){
        List<List<sObject>> searchList = [FIND :stringSearch IN ALL FIELDS 
                                          RETURNING 
                                            Contact(Id, FirstName, LastName), 
                                            Lead(Id, FirstName, LastName)];
        return searchList;
    }
}