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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:16:56'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo|
	catalogo := Dictionary new.
	catalogo at: '1' put: 1.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:17:02'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo|

	catalogo := Dictionary new.
	catalogo at: '1' put: 1.
	
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:17:09'!
test004AgregaMásDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo|

	catalogo := Dictionary new.
	catalogo at: '1' put: 2.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 2.
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:17:34'!
test005ObtenerElementosEnElCarrito
	| carrito book catalogo book2 |

	catalogo := Dictionary new.
	catalogo at: '1' put: 2.
	catalogo at: '2' put: 3.
	
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:17:55'!
test006NoSePuedeAgregarMenosDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo |

	catalogo := Dictionary new.
	catalogo at: '1' put: 1.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 0.
	
	self should: [carrito añadir: book] raise: Error withExceptionDo: [:anError |
		self assert:  (carrito cantLibros) equals: 0.
		self assert: (anError messageText = 'La cantidad de unidades del libro debe ser positiva').
	].
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:16:33'!
test007NoSePuedeAgregarUnLibroQueNoTieneStock
	| carrito book catalogo |

	catalogo := Dictionary new.
	catalogo at: '1' put: 1.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	self should: [carrito añadir: book.] raise: Error withExceptionDo: [:anError |
		self assert:  (carrito cantLibros) equals: 0.
		self assert: (anError messageText = 'No hay stock suficiente del libro seleccionado').
	].
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'books catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:16:06'!
añadir: aBook
    | isbn unidades |
    isbn := aBook keys first.
    unidades := aBook at: isbn.
    
    (catalogo includesKey: isbn) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].

   (unidades <= 0) ifTrue: [self error: 'La cantidad de unidades del libro debe ser positiva'].
   ((catalogo at: isbn) < unidades) ifTrue: [self error: 'No hay stock suficiente del libro seleccionado']. 
    
    
    books at: isbn put: unidades.

! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:53:28'!
cantLibros
    ^(books values) inject: 0 into: [:sum :val | sum + val]
! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:30:46'!
catalogo: unCatalogo
	catalogo := unCatalogo.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:49:45'!
initialize
	books := Dictionary new.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:22:09'!
mostrarContenido
    | stream first sortedKeys |
    stream := WriteStream on: String new.
    first := true.
    sortedKeys := (books keys asSortedCollection). 
    sortedKeys do: [:key |
        first ifTrue: [ first := false ] ifFalse: [ stream nextPutAll: ' | ' ].
        stream nextPutAll: key asString.
        stream nextPutAll: ' | '.
        stream nextPutAll: (books at: key) printString.
    ].
    ^stream contents
! !
