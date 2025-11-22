!classDefinition: #Pared category: #Pintor!
Object subclass: #Pared
	instanceVariableNames: 'pinturas area'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pared methodsFor: 'pared functions' stamp: 'tomihq 11/19/2025 23:19:22'!
colocarPintura: unaPinturaAColocar
	(area containsRect: unaPinturaAColocar) not ifTrue: [^self error: 'Dimensiones de la pintura inválidas'].
	pinturas do: [:pintura | 
		(pintura = unaPinturaAColocar) ifTrue: [^self error: 'Ya existe una pintura con el mismo origen y extensión'].
	].
	pinturas addLast: unaPinturaAColocar.! !

!Pared methodsFor: 'pared functions' stamp: 'Tom 11/20/2025 23:59:44'!
removerPintura: unaPintura
	pinturas := pinturas select: [:pintura | (pintura = unaPintura) not].
	! !


!Pared methodsFor: 'initializers' stamp: 'tomihq 11/20/2025 00:00:23'!
initializeCon: unaExtension
	pinturas := OrderedCollection new.
	"origin es la esquina superior izquierda y corner el punto de la esquina inferior derecha"
	area := Rectangle origin: 0@0 corner: unaExtension.! !


!Pared methodsFor: 'testing' stamp: 'tomihq 11/19/2025 22:11:38'!
cantidadPinturas: unaCantidadDePinturas
	^pinturas size = unaCantidadDePinturas.! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/19/2025 23:06:46'!
contieneA: unaPintura
	^pinturas includes: unaPintura.! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/20/2025 00:40:04'!
obtenerPintura: unaPintura
	^pinturas detect: [:pintura | pintura == unaPintura].! !


!Pared methodsFor: 'accessing' stamp: 'tomihq 11/19/2025 23:00:15'!
area
	^area.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #Pintor!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'instance creation' stamp: 'tomihq 11/19/2025 23:00:01'!
inicializarParedConExtension: unaExtension
	^self new initializeCon: unaExtension.! !


!classDefinition: #Pintor category: #Pintor!
Object subclass: #Pintor
	instanceVariableNames: 'pinturasSeleccionadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pintor methodsFor: 'alignment' stamp: 'tomihq 11/21/2025 14:57:21'!
alinearPinturasAIzquierda
    | minX |
    self assertPintorTieneMasDeUnaPinturaSeleccionada.
    minX := (pinturasSeleccionadas collect: [:p | p origin x]) min.
    self alinearPinturasCalculandoOrigenHorizontalUsando: [:p | minX ].
! !

!Pintor methodsFor: 'alignment' stamp: 'tomihq 11/21/2025 14:40:17'!
"Usamos extent acá porque necesito preservar tamaños relativos. Si movés el rectángulo a la derecha pero el corner lo dejás igual, la estás acahicando en ancho.
Para eso, necesitamos modificar también el corner basado en el nuevo origen x + el extent actual.
extent = nuevoOrigen + extentVieja
 - Tomás"
alinearPinturasALaDerecha
    | maxX |
    self assertPintorTieneMasDeUnaPinturaSeleccionada.
    maxX := (pinturasSeleccionadas collect: [:p | p origin x + p extent x]) max.
    self alinearPinturasCalculandoOrigenHorizontalUsando: [:p | maxX - p extent x ].
! !

!Pintor methodsFor: 'alignment' stamp: 'tomihq 11/21/2025 14:16:52'!
"Usamos extent acá porque necesito preservar tamaños relativos. Si movés el rectángulo a la derecha pero el corner lo dejás igual, la estás acahicando en ancho.
Para eso, necesitamos modificar también el corner basado en el nuevo origen x + el extent actual.
extent = nuevoOrigen + extentVieja
 - Tomás"
alinearPinturasCalculandoOrigenHorizontalUsando: unBloque
     pinturasSeleccionadas do: [:p |
        | x |
        x := unBloque value: p.
        p setOrigin: x @ p origin y corner: (x @ p origin y) + p extent
    ].
! !


!Pintor methodsFor: 'initializers' stamp: 'tomihq 11/21/2025 15:14:23'!
initialize
	pinturasSeleccionadas := OrderedCollection new.! !


!Pintor methodsFor: 'testing' stamp: 'tomihq 11/19/2025 23:49:58'!
tienePinturaSeleccionada: unaPinturaSeleccionada
	^pinturasSeleccionadas includes: unaPinturaSeleccionada.! !


!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/19/2025 23:49:32'!
cantidadPinturasSeleccionadas
	^pinturasSeleccionadas size.! !

!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/21/2025 15:07:38'!
sinPinturasSeleccionadas
	^self cantidadPinturasSeleccionadas  = 0.! !


!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 11:05:22'!
descripciónErrorNoHayAcciónADeshacer

	^ 'No hay acción a deshacer'! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 11:00:45'!
descripciónErrorPinturaYaSeleccionada

	^ 'No se puede volver a seleccionar una pintura que ya seleccionaste'! !

!Pintor methodsFor: 'pintor functions' stamp: 'Tom 11/20/2025 23:56:41'!
"esto claramente rompe encapsulamiento, y lo hago aproposito para hacer una categorizacion del efecto del undo - Tomás"
deshacerAccionAgregarPintura: unaPintura en: unaPared
	unaPared removerPintura: unaPintura
	! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/21/2025 15:06:26'!
deshacerAccionSeleccionarPintura: unaPintura
	pinturasSeleccionadas := pinturasSeleccionadas select: [:pintura | (pintura = unaPintura) not].! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 11:00:45'!
seleccionarPintura: unaPinturaASeleccionar
	(pinturasSeleccionadas includes: unaPinturaASeleccionar) ifTrue: [^self error: self descripciónErrorPinturaYaSeleccionada]. "agregué esto porque sino el test no tenia sentido. El modelo le enseña. "
	pinturasSeleccionadas addFirst: unaPinturaASeleccionar.! !


!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:00:56'!
descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError

	^ 'El Pintor debe tener al menos dos pinturas seleccionadas para alinearlas'! !


!Pintor methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 11:00:56'!
assertPintorTieneMasDeUnaPinturaSeleccionada
	pinturasSeleccionadas size < 2 ifTrue: [^self error: self descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError.].! !


!Pintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 11:05:42'!
deshacer
	^self error: self descripciónErrorNoHayAcciónADeshacer ! !


!classDefinition: #ParedTest category: #Pintor!
TestCase subclass: #ParedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/21/2025 14:58:21'!
test001LaParedArrancaSinPinturas
	| pared |
	pared := Pared inicializarParedConExtension: 3@2. 
	
	self assert: (pared cantidadPinturas: 0) equals: true.
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/21/2025 14:59:16'!
"este test la idea era que me permita definir cual es la maxima extensión de la pared desde el 0@0"
test002ParedTieneUnAreaDefinidaBasadoEnSuExtension
	| pared area|
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := Pared inicializarParedConExtension: 3@2.
	
	self assert: (pared area) equals:  area.
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/21/2025 14:59:19'!
test003PinturaQueContieneDimensionesInvalidasNoEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle origin: 0@1 corner: 3@3.
	area := Pared inicializarParedConExtension: 3@1. 
	pared := Pared inicializarParedConExtension: 3@2.
	
	self should: [pared colocarPintura: pintura.]  raise: Error withExceptionDo: [:error | 
			self assert: (pared cantidadPinturas: 0).
			self deny: (pared contieneA: pintura).
	]
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/21/2025 14:59:24'!
test004PinturaQueContieneDimensionesValidasEsColocadaEnLaPared
	| pared area pintura|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := Pared inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	self assert: (pared cantidadPinturas: 1).
	self assert: (pared contieneA: pintura).
	
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/21/2025 14:59:28'!
test005PinturaQueContieneMismoOrigenYExtensionQueOtraQueEstaEnParedNoSePuedeAgregar
	| pared area pintura pintura2|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	pintura2 := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	
	pared := Pared inicializarParedConExtension: 3@2.
	pared colocarPintura: pintura.
	
	self should: [pared colocarPintura: pintura2.] raise: Error  withExceptionDo: [:error | 
		self assert: (pared cantidadPinturas: 1).
		self assert: (pared contieneA: pintura).
		
	]
	
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 10:59:58'!
test002PintorNoPuedeSeleccionarUnaPinturaYaSeleccionada
	| pared pintura pintor |
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pared := Pared new initializeCon: 3@2.
	pared colocarPintura: pintura.
	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	self should: [pintor seleccionarPintura: (pared obtenerPintura: pintura)] raise: Error  withExceptionDo: [:error | 
		self assert: pintor cantidadPinturasSeleccionadas equals: 1.
		self assert: error messageText equals: 'No se puede volver a seleccionar una pintura que ya seleccionaste'
	].
	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/21/2025 01:17:14'!
test003PintorPuedeAlinearPinturasALaIzquierda
	    | pared pintura pintor pintura2 |
	    
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
	    self assert: pintura2 equals: (Rectangle origin: 0@3 corner: 5@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/21/2025 01:17:33'!
test004PintorPuedeAlinearPinturasALaDerecha
    | pared pintura pintor pintura2 |

    pintor := Pintor new.

    pintura := Rectangle origin: 0@0 corner: 5@5.     
    pintura2 := Rectangle origin: 5@3 corner: 10@10.    

    pared := Pared inicializarParedConExtension: 20@20.
    pared colocarPintura: pintura.
    pared colocarPintura: pintura2.

    pintor seleccionarPintura: (pared obtenerPintura: pintura).
    pintor seleccionarPintura: (pared obtenerPintura: pintura2).

    pintor alinearPinturasALaDerecha.


    self assert: pintura equals: (Rectangle origin: 5@0 corner: 10@5).
    self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 11:00:56'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test005PintorSoloPuedeAlinearAIzquierdaSiTieneMasDeUnaPinturaSeleccionada
	| pared pintura pintor|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pared := Pared inicializarParedConExtension: 20@20.
	
	pared colocarPintura: pintura.	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	
	self should: [ pintor alinearPinturasAIzquierda ] raise: Error withExceptionDo: [:exception |
	        self assert: exception messageText equals: pintor descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError .
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 11:00:56'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test006PintorSoloPuedeAlinearADerechaSiTieneMasDeUnaPinturaSeleccionada
	| pared pintura pintor|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pared := Pared inicializarParedConExtension: 20@20.
	
	pared colocarPintura: pintura.	
	pintor seleccionarPintura: (pared obtenerPintura: pintura).
	
	self should: [ pintor alinearPinturasALaDerecha ] raise: Error withExceptionDo: [:exception |
	        self assert: exception messageText equals: pintor descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError .
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 10:50:27'!
test007PintorPuedeDeshacerAgregarPinturaALaPared
	| pared pintura pintor|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pared := Pared inicializarParedConExtension: 20@20.
	
	pared colocarPintura: pintura.	
	pintor deshacerAccionAgregarPintura: pintura en: pared.
	
	self assert: (pared cantidadPinturas: 0	).

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 10:50:13'!
test008PintorPuedeDeshacerSeleccionDePintura
	| pared pintura pintor|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pared := Pared inicializarParedConExtension: 20@20.
	
	pared colocarPintura: pintura.	
	pintor seleccionarPintura: pintura.
	pintor deshacerAccionSeleccionarPintura: pintura.
	
	self assert: (pintor sinPinturasSeleccionadas).

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 11:05:58'!
test009PintorNoPuedeDeshacerSiNoHizoAcciones
	| pared pintura pintor|
	pintor := Pintor new.
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pared := Pared inicializarParedConExtension: 20@20.
	
	self should: [pintor deshacer] 
	raise: Error - MessageNotUnderstood 
	withMessageText: pintor descripciónErrorNoHayAcciónADeshacer

	
	
	
	
! !
