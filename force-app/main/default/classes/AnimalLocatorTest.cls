@isTest
private class AnimalLocatorTest {
    @isTest
    static void testGetAnimalNameById() {
        // Configurar el simulador
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        // Caso exitoso
        String animalName = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken', animalName, 'El nombre del animal debe ser chicken');

        // Caso con ID inválido
        try {
            AnimalLocator.getAnimalNameById(-1);
            System.assert(false, 'Se esperaba una excepción para un ID negativo.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('El ID debe ser un número entero positivo.', e.getMessage());
        }

        // Caso con ID nulo
        try {
            AnimalLocator.getAnimalNameById(null);
            System.assert(false, 'Se esperaba una excepción para un ID nulo.');
        } catch (IllegalArgumentException e) {
            System.assertEquals('El ID debe ser un número entero positivo.', e.getMessage());
        }
    }
    
    @isTest
    static void animalLocatorTest() {
        // Configurar el simulador
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actual = AnimalLocator.getAnimalNameById(1);
        String expected = 'chicken';
        System.assertEquals(actual, expected);
    }

}