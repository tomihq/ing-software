Estamos incursionando en el mundo de los reproductores de contenido multimedia.
ITERACIÓN 1
El reproductor será capaz de reproducir el siguiente tipo de contenido *(pero se espera agregar más)*:
1. Música.
2. Vídeos.

Donde de cada uno nos interesa el **nombre**, la **duración** (en segundos) y el **autor**. Y del vídeo también la resolución.  

En todo momento, se podrá agregar/quitar elementos de la cola del reproductor. Considere que NO puede haber elementos repetidos en la cola. 
1. Si se intenta quitar el elemento multimedia que está actualmente siendo reproducido se tendrá que eliminarse de la cola y quedarse en estado stand-by. Permitiendo al usuario presionar "play" en el reproductor para que se reproduzca el siguiente elemento.
2. Si se intenta quitar un elemento multimedia que no está siendo reproducido no pasa ningún efecto. 

El reproductor podrá *iniciarse* si tiene al menos un elemento en la cola. Si no se especifica qué contenido se quiere reproducir, el comportamiento por defecto del reproductor será reproducir el primer elemento de la queue. Por ahora, no es necesario que se permita ejecutar una multimedia que **no es la primera de la queue** 

El reproductor podrá pausarse *sólo* si hay un un archivo multimedia corriendo, y su tiempo de *ejecución* deberá congelarse, es decir, el tiempo no pasará. El archivo de multimedia "actual" permanece siendo el mismo.

El reproductor podrá stoppearse *sólo* si el reproductor está en Running/Paused. En este caso, se elimina reinicia el estado del elemento multimedia como si nunca hubiese corrido.

El reproductor podrá permitir al usuario ir al siguiente elemento multimedia. Esto afectará al reproductor de la siguiente manera:
1. Se elimina el elemento previo de la queue.
2. Se resetea el estado del player con la información del nuevo elemento multimedia.

Queremos que el modelo nos enseñe, así que si el usuario hace una acción indebida informarlo con un error.
Por ejemplo: 
- Comenzar a reproducir sin tener elementos en la cola es un error.
- Pausar sin tener el reproductor corriendo es un error.
- Parar el reproductor sin tener el reproductor corriendo es un error.

Desde ya, el reproductor puede verse como una sucesión de estados: Stopped -> Running -> Paused -> Running -> Stopped los cuales el reproductor, en cada estado, podría hacer una acción diferente ante una misma consulta. Tome esto como una intuición pero no como una estrategia de resolución directa.

Por último, el usuario podrá adelantar o retroceder el archivo multimedia (Siempre que esté en Running / Paused). Asuma que recibe un número que representa "lo que le quedaría por terminar de reproducir el elemento multimedia una vez que se movió a X lugar". Ej.: Si la entrada es "10 * second" entonces, el usuario está queriendo ir hacia los últimos 10 * second del archivo multimedia. Esto es por fines prácticos para que no tenga que complejizar el modelo. 

--
ITERACIÓN 2
Queremos introducir playlists. No se puede modificar en absoluto lo anterior. 
Necesitamos que ahora el reproductor tenga un mensaje especial para recibir una playlist y que agregue a la cola todos los elementos multimedia que contiene.
La playlist tendrá un nombre y los siguientes tipos de elementos:
1. Playlists internas.
2. Vídeos y Canciones.

Recordar que "una playlist interna" no es más que un conjunto de vídeos y canciones.

-- 
ITERACIÓN 3
Queremos introducir reportes de los archivos multimedia que más han sido reproducidas por un usuario. Asuma que cuando el cliente instancia el Player y lo utiliza, está simulando que usted es el usuario.

Como podría haber diferentes tipos de reportes se pide **no implementarlos** directamente en el reproductor, sino que el reproductor "proporcione la información" a quién corresponda y según la necesite.

El reporte debería tener esta pinta:
'Oops, I did it again' Britney Spears played 32 times
'Complicated' Avril Lavigne played 20 times.

Considere que se considera "reproducido" cualquier elemento multimedia que haya pasado por el player y haya finalizado en algún momento.
No nos interesa de qué manera exporta el reporte, tranquilamente podría ser cualquier estructura de datos que usted considere eficiente.

Notar que cómo el Player no acepta elementos repetidos, de alguna manera tiene que extender los MultimediaElement ¿cómo puede garantizar que son exactamente los mismos, y llevar el conteo en el Player sin importar la instancia del MultimediaElement?
Pista: utilice un diccionario en Player que permita, por cada MultimediaElement, distinguir uno del resto. 'Oops, I did it again' instancia 1 = 'Oops, I did it again' instancia 2. En el diccionario ambos tienen la misma clave.
