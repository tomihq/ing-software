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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:56:00'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo|
	catalogo := OrderedCollection new.
	catalogo add: '1'.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito add: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:59:44'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo|

	catalogo := OrderedCollection new.
	catalogo add: '1'.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new. "isbn"
	book at: '2' put: 1.
	self should: [ carrito add: book ] 
       raise: Error withExceptionDo: [:anError | self assert: carrito cantLibros equals: 0.].




	
	
	
	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:59:24'!
test004AgregaMásDeUnaUnidadDeUnLibroAlCarrito
	| carrito book catalogo|

	catalogo := OrderedCollection new.
	catalogo add: '1'.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito add: book.
	
	self assert: carrito cantLibros equals: 2.
	




	
	
	
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'books catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:57:40'!
add: aBook
    | key value |
    key := aBook keys first.
    value := aBook at: key.
    
    (catalogo includes: key) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].
    
    
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
