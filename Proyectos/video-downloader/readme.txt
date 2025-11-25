Summary
Queremos construir un pequeño sistema para descargar archivos desde distintos proveedores remotos, cada uno con una interfaz diferente.

El internet del usuario es lento, así que queremos realizar las descargas cuando realmente las solicite. Además de querer descargar el archivo **una única vez**

--
Iteración 1
Tenemos dos proveedores: A y B aunque podremos agregar más a futuro. 
El proveedor A contiene un mensaje "fetch" que recibe un nombre de un archivo y a dónde escribir el contenido. Asuma que el resultado es un buffer que eventualmente sería escribir un archivo en sistema.
El proveedor B contiene un mensaje "getFile" que recibe un nombre de un archivo y devuelve un RemoteFile que no es más que un nombre y un Stream.

Queremos sólamente utilizar un Downloader y un método download para descargar el archivo, sin preocuparnos dentro de ella *qué proveedor* eligió el cliente para usar.

En esta iteración se asume que el archivo se descarga apenas se hace
downloader download: fileName. El cliente **sabe** exactamente cómo se descarga y se descarga mil veces si quiere.

Considere utilizar Stubs para simular qué contenido descarga cada archivo.
Ej.: para 'file.txt' debería devolver un Stream que contenga el contenido de #('fileDownloaded').

--
Iteración 2
Queremos que la descarga se realice **solo** cuando el usuario "la solicite". Pero sin mostrarle a él cómo se hace la descarga y si realmente se hace.
Esto quiere decir que el cliente podrá mencionar un "download" pero no sabe si se descargó desde cero o vino el archivo desde un caché. 

En esta iteración se asume que todavía el usuario **conoce** a qué proveedor le va a pedir la información, y quién es el encargado de descargarlo.

-- 
Iteración 3
El usuario está cansado de tener que conocer los proveedores y solamente quiere utilizar un mensaje simple.
Algo como FileServiceDownloader download: 'file.txt'.

Como el usuario no especifica qué proveedor usar, se asume que este Service conoce a cada uno de ellos y puede buscar en cada uno de ellos el archivo solicitado. 

Por comodidad, se asume que todos los archivos están en todos los services, pero sí lo desea, puede hacer que no todos los tengan ¿qué cambiaría? 

En esta iteración se espera que tanto la descarga diferida, como el adaptador al servicio esté todo dentro de FileServiceDownloader, lo cual, hace la vida más simple del usuario final que saber de tecnicismos innecesarios.





