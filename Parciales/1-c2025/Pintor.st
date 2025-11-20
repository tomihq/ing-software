!classDefinition: #Pared category: #Pintor!
Object subclass: #Pared
	instanceVariableNames: 'pinturas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:11:38'!
cantidadPinturas: unaCantidadDePinturas
	^pinturas size = unaCantidadDePinturas.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:10:26'!
initialize
	pinturas := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #Pintor!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:08:50'!
inicializar
	^self new.! !


!classDefinition: #TestPared category: #Pintor!
TestCase subclass: #TestPared
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!TestPared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:08:43'!
inicializarPared
	^Pared inicializar! !

!TestPared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:11:14'!
test001LaParedArrancaSinPinturas
	| pared |
	pared := self inicializarPared.
	
	self assert: (pared cantidadPinturas: 0) equals: true.
	! !
