public class DailyLeadProcessor implements Schedulable {
    // Método que se ejecutará cuando se programe la clase
    public void execute(SchedulableContext context) {
        // Consultar los primeros 200 registros de clientes potenciales con LeadSource vacío
        List<Lead> leadsToUpdate = [
            SELECT Id
            FROM Lead
            WHERE LeadSource = NULL
            LIMIT 200
        ];

        // Actualizar el LeadSource a 'Dreamforce'
        for (Lead lead : leadsToUpdate) {
            lead.LeadSource = 'Dreamforce';
        }

        // Realizar la actualización en la base de datos
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}