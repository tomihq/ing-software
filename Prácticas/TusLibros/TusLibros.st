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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:18:19'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo|
	catalogo := OrderedCollection new.
	catalogo añadir: '1'.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:28:15'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo|

	catalogo := OrderedCollection new.
	catalogo añadir: '1'.
	
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:18:22'!
test004AgregaMásDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo|

	catalogo := OrderedCollection new.
	catalogo añadir: '1'.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito añadir: book.
	
	self assert: carrito cantLibros equals: 2.
	




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:19:49'!
test005ObtenerElementosEnElCarrito
	| carrito book catalogo book2 |

	catalogo := OrderedCollection new.
	catalogo añadir: '1'.
	catalogo añadir: '2'.
	
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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:30:00'!
test006NoSePuedeAgregarMenosDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo |

	catalogo := OrderedCollection new.
	catalogo añadir: '1'.
	
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
	instanceVariableNames: 'books catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 21:28:41'!
añadir: aBook
    | key value |
    key := aBook keys first.
    value := aBook at: key.
    
    (catalogo includes: key) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].

   (value <= 0) ifTrue: [self error: 'La cantidad de unidades del libro debe ser positiva'].
    
    
    books at: key put: value.

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
