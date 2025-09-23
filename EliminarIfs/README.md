## Ejercicio 3
Este ejercicio se trataba de eliminar los type hardcodeados de Vehicle, y además, su forma de acelerar.

Lo que noté es que:
1. Cada vehículo particular, tenía su propia forma de disparar error al acelerarlo cual implica que cada uno debería implementar un acceleratePoweredOff.
2. Cada vehículo particular, tenía su propia forma de acelerar, lo cual implica que cada uno debería implementar acceleredPoweredOn.
3. Como Motorcycle no tiene más que Speed al igual que Helicopter, podemos simplemente dejarlo con 0 colaboradores y que solo herede los de su padre.
4. Como Helicopter tiene altitude además de Speed, basta con agregarlo como colaborador de instancia. Para que su valor sea inicializado de manera lógica, Helicopter debería tener un initialize que le ponga su valor en 0. Speed no hace falta porque lo hace Vehicle. El propio initialize de Helicopter deberá llamar a super initialize para que el helicóptero también aproveche la inicialización de vehicle del estado y la velocidad.
5. Para no perder encapsulamiento de ningún vehículo en general, necesitamos una clase que permita tener la instancia particular a acelerar o no. Esto lo vamos a conseguir haciendo que PowerStatus tenga un colaborador interno de vehicleToPower (nombrado bajo su rol en el contexto), y creando un método on: que nos permita realizar instancias de PowerOff/PowerOn de forma controlada.
6. PowerOn/PowerOff tendrán su propia acción cuando se haga accelerate. Como PowerStatus es agnóstico a un estado particular, no tiene sentido que determine qué hacer al acelerar el Vehicle.
Tanto PowerOn como PowerOff aprovecharán el vehicleToPower y ejecutarán el método correspondiente para acelerar cuando está prendido y cuando no respectivamente.
7. El initialize de Vehicle ya no necesita ningún type como colaborador pues ahora se puede instanciar directamente el Helicopter y Motorcycle por separado que ya determinan su comportamiento. Además, el estado ya no viene hardcodeado sino que usamos un método llamado self turnOff para reutilizarlo a lo largo de la aplicación si querémos "apagar el vehículo". Esto nos permite que a menos que se prenda, el vehículo no pueda acelerar.

La solución utiliza el patrón State (PowerOff/PowerOn) y el patrón Factory (PowerStatus on:). Además de haber cumplido la separación de responsabilidades para más de un vehículo.
