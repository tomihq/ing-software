!classDefinition: #CarritoTest category: #TusLibros!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:14:40'!
test001CarritoComienzaVacio
	| carrito |
	carrito := Carrito new. 
	self assert: carrito cantLibros equals: 0.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:50:40'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo libros|
	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := Catalogo con: libros.
	
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:51:14'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo libros|

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new. "isbn"
	book at: '2' put: 1.
	self should: [ carrito añadir: book ] 
       raise: Error withExceptionDo: [:anError | 
		self assert: carrito cantLibros equals: 0.
		self assert: (anError messageText = 'Libro no presente en el catálogo').
	].




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:51:27'!
test004AgregaMásDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo libros|

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 2.
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:50:12'!
test005ObtenerElementosEnElCarrito
	| carrito book catalogo book2 libros|

	libros := OrderedCollection new.
	libros add: '1'.
	libros add: '2'.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	book2 := Dictionary new.
	book2 at: '2' put: 3.
	
	carrito añadir: book.
	carrito añadir: book2.
	
	self assert: (carrito mostrarContenido) equals: '1 | 2 | 2 | 3'.
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:51:55'!
test006NoSePuedeAgregarMenosDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo libros |

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 0.
	
	self should: [carrito añadir: book] raise: Error withExceptionDo: [:anError |
		self assert:  (carrito cantLibros) equals: 0.
		self assert: (anError messageText = 'La cantidad de unidades del libro debe ser positiva').
	].
	




	
	
	
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'libros catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:50:56'!
añadir: aBook
    | isbn unidades |
    isbn := aBook keys first.
    unidades := aBook at: isbn.
    catalogo assertContieneLibroConIsbn: isbn.
  

   (unidades <= 0) ifTrue: [self error: 'La cantidad de unidades del libro debe ser positiva'].

    libros at: isbn put: unidades.

! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:22:15'!
cantLibros
    ^(libros values) inject: 0 into: [:sum :val | sum + val]
! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:30:46'!
catalogo: unCatalogo
	catalogo := unCatalogo.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:22:15'!
initialize
	libros := Dictionary new.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:22:15'!
mostrarContenido
    | stream first sortedKeys |
    stream := WriteStream on: String new.
    first := true.
    sortedKeys := (libros keys asSortedCollection). 
    sortedKeys do: [:key |
        first ifTrue: [ first := false ] ifFalse: [ stream nextPutAll: ' | ' ].
        stream nextPutAll: key asString.
        stream nextPutAll: ' | '.
        stream nextPutAll: (libros at: key) printString.
    ].
    ^stream contents
! !


!classDefinition: #Catalogo category: #TusLibros!
Object subclass: #Catalogo
	instanceVariableNames: 'libros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:49:07'!
assertContieneLibroConIsbn: unIsbn
 (libros includes: unIsbn) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:32'!
inicializarCon: unConjuntoDeLibros
	libros := unConjuntoDeLibros.! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:49:18'!
initialize
	libros := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogo class' category: #TusLibros!
Catalogo class
	instanceVariableNames: ''!

!Catalogo class methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:08'!
con: unConjuntoDeLibros
	^self new inicializarCon: unConjuntoDeLibros.! !
