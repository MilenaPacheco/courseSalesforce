public class AddPrimaryContact implements Queueable {
    private Contact primaryContact;
    private String stateAbbreviation;

    // Constructor que recibe el contacto y el estado
    public AddPrimaryContact(Contact contact, String stateAbbreviation) {
        this.primaryContact = (Contact) contact.clone(false); // Clonamos para evitar conflictos
        this.stateAbbreviation = stateAbbreviation;
    }

    // Método execute de la interfaz Queueable
    public void execute(QueueableContext context) {
        // Consultar cuentas con el estado especificado, máximo 200 registros
        List<Account> accounts = [
            SELECT Id, BillingState
            FROM Account
            WHERE BillingState = :stateAbbreviation
            LIMIT 200
        ];

        // Crear una lista de contactos a insertar
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : accounts) {
            Contact newContact = (Contact) primaryContact.clone(false); // Clonamos el contacto
            newContact.AccountId = acc.Id; // Asociamos el contacto con la cuenta
            contactsToInsert.add(newContact);
        }

        // Insertar los contactos
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}