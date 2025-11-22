!classDefinition: #AcciónPintor category: #Pintor!
Object subclass: #AcciónPintor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!AcciónPintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:18:17'!
deshacer

	self subclassResponsibility! !

!AcciónPintor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:18:13'!
hacer

	self subclassResponsibility! !


!classDefinition: #PintorAgregar category: #Pintor!
AcciónPintor subclass: #PintorAgregar
	instanceVariableNames: 'pintura pintor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorAgregar methodsFor: 'hacer/deshacer' stamp: 'tomihq 11/22/2025 15:42:31'!
deshacer
	pintor removerPintura: pintura.! !

!PintorAgregar methodsFor: 'hacer/deshacer' stamp: 'tomihq 11/22/2025 15:42:35'!
hacer
	pintor agregarPintura: pintura.! !


!PintorAgregar methodsFor: 'initializations' stamp: 'tomihq 11/22/2025 13:02:00'!
inicializarCon: unaPinturaAColocar para: unPintor
	pintura := unaPinturaAColocar.
	pintor := unPintor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAgregar class' category: #Pintor!
PintorAgregar class
	instanceVariableNames: ''!

!PintorAgregar class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 13:03:28'!
pintura: unaPinturaAColocar para: unPintor
	^self new inicializarCon: unaPinturaAColocar para: unPintor.! !


!classDefinition: #PintorAlinear category: #Pintor!
AcciónPintor subclass: #PintorAlinear
	instanceVariableNames: 'pinturas originales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorAlinear methodsFor: 'initializations' stamp: 'tomihq 11/22/2025 14:52:59'!
initializeWith: unasPinturas
	pinturas := unasPinturas.! !


!PintorAlinear methodsFor: 'PintorAlinear functions' stamp: 'tomihq 11/22/2025 14:52:35'!
"Usamos extent acá porque necesito preservar tamaños relativos. Si movés el rectángulo a la derecha pero el corner lo dejás igual, la estás acahicando en ancho.
Para eso, necesitamos modificar también el corner basado en el nuevo origen x + el extent actual.
extent = nuevoOrigen + extentVieja
 - Tomás"
alinearPinturasCalculandoOrigenHorizontalUsando: unBloque
     pinturas do: [:p |
        | x |
        x := unBloque value: p.
        p setOrigin: x @ p origin y corner: (x @ p origin y) + p extent
    ].! !

!PintorAlinear methodsFor: 'PintorAlinear functions' stamp: 'tomihq 11/22/2025 15:21:46'!
deshacer
	pinturas with: originales do: [:unaPintura :unaOriginal | 
		unaPintura setOrigin: unaOriginal origin corner: unaOriginal corner.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAlinear class' category: #Pintor!
PintorAlinear class
	instanceVariableNames: ''!

!PintorAlinear class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 16:00:41'!
assertPintorTieneMasDeUnaPinturaSeleccionada: unasPinturas
	unasPinturas size < 2 ifTrue: [^self error: self descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadas .].! !

!PintorAlinear class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:57:18'!
descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadas
	^ 'El Pintor debe tener al menos dos pinturas seleccionadas para alinearlas'! !

!PintorAlinear class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:58:17'!
pinturas: unasPinturas
	self assertPintorTieneMasDeUnaPinturaSeleccionada: unasPinturas.
	^self new initializeWith: unasPinturas! !


!classDefinition: #PintorAlinearDerecha category: #Pintor!
PintorAlinear subclass: #PintorAlinearDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorAlinearDerecha methodsFor: 'hacer' stamp: 'tomihq 11/22/2025 15:21:09'!
hacer
    | maxX |
    maxX := (pinturas collect: [:p | p origin x + p extent x]) max.
    originales := pinturas collect: [:p | p copy].
    self alinearPinturasCalculandoOrigenHorizontalUsando: [:p | maxX - p extent x ].! !


!classDefinition: #PintorAlinearIzquierda category: #Pintor!
PintorAlinear subclass: #PintorAlinearIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorAlinearIzquierda methodsFor: 'hacer' stamp: 'tomihq 11/22/2025 15:21:09'!
hacer
    | minX |
    minX := (pinturas collect: [:p | p origin x]) min.
    originales := pinturas collect: [:p | p copy].

    self alinearPinturasCalculandoOrigenHorizontalUsando: [:p | minX ].
   
    ! !


!classDefinition: #PintorSeleccionar category: #Pintor!
AcciónPintor subclass: #PintorSeleccionar
	instanceVariableNames: 'pintura pintor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!PintorSeleccionar methodsFor: 'initialization' stamp: 'tomihq 11/22/2025 12:35:20'!
inicializarPara: unaPintura para: unPintor
	pintura := unaPintura.
	pintor := unPintor.! !


!PintorSeleccionar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:58:21'!
deshacer
	pintor removerPinturaSeleccionada: pintura.! !

!PintorSeleccionar methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:15:03'!
hacer
	pintor agregarPinturaSeleccionada: pintura.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorSeleccionar class' category: #Pintor!
PintorSeleccionar class
	instanceVariableNames: ''!

!PintorSeleccionar class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 12:34:59'!
una: pintura para: unPintor
	^self new inicializarPara: pintura para: unPintor.! !


!classDefinition: #HistorialAcciones category: #Pintor!
Object subclass: #HistorialAcciones
	instanceVariableNames: 'accionesADeshacer accionesARehacer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!HistorialAcciones methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 15:51:39'!
assertHayAccionesPorDeshacer
	accionesADeshacer ifEmpty: [^self error: self descripciónErrorNoHayAcciónADeshacer ].! !

!HistorialAcciones methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 15:52:12'!
assertHayAccionesPorRehacer
	accionesARehacer ifEmpty: [^self error: self descripciónErrorNoHayAcciónPorRehacer ].! !


!HistorialAcciones methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 15:48:03'!
descripciónErrorNoHayAcciónADeshacer

	^ 'No hay acción a deshacer'! !

!HistorialAcciones methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 15:50:02'!
descripciónErrorNoHayAcciónPorRehacer

	^ 'No hay acción por rehacer'! !


!HistorialAcciones methodsFor: 'hacer / deshacer' stamp: 'tomihq 11/22/2025 15:51:39'!
deshacer
	| accionADeshacer |
	self assertHayAccionesPorDeshacer.
	accionADeshacer := accionesADeshacer removeLast.
	accionADeshacer deshacer.
	self agregarAccionARehacer: accionADeshacer.! !

!HistorialAcciones methodsFor: 'hacer / deshacer' stamp: 'tomihq 11/22/2025 15:44:40'!
hacer: unaAccion

	unaAccion hacer.
	accionesADeshacer addLast: unaAccion.
	accionesARehacer removeAll.
	! !

!HistorialAcciones methodsFor: 'hacer / deshacer' stamp: 'tomihq 11/22/2025 15:52:02'!
rehacer: aPintor
	| accionARehacer |
	self assertHayAccionesPorRehacer.
	accionARehacer := accionesARehacer removeLast.
	accionARehacer hacer.
	accionesADeshacer addLast: accionARehacer.! !


!HistorialAcciones methodsFor: 'initializations' stamp: 'tomihq 11/22/2025 14:26:03'!
initialize
	accionesADeshacer :=  OrderedCollection new.
	accionesARehacer  := OrderedCollection new.! !


!HistorialAcciones methodsFor: 'accessing' stamp: 'tomihq 11/22/2025 15:31:17'!
cantidadDeAccionesPorRehacer
	^accionesARehacer size! !


!HistorialAcciones methodsFor: 'HistorialAcciones - agregar' stamp: 'tomihq 11/22/2025 15:27:04'!
agregarAccionADeshacer: unaAccionADeshacer
	accionesADeshacer addLast: unaAccionADeshacer.! !

!HistorialAcciones methodsFor: 'HistorialAcciones - agregar' stamp: 'tomihq 11/22/2025 15:30:07'!
agregarAccionARehacer: unaAccionARehacer
	accionesARehacer addLast: unaAccionARehacer! !


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


!Pared methodsFor: 'testing' stamp: 'tomihq 11/22/2025 15:40:40'!
area: unArea
	^area = unArea.! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/19/2025 22:11:38'!
cantidadPinturas: unaCantidadDePinturas
	^pinturas size = unaCantidadDePinturas.! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/19/2025 23:06:46'!
contieneA: unaPintura
	^pinturas includes: unaPintura.! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/22/2025 11:58:21'!
contieneTamañoPara: unaDimensionDePintura
	^area containsRect: unaDimensionDePintura! !

!Pared methodsFor: 'testing' stamp: 'tomihq 11/20/2025 00:40:04'!
obtenerPintura: unaPintura
	^pinturas detect: [:pintura | pintura == unaPintura].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: #Pintor!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 11:16:53'!
inicializarParedConExtension: unaExtension
	^self new initializeCon: unaExtension.! !


!classDefinition: #Pintor category: #Pintor!
Object subclass: #Pintor
	instanceVariableNames: 'pinturasSeleccionadas pared historial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!Pintor methodsFor: 'alignment' stamp: 'tomihq 11/22/2025 16:00:30'!
alinearPinturasAIzquierda
    self hacer: (PintorAlinearIzquierda pinturas: pinturasSeleccionadas ).
    
! !

!Pintor methodsFor: 'alignment' stamp: 'tomihq 11/22/2025 16:00:13'!
"Usamos extent acá porque necesito preservar tamaños relativos. Si movés el rectángulo a la derecha pero el corner lo dejás igual, la estás acahicando en ancho.
Para eso, necesitamos modificar también el corner basado en el nuevo origen x + el extent actual.
extent = nuevoOrigen + extentVieja
 - Tomás"
alinearPinturasALaDerecha
    self hacer: (PintorAlinearDerecha pinturas: pinturasSeleccionadas ).
! !


!Pintor methodsFor: 'initializers' stamp: 'tomihq 11/22/2025 14:25:13'!
initialize
	pinturasSeleccionadas := OrderedCollection new.
! !

!Pintor methodsFor: 'initializers' stamp: 'tomihq 11/22/2025 14:25:15'!
initializeWithPared: unaPared
	pared := unaPared.
	historial := HistorialAcciones new.
	super initialize.! !


!Pintor methodsFor: 'testing' stamp: 'tomihq 11/22/2025 11:46:49'!
hayPintura: unaPintura
	^pared contieneA: unaPintura.! !

!Pintor methodsFor: 'testing' stamp: 'tomihq 11/19/2025 23:49:58'!
tienePinturaSeleccionada: unaPinturaSeleccionada
	^pinturasSeleccionadas includes: unaPinturaSeleccionada.! !


!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/22/2025 15:31:18'!
cantidadDeAccionesPorRehacer
	^historial cantidadDeAccionesPorRehacer.! !

!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/19/2025 23:49:32'!
cantidadPinturasSeleccionadas
	^pinturasSeleccionadas size.! !

!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/22/2025 15:49:06'!
historialAcciones
	^historial.! !

!Pintor methodsFor: 'accessing' stamp: 'tomihq 11/21/2025 15:07:38'!
sinPinturasSeleccionadas
	^self cantidadPinturasSeleccionadas  = 0.! !


!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 15:32:29'!
agregarAccionARehacer: unaAccion
	historial agregarAccionARehacer: unaAccion.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 15:42:52'!
agregarPintura: unaPintura
	pared agregarPintura: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:37:52'!
agregarPinturaSeleccionada: unaPintura
	pinturasSeleccionadas addLast: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:10:22'!
cantidadPinturas: unaCantidadDePinturas
	^pared cantidadPinturas: unaCantidadDePinturas.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 14:16:36'!
colocarPintura: unaPinturaAColocar
	self assertDimensionesPinturaValidaDe: unaPinturaAColocar.
	(self hayPintura: unaPinturaAColocar) ifTrue: [^self error: self descripciónErrorPinturaConMismoOrigenYExtensión].
	
	self hacer: (PintorAgregar pintura: unaPinturaAColocar para: self).! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 15:46:35'!
deshacer
	^historial deshacer.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 14:26:57'!
hacer: unaAccion
	^historial hacer: unaAccion.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 14:23:38'!
rehacer
	^historial rehacer: self.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 15:42:21'!
removerPintura: unaPintura
	pared removerPintura: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 12:38:48'!
removerPinturaSeleccionada: unaPintura
	pinturasSeleccionadas remove: unaPintura.! !

!Pintor methodsFor: 'pintor functions' stamp: 'tomihq 11/22/2025 16:01:56'!
seleccionar: unaPinturaASeleccionar
	self assertPinturaNoEstaSeleccionada: unaPinturaASeleccionar. "agregué esto porque sino el test no tenia sentido. El modelo le enseña. "
	self hacer: (PintorSeleccionar una: unaPinturaASeleccionar para: self).
	! !


!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:59:21'!
descripciónErrorDimensionDePinturaInválida

	^ 'Dimensiones de la pintura inválidas'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:24:04'!
descripciónErrorPinturaConMismoOrigenYExtensión

	^ 'Ya existe una pintura con el mismo origen y extensión'! !

!Pintor methodsFor: 'error messages' stamp: 'tomihq 11/22/2025 11:00:45'!
descripciónErrorPinturaYaSeleccionada

	^ 'No se puede volver a seleccionar una pintura que ya seleccionaste'! !


!Pintor methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 11:59:21'!
assertDimensionesPinturaValidaDe: unaPintura
	(pared contieneTamañoPara: unaPintura) not ifTrue: [^self error: self descripciónErrorDimensionDePinturaInválida].! !

!Pintor methodsFor: 'assertions' stamp: 'tomihq 11/22/2025 16:02:08'!
assertPinturaNoEstaSeleccionada: unaPinturaASeleccionar
	(pinturasSeleccionadas includes: unaPinturaASeleccionar) ifTrue: [^self error: self descripciónErrorPinturaYaSeleccionada].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pintor class' category: #Pintor!
Pintor class
	instanceVariableNames: ''!

!Pintor class methodsFor: 'instance creation' stamp: 'tomihq 11/22/2025 11:44:08'!
sobreParedDe: unaExtension
	^self new initializeWithPared: (Pared inicializarParedConExtension: unaExtension)! !


!classDefinition: #ParedTest category: #Pintor!
TestCase subclass: #ParedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Pintor'!

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:40:49'!
test001LaParedArrancaSinPinturas
	| pared |
	pared := Pared inicializarParedConExtension: 3@2. 
	
	self assert: (pared cantidadPinturas: 0)
	! !

!ParedTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:40:56'!
"este test la idea era que me permita definir cual es la maxima extensión de la pared desde el 0@0"
test002ParedTieneUnAreaDefinidaBasadoEnSuExtension
	| pared area|
	area := Rectangle origin: 0@0 corner: 3@2. 
	pared := Pared inicializarParedConExtension: 3@2.
	
	self assert: (pared area: area)
	
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test003PintorPuedeSeleccionarPinturasDeLaPared
	| pintura pintor pintura2 |
	
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pintura2 := Rectangle origin: 2@1 corner: 3@1.
	
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	pintor colocarPintura: pintura2.
	
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	self assert: pintor cantidadPinturasSeleccionadas equals: 2.
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test004PintorNoPuedeSeleccionarUnaPinturaYaSeleccionada
	| pintura pintor |
	
	pintura := Rectangle origin: 0@0 corner: 2@0.
	pintor := Pintor sobreParedDe: 3@2.
	pintor colocarPintura: pintura.
	
	pintor seleccionar: pintura.
	self should: [pintor seleccionar: pintura] raise: Error - MessageNotUnderstood  withExceptionDo: [:error | 
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test006PintorPuedeAlinearPinturasALaDerecha
	    |  pintura pintor pintura2 |

	    pintura := Rectangle origin: 0@0 corner: 5@5.     
	    pintura2 := Rectangle origin: 5@3 corner: 10@10.    

	  
	    pintor := Pintor sobreParedDe: 20@20.
	    pintor colocarPintura: pintura.
	    pintor colocarPintura: pintura2.

	    pintor seleccionar: pintura.
	    pintor seleccionar: pintura2.

	    pintor alinearPinturasALaDerecha.


	    self assert: pintura equals: (Rectangle origin: 5@0 corner: 10@5).
	    self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test007PintorPuedeAlinearPinturasALaIzquierda
	    |  pintura pintor pintura2 |
	   
	    pintura := Rectangle origin: 0@0 corner: 5@5.
	    pintura2 := Rectangle origin: 5@3 corner: 10@10. 
	    
	    pintor := Pintor sobreParedDe: 20@20.
	    pintor colocarPintura: pintura.
	    pintor colocarPintura: pintura2.
	    
	    pintor seleccionar: pintura.
	    pintor seleccionar: pintura2.
	    
	    pintor alinearPinturasAIzquierda.
	    

	    self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    self assert: pintura2 equals: (Rectangle origin: 0@3 corner: 5@10).
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:59:01'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test008PintorSoloPuedeAlinearADerechaSiTieneMasDeUnaPinturaSeleccionada
	|  pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionar: pintura.
	
	self should: [ pintor alinearPinturasALaDerecha ] raise: Error-MessageNotUnderstood withExceptionDo: [:exception |
	        self assert: exception messageText equals: PintorAlinear descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadas.
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:58:54'!
"Alinear a la derecha con una pintura debe fallar. El objetivo de este es demostrar que alinearPinturasALaDerecha llama al método correspondiente que termina arrojando el error."
test009PintorSoloPuedeAlinearAIzquierdaSiTieneMasDeUnaPinturaSeleccionada
	|  pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionar: pintura.
	
	self should: [ pintor alinearPinturasAIzquierda ] raise: Error  - MessageNotUnderstood withExceptionDo: [:exception |
	        self assert: exception messageText equals: PintorAlinear descripciónErrorPintorDebeTenerAlMenosDosPinturasSeleccionadas.
	        self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	    ].
		
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:48:50'!
test010PintorNoPuedeDeshacerSiNoHizoAcciones
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	self should: [pintor deshacer] 
	raise: Error - MessageNotUnderstood 
	withMessageText: pintor historialAcciones descripciónErrorNoHayAcciónADeshacer

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test011PintorPuedeDeshacerSeleccionDePintura
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor seleccionar: pintura.
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:50:02'!
test013PintorNoPuedeRehacerSiNoHayAccionParaRehacer
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	self should:  [ pintor rehacer. ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
		self assert: anError messageText equals: pintor historialAcciones descripciónErrorNoHayAcciónPorRehacer .
		self assert: (pintor cantidadPinturas: 1	).
		
	].
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test014PintorPuedeRehacerAcciónDeSeleccionarPintura
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor seleccionar: pintura.	
	pintor deshacer.
	pintor rehacer. 
	self assert: pintor cantidadPinturasSeleccionadas equals: 1.
	self assert: (pintor tienePinturaSeleccionada: pintura).
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:09:25'!
test015PintorPuedeRehacerAcciónDeAgregarPinturaALaPared
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer.
	pintor rehacer. 
	self assert: (pintor cantidadPinturas: 1	).
	self assert: (pintor hayPintura: pintura).
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:05:56'!
test016PintorRealizaAcciónColocarPinturaYSeDescartanAccionesPorRehacer
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 1.
	pintor colocarPintura: pintura.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 0.
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:07:57'!
test017PintorDescartaAccionColocarPinturaRehaceYDescartaNuevamente
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer; rehacer; deshacer.
	
	self assert: (pintor cantidadPinturas: 0).
	self assert: (pintor tienePinturaSeleccionada: pintura) equals: false
	
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test018PintorRealizaAcciónSeleccionarPinturaYSeDescartanAccionesPorRehacer
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor seleccionar: pintura.	
	pintor deshacer.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 1.
	self assert: (pintor tienePinturaSeleccionada: pintura) equals: false.
	pintor seleccionar: pintura.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 0.
	self assert: (pintor tienePinturaSeleccionada: pintura).
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 14:12:12'!
test019PintorDescartaAccionSeleccionarPinturaRehaceYDescartaNuevamente
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor seleccionar: pintura.	
	pintor deshacer; rehacer; deshacer.
	
	self assert: pintor cantidadPinturasSeleccionadas  equals: 0.
	self assert: (pintor tienePinturaSeleccionada: pintura) equals: false.
	
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:11:22'!
test020DescartaAcciónDeMoverPinturasALaDerecha
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasALaDerecha .	
	pintor deshacer.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10)
	
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:17:34'!
test021DescartaAcciónDeMoverPinturasALaIzquierda
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasAIzquierda .	
	pintor deshacer.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10)
	
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:23:12'!
test022DescartaAcciónDeMoverPinturasALaDerechaYLaRehace
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasALaDerecha .	
	pintor deshacer.
	pintor rehacer.
	
	self assert: pintura equals: (Rectangle origin: 5@0 corner: 10@5).
	self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10)
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:24:04'!
test023DescartaAcciónDeMoverPinturasALaIzquierdaYLaRehace
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasAIzquierda .	
	pintor deshacer.
	pintor rehacer.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 0@3 corner: 5@10).
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:39:28'!
test024DescartaAcciónDeMoverPinturasALaDerechaLaRehaceYDescartaNuevamente
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasALaDerecha .	
	pintor deshacer.
	pintor rehacer.
	pintor deshacer.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10)
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 15:39:48'!
test025DescartaAcciónDeMoverPinturasALaIzquierdaLaRehaceYDescartaNuevamente
	| pintura pintura2 pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintura2 := Rectangle origin: 5@3 corner: 10@10.
	
	pintor := Pintor sobreParedDe: 20@20.
	pintor seleccionar: pintura.
	pintor seleccionar: pintura2.
	
	pintor alinearPinturasAIzquierda .	
	pintor deshacer.
	pintor rehacer.
	pintor deshacer.
	
	self assert: pintura equals: (Rectangle origin: 0@0 corner: 5@5).
	self assert: pintura2 equals: (Rectangle origin: 5@3 corner: 10@10).
	
	
	
	
	

	
	
	
	
! !
