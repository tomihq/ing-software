Estamos incursionando en el mundo de los reproductores de contenido multimedia.

El reproductor será capaz de reproducir el siguiente tipo de contenido:
1. Música.
2. Vídeos.

Donde de cada uno nos interesa el **nombre**, la **duración** y el **autor**. 

En todo momento, se podrá agregar/quitar elementos de la cola del reproductor. 
1. Si se intenta quitar el elemento multimedia que está actualmente siendo reproducido se tendrá que eliminarse de la cola y quedarse en estado stand-by. Permitiendo al usuario presionar "play" en el reproductor para que se reproduzca el siguiente elemento.
2. Si se intenta quitar un elemento multimedia que no está siendo reproducido no pasa ningún efecto. 

El reproductor podrá *iniciarse* si tiene al menos un elemento en la cola. Si no se especifica qué contenido se quiere reproducir, el comportamiento por defecto del reproductor será reproducir el primer elemento de la queue. Por ahora, no es necesario que se permita ejecutar una multimedia que **no es la primera de la queue** 

El reproductor podrá pausarse *sólo* si hay un un archivo multimedia corriendo, y su tiempo de *ejecución* deberá congelarse, es decir, el tiempo no pasará. El archivo de multimedia "actual" permanece siendo el mismo.

El reproductor podrá stoppearse *sólo* si hay un archivo multimedia corriendo. En este caso, se elimina reinicia el estado del elemento multimedia como si nunca hubiese corrido.

El reproductor podrá permitir al usuario ir al siguiente elemento multimedia. Esto afectará al reproductor de la siguiente manera:
1. Se elimina el elemento previo de la queue.
2. Se resetea el estado del player con la información del nuevo elemento multimedia.

Queremos que el modelo nos enseñe, así que si el usuario hace una acción indebida informarlo con un error.
Por ejemplo: 
- Comenzar a reproducir sin tener elementos en la cola es un error.
- Pausar sin tener el reproductor corriendo es un error.
- Parar el reproductor sin tener el reproductor corriendo es un error.

Desde ya, el reproductor puede verse como una sucesión de estados: Stopped -> Running -> Paused -> Running -> Stopped los cuales el reproductor, en cada estado, podría hacer una acción diferente ante una misma consulta.



--

Queremos introducir playlists. No se puede modificar en absoluto lo anterior. 
Necesitamos que ahora el reproductor tenga un mensaje especial para recibir una playlist y que agregue a la cola todos los elementos multimedia que contiene.

-- 

