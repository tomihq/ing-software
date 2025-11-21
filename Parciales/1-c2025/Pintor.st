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

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:58:28'!
"este test la idea era que me permita definir cual es la maxima extensión de la pared desde el 0@0"
test002ParedTieneUnAreaDefinidaBasadoEnSuExtension
	| pared area|
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	
	self assert: (pared area) equals:  area.
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:58:48'!
test003PinturaQueContieneDimensionesInvalidasNoEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle origin: 0@1 corner: 3@3.
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	
	self should: [pared colocarPintura: pintura.]  raise: Error withExceptionDo: [:error | 
			self assert: (pared cantidadPinturas: 0).
			self deny: (pared contieneA: pintura).
	]
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:59:01'!
test004PinturaQueContieneDimensionesValidasEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := self inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	self assert: (pared cantidadPinturas: 1).
	self assert: (pared contieneA: pintura).
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:59:12'!
test005PinturaQueContieneMismoOrigenYExtensionQueOtraQueEstaEnParedNoSePuedeAgregar
	| pared area pintura pintura2|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	pintura2 := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	
	pared := self inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	self should: [pared colocarPintura: pintura2.] raise: Error  withExceptionDo: [:error | 
		self assert: (pared cantidadPinturas: 1).
		self assert: (pared contieneA: pintura).
		
	]
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:59:24'!
test150NoSePuedeAlinearPinturasSiNoHayMasDeUnaPinturaSeleccionada
	| pared pintura pinturaSeleccionada |
	pintura := Rectangle origin: 0@0 corner: 2@1.
	
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:56:20'!
test001PintorPuedeSeleccionarPinturasDeLaPared
	| pared pintura pintor pintura2 |
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pintura2 := Rectangle origin: 2@1 corner: 3@1.
	
	pared := Pared inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	pared colocarPintura: pintura2.
	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	pintor seleccionarPintura: (pared obtenerPintura: pintura2).
	
	self assert: pintor cantidadPinturasSeleccionadas equals: 2.
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/20/2025 00:04:43'!
test002PintorNoPuedeSeleccionarUnaPinturaYaSeleccionada
	| pared pintura pintor |
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 2@0.
	
	pared := Pared inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	self should: [pintor seleccionarPintura: (pared obtenerPintura: pintura)] raise: Error  withExceptionDo: [:error | 
		self assert: pintor cantidadPinturasSeleccionadas equals: 1.
		].
	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/20/2025 23:26:36'!
test003PintorPuedeAlinearPinturasALaIzquierda
	| pared pintura pintor pintura2|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pared := Pared inicializarParedConExtension: 20@20.
	pared colocarPintura: pintura.
	pared colocarPintura: pintura2.
	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	pintor seleccionarPintura: (pared obtenerPintura: pintura2).
	
	pintor alinearPinturasAIzquierda.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 0@3 corner: 10@10)
	
	
	
	
	
! !


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

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/20/2025 00:00:23'!
initializeCon: unaExtension
	pinturas := OrderedCollection new.
	"origin es la esquina superior izquierda y corner el punto de la esquina inferior derecha"
	area := Rectangle origin: 0@0 corner: unaExtension.! !

!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/20/2025 00:40:04'!
obtenerPintura: unaPintura
	^pinturas detect: [:pintura | pintura == unaPintura].! !

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

!Pintor methodsFor: 'as yet unclassified' stamp: 'Tom 11/20/2025 23:26:07'!
"agarro posicion x minima de origen. Me la guardo."
alinearPinturasAIzquierda
	| minX |
	minX := (pinturasSeleccionadas collect: [:pintura | pintura origin x]) min.
	
	pinturasSeleccionadas do: [:pinturaSeleccionada | 
			pinturaSeleccionada setOrigin: (minX @ pinturaSeleccionada origin y) corner: (pinturaSeleccionada corner x @ pinturaSeleccionada corner y).
	].
	 ! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:49:32'!
cantidadPinturasSeleccionadas
	^pinturasSeleccionadas size.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:48:16'!
initialize
	pinturasSeleccionadas := OrderedCollection new.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/20/2025 00:03:40'!
seleccionarPintura: unaPinturaASeleccionar
	(pinturasSeleccionadas includes: unaPinturaASeleccionar) ifTrue: [^self error: 'No se puede volver a seleccionar una pintura que ya seleccionaste']. "agregué esto porque sino el test no tenia sentido. El modelo le enseña. "
	pinturasSeleccionadas addFirst: unaPinturaASeleccionar.! !

!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/19/2025 23:49:58'!
tienePinturaSeleccionada: unaPinturaSeleccionada
	^pinturasSeleccionadas includes: unaPinturaSeleccionada.! !
