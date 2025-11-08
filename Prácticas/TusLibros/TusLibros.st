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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:24:05'!
test002AgregarLibroDeCatalogoACarrito
	| carrito book|
	
	carrito := Carrito new. 
	book := 1. "isbn"
	
	carrito add: book.
	
	self assert: carrito cantLibros equals: 1.! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:24:17'!
add: aBook
	books add: aBook
	! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:24:56'!
cantLibros
	^books size.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:25:20'!
initialize
	books := OrderedCollection new.! !
