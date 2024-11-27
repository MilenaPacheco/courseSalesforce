public class AccountHandler {
    public static Account insertNewAccount(String nameAccount) {
        try {
            if (nameAccount == null ) {
                throw new DmlException('El nombre de la cuenta está vacío.');
            }

            Account acc = new Account(Name = nameAccount);

            insert acc;

            return acc;
        } catch (DmlException e) {
            System.debug('Error al insertar la cuenta: ' + e.getMessage());
            return null;
        }
    }
}