# Software Incremental

## SentenceFinderMetodosClase
Primera versión del Stack con Sentence Finder.
El problema de esta versión es que se usan todos métodos de clase de Sentence Finder y eso produce que todos los métodos de clase requieran gran cantidad de parámetros para operar.
Esto fue realizado apropósito como motivación al patrón Object Method y la idea de que: ¿para qué quiero realizar instancias si me valen métodos de clase?

La respuesta es: para no pasar tantos parámetros. Muchas veces no nos interesa si algo tiene sentido que sea una instancia o no, sino que además, tenemos que ver cómo se utiliza si fuesen métodos de clase.

Además, en el find, notarán que hay validaciones del prefijo, lo cual, si usáramos instancias, esto no sucedería pues no realizaríamos una instancia de un objeto inválido (aka: incompleto).

No menos importante: el Iterador NO tiene sentido que este aparte, sino que el propio Stack deberia implementarlo. No obstante, en calse NO nos dejaron modificar el stack. Por eso, para solucionar ese requerimiento desacoplamos el SentenceFinder y creamos un iterador aparte.

## SentenceFinder completo
Esta versión soluciona los problemas de la anterior. 
SentenceFinder ahora se utiliza con métodos de instancia para ahorrar los parámetros.
Se sacó la validación del prefijo en el find pues esto se encarga de hacerlo el método de clase antes de instanciar un Sentence Finder.

No obstante, sigue teniendo el Iterador pues era una de las limitaciones iniciales dada por los profesores. En la proxima version, sera parte del Stack.

