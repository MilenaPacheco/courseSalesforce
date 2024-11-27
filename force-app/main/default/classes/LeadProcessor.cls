public without sharing class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public Integer recordCount = 0; // Contador para registros procesados

    // Método 'start': Define la consulta SOQL para obtener los Leads
    public Database.QueryLocator start(Database.BatchableContext dbc) {
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }

    // Método 'execute': Actualiza los Leads procesados en el batch
    public void execute(Database.BatchableContext dbc, List<Lead> leads) {
        for (Lead l : leads) {
            l.LeadSource = 'Dreamforce';
        }
        update leads; // Actualiza los registros en la base de datos
        recordCount = recordCount + leads.size();
    }

    // Método 'finish': Ejecuta la lógica final del batch
    public void finish(Database.BatchableContext dbc) {
        System.debug('Batch completado. Total de registros procesados: ' + recordCount);
    }
}