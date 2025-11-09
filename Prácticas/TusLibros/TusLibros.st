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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:25:02'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo libros|
	libros := Dictionary new.
	libros at: '1' put: 1.
	catalogo := Catalogo con: libros.
	
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:25:13'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo libros|

	libros := Dictionary new.
	libros at: '1' put: 1.
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:25:21'!
test004AgregaMásDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo libros|

	libros := Dictionary new.
	libros at: '1' put:2.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 2.
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:40:06'!
test005ObtenerElementosEnElCarrito
	| carrito book catalogo book2 libros|

	libros := Dictionary new.
	libros at: '1' put: 2.
	libros at: '2' put: 3.
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:25:48'!
test006NoSePuedeAgregarMenosDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo libros |

	libros := Dictionary new.
	libros at: '1' put: 1.
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:26:01'!
test007NoSePuedeAgregarUnLibroQueNoTieneStock
	| carrito book catalogo libros |

	libros := Dictionary new.
	libros at: '1' put: 1.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	self should: [carrito añadir: book.] raise: Error withExceptionDo: [:anError |
		self assert:  (carrito cantLibros) equals: 0.
		self assert: (anError messageText = 'No hay stock suficiente del libro seleccionado').
	].
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:50:24'!
test008AgregarLibroPresenteEnCatalogoACarritoDisminuyeStock
	| carrito book catalogo libros |

	libros := Dictionary new.
	libros at: '1' put: 3.
	catalogo := Catalogo con: libros.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	carrito añadir: book.
	
	
	self assert:  (carrito cantLibros) equals: 2.
	self assert: (catalogo stockDisponibleDeLibro: '1') equals: 1.
	
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'libros catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:44:01'!
añadir: aBook
    | isbn unidades |
    isbn := aBook keys first.
    unidades := aBook at: isbn.
    catalogo assertContieneLibroConIsbn: isbn.
  

   (unidades <= 0) ifTrue: [self error: 'La cantidad de unidades del libro debe ser positiva'].
   catalogo assertA: isbn b: unidades.
    
    catalogo a: isbn b: unidades.
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

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:45:42'!
a: unIsbn b: unaCantidadDeUnidades
	| unidadesActuales unidadesRestantes |
	unidadesActuales := libros at: unIsbn.
	unidadesRestantes := unidadesActuales - unaCantidadDeUnidades.
	libros at: unIsbn put: unidadesRestantes.
	! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:39:49'!
assertA: unIsbn b: unStockSolicitado
	((libros at: unIsbn) < unStockSolicitado) ifTrue: [self error: 'No hay stock suficiente del libro seleccionado']. ! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:35:02'!
assertContieneLibroConIsbn: unIsbn
 (libros includesKey: unIsbn) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:32'!
inicializarCon: unConjuntoDeLibros
	libros := unConjuntoDeLibros.! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:22:53'!
initialize
	libros := Dictionary new.! !

!Catalogo methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:46:36'!
stockDisponibleDeLibro: unIsbnDeUnLibro
	^ libros at: unIsbnDeUnLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogo class' category: #TusLibros!
Catalogo class
	instanceVariableNames: ''!

!Catalogo class methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:08'!
con: unConjuntoDeLibros
	^self new inicializarCon: unConjuntoDeLibros.! !
