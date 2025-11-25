Objetivo general

Diseñar un pequeño sistema para descargar archivos desde distintos proveedores remotos, cada uno con su propia interfaz.
    Queremos:
	a. Poder agregar proveedores nuevos sin modificar el código existente.
	b. Cargar los archivos solo cuando sea necesario (descarga diferida).
	c. Evitar descargas repetidas (caché).
	d. Ocultar al usuario final los detalles técnicos de los proveedores.

Iteración 1 — Unificación de interfaces de descarga

Tenemos dos proveedores remotos:
Proveedor A
Expone el mensaje:
fetch: aFileName to: aStream
Recibe el nombre de un archivo y un Stream donde escribir su contenido.

Proveedor B
Expone el mensaje:
getFile: aFileName
Devuelve un objeto RemoteFile que contiene el nombre y un Stream con el contenido descargado.

--

Problema

Cada proveedor tiene su propia forma de descargar los archivos.
Queremos tener un único punto de acceso para descargar archivos:
downloader download: 'file.txt'

En esta iteración, la descarga se realiza inmediatamente cada vez que se llama a download:.
El cliente sabe qué proveedor usa, y puede descargar el mismo archivo muchas veces.

Se recomienda usar stubs para simular las descargas.
Por ejemplo, 'file.txt' puede “descargar” un Stream que contenga #('fileDownloaded').

--

Iteración 2 — Descarga diferida y caché

Ahora queremos que la descarga se realice solo cuando realmente se necesite, no cuando el usuario llame download.

Si el usuario pide el archivo muchas veces, solo debe descargarse la primera vez.
Las siguientes deben venir desde un caché interno del downloader.

El cliente sigue eligiendo explícitamente qué proveedor usar, pero ya no sabe si:
1. el archivo se acaba de descargar, o
2. vino del caché.

file := downloader download: 'file.txt'.   "Puede o no disparar la descarga real"

--

Iteración 3 — Servicio unificado

Ahora el usuario está cansado de conocer los proveedores específicos.
Quiere una interfaz única, simple, como:

FileServiceDownloader download: 'file.txt'


Este servicio debe:
1. Internamente conocer la lista de proveedores disponibles.
2. Buscar el archivo en cualquiera de ellos.
3. Aplicar automáticamente la descarga diferida.
4. Aplicar también el caché.


A elección del diseñador:
1. Podés asumir que todos los proveedores contienen todos los archivos, o
2. Podés hacer que algunos proveedores tengan archivos y otros no. En ese caso, el sistema debe buscar entre ellos y continuar si uno falla.
