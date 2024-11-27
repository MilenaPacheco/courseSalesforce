public class StringListTest {
    public static List<String> generateStringList(Integer param) {
        // Inicializa una lista vacía de cadenas
        List<String> listStrings = new List<String>();
        
        // Bucle para llenar la lista con cadenas "Test n"
        for (Integer i = 0; i < param; i++) {
            listStrings.add('Test ' + i);
        }
        
        // Retorna la lista completa
        return listStrings;
    }
}