!classDefinition: #Pared category: #Pintor!
Object subclass: #Pared
	instanceVariableNames: 'pinturas area'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:00:15'!
area
	^area.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:11:38'!
cantidadPinturas: unaCantidadDePinturas
	^pinturas size = unaCantidadDePinturas.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:19:22'!
colocarPintura: unaPinturaAColocar
	(area containsRect: unaPinturaAColocar) not ifTrue: [^self error: 'Dimensiones de la pintura inválidas'].
	pinturas do: [:pintura | 
		(pintura = unaPinturaAColocar) ifTrue: [^self error: 'Ya existe una pintura con el mismo origen y extensión'].
	].
	pinturas addLast: unaPinturaAColocar.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:06:46'!
contieneA: unaPintura
	^pinturas includes: unaPintura.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:57:10'!
initializeCon: unaExtension
	pinturas := OrderedCollection new.
	area := Rectangle center: 0@0 extent: unaExtension. ! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:35:41'!
obtenerPintura: unaPintura
	^pinturas detect: [:pintura | pintura = unaPintura].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #Pintor!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:00:01'!
inicializarParedConExtension: unaExtension
	^self new initializeCon: unaExtension.! !


!classDefinition: #Pintor category: #Pintor!
Object subclass: #Pintor
	instanceVariableNames: 'pinturasSeleccionadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:49:32'!
cantidadPinturasSeleccionadas
	^pinturasSeleccionadas size.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:48:16'!
initialize
	pinturasSeleccionadas := OrderedCollection new.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:48:34'!
seleccionarPintura: unaPinturaASeleccionar
	pinturasSeleccionadas addFirst: unaPinturaASeleccionar.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:49:58'!
tienePinturaSeleccionada: unaPinturaSeleccionada
	^pinturasSeleccionadas includes: unaPinturaSeleccionada.! !


!classDefinition: #ParedTest category: #Pintor!
TestCase subclass: #ParedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 22:58:11'!
inicializarParedConExtension: unaExtension
	^Pared inicializarParedConExtension: unaExtension! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:00:33'!
test001LaParedArrancaSinPinturas
	| pared |
	pared := self inicializarParedConExtension: 3@2.
	
	self assert: (pared cantidadPinturas: 0) equals: true.
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:00:46'!
"este test la idea era que me permita definir cual es la maxima extensión de la pared desde el 0@0"
test002ParedTieneUnAreaDefinidaBasadoEnSuExtension
	| pared area|
	area := Rectangle center: 0@0 extent: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	
	self assert: (pared area) equals:  area.
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:07:43'!
test003PinturaQueContieneDimensionesInvalidasNoEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle center: 0@1 extent: 3@3.
	area := Rectangle center: 0@0 extent: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	
	self should: [pared colocarPintura: pintura.]  raise: Error withExceptionDo: [:error | 
			self assert: (pared cantidadPinturas: 0).
			self deny: (pared contieneA: pintura).
	]
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:10:24'!
test004PinturaQueContieneDimensionesValidasEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle center: 0@0 extent: 2@1.
	area := Rectangle center: 0@0 extent: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	self assert: (pared cantidadPinturas: 1).
	self assert: (pared contieneA: pintura).
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:20:51'!
test005PinturaQueContieneMismoOrigenYExtensionQueOtraQueEstaEnParedNoSePuedeAgregar
	| pared area pintura pintura2|
	pintura := Rectangle center: 0@0 extent: 2@1.
	pintura2 := Rectangle center: 0@0 extent: 2@1.
	area := Rectangle center: 0@0 extent: 3@2. 
	
	pared := self inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	self should: [pared colocarPintura: pintura2.] raise: Error  withExceptionDo: [:error | 
		self assert: (pared cantidadPinturas: 1).
		self assert: (pared contieneA: pintura).
		
	]
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:38:39'!
test150NoSePuedeAlinearPinturasSiNoHayMasDeUnaPinturaSeleccionada
	| pared pintura pinturaSeleccionada |
	pintura := Rectangle center: 0@0 extent: 2@1.
	
	pared := self inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	pinturaSeleccionada := pared obtenerPintura: pintura.
	
	self assert: pinturaSeleccionada equals: pintura.
	
! !


!classDefinition: #PintorTest category: #Pintor!
TestCase subclass: #PintorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:50:57'!
test001PintorPuedeSeleccionarPinturaDeLaPared
	| pared pintura pintor |
	pintor := Pintor new.
	pintura := Rectangle center: 0@0 extent: 2@1.
	
	pared := Pared inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	
	self assert: pintor cantidadPinturasSeleccionadas equals: 1.
	self assert: (pintor tienePinturaSeleccionada: pintura) equals: true.
	
! !
