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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:33:06'!
test002AgregarLibroPresenteEnCatalogoACarrito
	| carrito book catalogo|
	catalogo := OrderedCollection new.
	catalogo add: 1.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	book := 1. "isbn"
	
	carrito add: book.
	
	self assert: carrito cantLibros equals: 1.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:37:21'!
test003NoSeAdmiteAgregarLibroNoPresenteEnElCatalogoAlCarrito
	| carrito book catalogo|

	catalogo := OrderedCollection new.
	catalogo add: 1.
	
	carrito := Carrito new. 
	carrito catalogo: catalogo.
	
	book := 2. "isbn"
	self should: [ carrito add: book ] 
       raise: Error withExceptionDo: [:anError | self assert: carrito cantLibros equals: 0.].




	
	
	
	! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'books catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:31:41'!
add: aBook
	(catalogo includes: aBook) not ifTrue: [self error: 'Libro no presente en el catálogo']. 
	books add: aBook
	! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:24:56'!
cantLibros
	^books size.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:30:46'!
catalogo: unCatalogo
	catalogo := unCatalogo.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:25:20'!
initialize
	books := OrderedCollection new.! !
