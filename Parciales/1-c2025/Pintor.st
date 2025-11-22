!classDefinition: #Pared category: #Pintor!
Object subclass: #Pared
	instanceVariableNames: 'pinturas area'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pared methodsFor: 'pared functions' stamp: 'tomihq 11/22/2025 13:36:52'!
agregarPintura: unaPintura
	pinturas  addLast: unaPintura.! !

!Pared methodsFor: 'pared functions' stamp: 'tomihq 11/22/2025 12:30:42'!
removerPintura: unaPintura
	pinturas remove: unaPintura.
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


!Pared methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 11:58:21'!
contieneTamañoPara: unaDimensionDePintura
	^area containsRect: unaDimensionDePintura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #Pintor!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 11:16:53'!
inicializarParedConExtension: unaExtension
	^self new initializeCon: unaExtension.! !


!classDefinition: #Pintor category: #Pintor!
Object subclass: #Pintor
	instanceVariableNames: 'pinturasSeleccionadas pared accionesADeshacer accionesARehacer'
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


!Pintor methodsFor: 'initializers' stamp: 'tomihq 11/22/2025 12:58:43'!
initialize
	pinturasSeleccionadas := OrderedCollection new.
	accionesADeshacer := OrderedCollection new.
	accionesARehacer := OrderedCollection new.! !

!Pintor methodsFor: 'initializers' stamp: 'tomihq 11/22/2025 11:18:48'!
initializeWithPared: unaPared
	pared := unaPared.
	super initialize.! !


!Pintor methodsFor: 'testing' stamp: 'tomihq 11/22/2025 11:46:49'!
hayPintura: unaPintura
	^pared contieneA: unaPintura.! !

!Pintor methodsFor: 'testing' stamp: 'tomihq 11/19/2025 23:49:58'!
tienePinturaSeleccionada: unaPinturaSeleccionada
	^pinturasSeleccionadas includes: unaPinturaSeleccionada.! !


!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/19/2025 23:49:32'!
cantidadPinturasSeleccionadas
	^pinturasSeleccionadas size.! !

!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/21/2025 15:07:38'!
sinPinturasSeleccionadas
	^self cantidadPinturasSeleccionadas  = 0.! !


!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:59:43'!
agregarAccionARehacer: unaAccion
	accionesARehacer addLast: unaAccion.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:37:52'!
agregarPinturaSeleccionada: unaPintura
	pinturasSeleccionadas addLast: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:10:22'!
cantidadPinturas: unaCantidadDePinturas
	^pared cantidadPinturas: unaCantidadDePinturas.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 13:03:46'!
colocarPintura: unaPinturaAColocar
	| accion |
	self assertDimensionesPinturaValidaDe: unaPinturaAColocar.
	(self hayPintura: unaPinturaAColocar) ifTrue: [^self error: self descripciónErrorPinturaConMismoOrigenYExtensión].
	
	accion := PintorAgregar pintura: unaPinturaAColocar para: self.
	accion realizar.
	accionesADeshacer addLast: accion.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 13:30:57'!
descripciónErrorNoHayAccionPorRehacer

	^ 'No hay acción por rehacer'! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 13:09:32'!
deshacer
	| accionADeshacer |
	accionesADeshacer ifEmpty: [^self error: self descripciónErrorNoHayAcciónADeshacer ].
	accionADeshacer := accionesADeshacer removeLast.
	accionADeshacer deshacer.
	accionesARehacer addLast: accionADeshacer! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 13:31:06'!
rehacer
	accionesARehacer ifEmpty: [^self error: self descripciónErrorNoHayAccionPorRehacer ].
	accionesARehacer removeLast realizar. ! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:38:48'!
removerPinturaSeleccionada: unaPintura
	pinturasSeleccionadas remove: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:41:56'!
seleccionarPintura: unaPinturaASeleccionar
	| accion |
	(pinturasSeleccionadas includes: unaPinturaASeleccionar) ifTrue: [^self error: self descripciónErrorPinturaYaSeleccionada]. "agregué esto porque sino el test no tenia sentido. El modelo le enseña. "
	accion := PintorSeleccionar una: unaPinturaASeleccionar para: self.
	accion realizar.
	
	accionesADeshacer addLast: accion.
	! !


!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:59:21'!
descripciónErrorDimensionDePinturaInválida

	^ 'Dimensiones de la pintura inválidas'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:05:22'!
descripciónErrorNoHayAcciónADeshacer

	^ 'No hay acción a deshacer'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:00:56'!
descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError

	^ 'El Pintor debe tener al menos dos pinturas seleccionadas para alinearlas'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:24:04'!
descripciónErrorPinturaConMismoOrigenYExtensión

	^ 'Ya existe una pintura con el mismo origen y extensión'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:00:45'!
descripciónErrorPinturaYaSeleccionada

	^ 'No se puede volver a seleccionar una pintura que ya seleccionaste'! !


!Pintor methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 11:59:21'!
assertDimensionesPinturaValidaDe: unaPintura
	(pared contieneTamañoPara: unaPintura) not ifTrue: [^self error: self descripciónErrorDimensionDePinturaInválida].! !

!Pintor methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 11:00:56'!
assertPintorTieneMasDeUnaPinturaSeleccionada
	pinturasSeleccionadas size < 2 ifTrue: [^self error: self descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError.].! !


!Pintor methodsFor: 'nil' stamp: 'tomihq 11/22/2025 13:12:28'!
pared
	^pared.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pintor class' category: #Pintor!
Pintor class
	instanceVariableNames: ''!

!Pintor class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 11:44:08'!
sobreParedDe: unaExtension
	^self new initializeWithPared: (Pared inicializarParedConExtension: unaExtension)! !


!classDefinition: #PintorAgregar category: #Pintor!
Object subclass: #PintorAgregar
	instanceVariableNames: 'pintura pintor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorAgregar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:27:32'!
deshacer
	pintor pared removerPintura: pintura.
	pintor agregarAccionARehacer: [self realizar].! !

!PintorAgregar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:02:00'!
inicializarCon: unaPinturaAColocar para: unPintor
	pintura := unaPinturaAColocar.
	pintor := unPintor.! !

!PintorAgregar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:11:25'!
realizar
	pintor pared agregarPintura: pintura.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAgregar class' category: #Pintor!
PintorAgregar class
	instanceVariableNames: ''!

!PintorAgregar class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 13:03:28'!
pintura: unaPinturaAColocar para: unPintor
	^self new inicializarCon: unaPinturaAColocar para: unPintor.! !


!classDefinition: #PintorSeleccionar category: #Pintor!
Object subclass: #PintorSeleccionar
	instanceVariableNames: 'pintura pintor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorSeleccionar methodsFor: 'initialization' stamp: 'tomihq 11/22/2025 12:35:20'!
inicializarPara: unaPintura para: unPintor
	pintura := unaPintura.
	pintor := unPintor.! !


!PintorSeleccionar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:26:59'!
deshacer
	pintor removerPinturaSeleccionada: pintura.
	pintor agregarAccionARehacer: [self realizar].! !

!PintorSeleccionar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 12:38:03'!
realizar
	pintor agregarPinturaSeleccionada: pintura.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorSeleccionar class' category: #Pintor!
PintorSeleccionar class
	instanceVariableNames: ''!

!PintorSeleccionar class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 12:34:59'!
una: pintura para: unPintor
	^self new inicializarPara: pintura para: unPintor.! !


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


!classDefinition: #PintorTest category: #Pintor!
TestCase subclass: #PintorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:32:52'!
test001PinturaQueContieneDimensionesInvalidasNoEsColocadaEnLaPared
	| area pintura pintor|
	pintura := Rectangle origin: 0@1 corner: 3@3.
	area := Pared inicializarParedConExtension: 3@1. 
	pintor := Pintor sobreParedDe: 3@2.
	
	self should: [pintor colocarPintura: pintura.]  raise: Error - MessageNotUnderstood withExceptionDo: [:error | 
			self deny: (pintor hayPintura: pintura).
			self assert: error messageText equals: pintor descripciónErrorDimensionDePinturaInválida 
	]
	
	! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:38:56'!
test002PinturaQueContieneDimensionesValidasEsColocadaEnLaPared
	| area pintura pintor|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	
	self assert: (pintor hayPintura: pintura).
	self assert: (pintor cantidadPinturas: 1).
	
	! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 12:03:24'!
test003PintorPuedeSeleccionarPinturasDeLaPared
	| pintura pintor pintura2 |
	
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pintura2 := Rectangle origin: 2@1 corner: 3@1.
	
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	pintor colocarPintura: pintura2.
	
	pintor seleccionarPintura: pintura.
	pintor seleccionarPintura: pintura2.
	
	self assert: pintor cantidadPinturasSeleccionadas equals: 2.
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:32:45'!
test004PintorNoPuedeSeleccionarUnaPinturaYaSeleccionada
	| pintura pintor |
	
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	
	pintor seleccionarPintura: pintura.
	self should: [pintor seleccionarPintura: pintura] raise: Error - MessageNotUnderstood  withExceptionDo: [:error | 
		self assert: pintor cantidadPinturasSeleccionadas equals: 1.
		self assert: error messageText equals: 'No se puede volver a seleccionar una pintura que ya seleccionaste'
	].
	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:32:39'!
test005PinturaQueContieneMismoOrigenYExtensionQueOtraQueEstaEnParedNoSePuedeAgregar
	|  area pintura pintura2 pintor|
	pintura := Rectangle origin: 0@0 corner: 2@1.
	pintura2 := Rectangle origin: 0@0 corner: 2@1.
	area := Rectangle origin: 0@0 corner: 3@2. 
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	
	self should: [pintor colocarPintura: pintura2.] raise: Error - MessageNotUnderstood withExceptionDo: [:error | 
		
		self assert: (pintor hayPintura: pintura).
		self assert: (pintor cantidadPinturas: 1).
		
	]
	
	! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:58'!
test006PintorPuedeAlinearPinturasALaDerecha
	    |  pintura pintor pintura2 |

	    pintura := Rectangle origin: 0@0 corner: 5@5.     
	    pintura2 := Rectangle origin: 5@3 corner: 10@10.    

	  
	    pintor := Pintor sobreParedDe: 20@20.
	    pintor colocarPintura: pintura.
	    pintor colocarPintura: pintura2.

	    pintor seleccionarPintura: pintura.
	    pintor seleccionarPintura: pintura2.

	    pintor alinearPinturasALaDerecha.


	    self assert: pintura equals: (Rectangle origin: 5@0 corner: 10@5).
	    self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:49'!
test007PintorPuedeAlinearPinturasALaIzquierda
	    |  pintura pintor pintura2 |
	   
	    pintura := Rectangle origin: 0@0 corner: 5@5.
	    pintura2 := Rectangle origin: 5@3 corner: 10@10. 
	    
	    pintor := Pintor sobreParedDe: 20@20.
	    pintor colocarPintura: pintura.
	    pintor colocarPintura: pintura2.
	    
	    pintor seleccionarPintura: pintura.
	    pintor seleccionarPintura: pintura2.
	    
	    pintor alinearPinturasAIzquierda.
	    

	    self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    self assert: pintura2 equals: (Rectangle origin: 0@3 corner: 5@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:42'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test008PintorSoloPuedeAlinearADerechaSiTieneMasDeUnaPinturaSeleccionada
	|  pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionarPintura: pintura.
	
	self should: [ pintor alinearPinturasALaDerecha ] raise: Error-MessageNotUnderstood withExceptionDo: [:exception |
	        self assert: exception messageText equals: pintor descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError .
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:38'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test009PintorSoloPuedeAlinearAIzquierdaSiTieneMasDeUnaPinturaSeleccionada
	|  pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionarPintura: pintura.
	
	self should: [ pintor alinearPinturasAIzquierda ] raise: Error  - MessageNotUnderstood withExceptionDo: [:exception |
	        self assert: exception messageText equals: pintor descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadasMensajeError .
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:34'!
test010PintorNoPuedeDeshacerSiNoHizoAcciones
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	self should: [pintor deshacer] 
	raise: Error - MessageNotUnderstood 
	withMessageText: pintor descripciónErrorNoHayAcciónADeshacer

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:27'!
test011PintorPuedeDeshacerSeleccionDePintura
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionarPintura: pintura.
	pintor deshacer.
	
	self assert: (pintor sinPinturasSeleccionadas).

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:22'!
test012PintorPuedeDeshacerAgregarPinturaALaPared
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer.
	
	self assert: (pintor cantidadPinturas: 0	).
	self deny: (pintor tienePinturaSeleccionada: pintura).

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:39:13'!
test013PintorNoPuedeRehacerSiNoHayAccionParaRehacer
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	self should:  [ pintor rehacer. ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
		self assert: anError messageText equals: pintor descripciónErrorNoHayAccionPorRehacer .
		self assert: (pintor cantidadPinturas: 1	).
		
	].
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:43:08'!
test014PintorPuedeRehacerAcciónDeSeleccionarPintura
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor seleccionarPintura: pintura.	
	pintor deshacer.
	pintor rehacer. 
	self assert: pintor cantidadPinturasSeleccionadas equals: 1.
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:41:37'!
test015PintorPuedeRehacerAcciónDeAgregarPinturaALaPared
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer.
	pintor rehacer. 
	self assert: (pintor cantidadPinturas: 1	).
	
	
	

	
	
	
	
! !
