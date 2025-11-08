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

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:17:16'!
test002AgregarLibroDeCatalogoACarrito
	| carrito |
	carrito := Carrito new. 
	self assert: carrito cantLibros equals: 0.! !


!classDefinition: #Carrito category: #TusLibros!
Object subclass: #Carrito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'tomihq 11/8/2025 20:14:52'!
cantLibros
	^0.! !
