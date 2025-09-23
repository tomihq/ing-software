# Nota
Hay tres versiones: 
1. La primera es la que hice inicialmente solo con State pero que rompe encapsulamiento, poco declarativa, bastante rígida e instancia en cualquier lado el estado del Automobile.
2. La segunda utiliza State, ya no rompe encapsulamiento pero sigue estando el problema de que se pueden crear instancias desde cualquier lugar *(lo cual no es responsabilidad ni de cerca del vehiculo armarla bien)*, ahora de PowerOff y PowerOn pensados para ser vehículos genéricos.
3. La segunda utiliza State, y además Factory Method para realizar instancias de Power en un único lugar. Esto nso permite poder saber que si hay un problema con la creación de instancias está ahí. La seguridad que le da el FactoryMethod es que: si en algún momento necesitaras que tanto VehiclePowerOn/VehiclePowerOff requieran más parámetros, se rompería apropósito a menos que extiendas el factory method para aceptarlos. Esto te da la seguridad que solo créas instancias de esa familia en un único lugar. 
Además, ahora, tanto VehiclePowerOn/VehiclePowerOff son "hijas" de VehiclePowerStatus donde esta ultima tiene un colaborador interno vehicleToPower pues está siendo nombrada en el contexto con el rol que le cumple ahí.
Notar también que, como VehiclePowerOn/VehicePowerOff aceptan accelerate pues responden al estado del vehículo, VehiclePowerStatus delega la responsabilidad a estos, pues, VehiclePowerStatus no representa ningun estado lo cual no tiene sentido que haga algo al acelerar.
Tambien, ahora el vehiculo podría tener "varios estados" lo cual *state* es muy ambiguo. Ahora se lleva "powerStatus". 

La solución de los docentes tiene la pinta de la segunda (más reutilizable) aunque podría parecer un poco "flashera".

La primera versión, el problema que tiene es que, si bien está cumpliendo la abstracción de crear una clase para cada estado particular del automobil, no tiene sentido que un estado (si no tiene colaboradores internos propios) tenga la capacidad de modificar el vehículo directamente.
Esto tiene varios problemas:
1. Rompés encapsulamiento permitiendo a un state manipular tus colaboradores internos
2. Estás dando la responsabilidad a un componente de "AutomobileOn" y "AutomobileOff" de tener que poder saber qué tiene el Automobile y modificarlo directamente.
3. Estás atando el poder "acelerar" solamente a un automóbil a través de AutomobileOn. Además, estás "hardcodeando" el comportamiento solo para un automobile porque estás usando números hardcodeados. Tendría sentido hardcodear el número si fuese acelerar un Automobil, si fuese un helicóptero, tendría sentido que se haga el mismo cálculo? No. 
4. Estás creando "instancias" de AutomobileOff y AutomobileOn de manera descontrolada *(aunque no se note)* directamente en Automobile y configurandolas alli. ¿Qué sucedería si AutomobileOff/AutomobileOn requieren sí o sí de ciertos parámetros para ser inicializados? Necesitamos instanciarlos de manera segura. Para eso, podemos abstraer aún más con un Patrón Factory Method.
5. Estás ligando el comportamiento de prendido y apagado, y el estado de acelerar a un Automobile. 

La segunda versión, soluciona algunos problemas pero sigue teniendo otro *(no usa factory)*: 
Los estados siguen estando, pero ahora, puede ser cualquier vehículo *(al acelerar, el state correspondiente, llama al método del vehículo correspondiente. El estado, en este caso, no tiene la menor idea de qué es el efecto que sucede en el vehículo al ser acelerado.*). Además, se abstrajo la idea y ahora es VehiclePowerOn/VehiclePowerOff en vez de AutomobileOn y AutomobileOff.
Ya no hablamos de un "automobil" sino que puede acelerar cualquier vehículo.
El problema que persiste es que estamos configurando e instanciando VehiclePowerOff y VehiclePowerOn en cualquier lugar.

## Ejecución
Para probarlo, abrir un workspace y jugar con los métodos.
Recordar que los initialize de instancia se ejecutan una vez utilizado "new" junto a la clase a instanciar.

