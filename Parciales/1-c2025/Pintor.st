'From Cuis7.3 [latest update: #7158] on 22 November 2025 at 1:59:55 pm'!
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

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:46:58'!
test016PintorRealizaAcciónYSeDescartanAccionesPorRehacer
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 1.
	pintor seleccionarPintura: pintura.
	self assert: pintor cantidadDeAccionesPorRehacer equals: 0.
	
	
	
	
	

	
	
	
	
! !

!PintorTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/22/2025 13:56:01'!
test017PintorDescartaAccionRehaceYDescartaNuevamente
	| pintura pintor|
	
	pintura := Rectangle origin: 0@0 corner: 5@5.	
	pintor := Pintor sobreParedDe: 20@20.
	
	pintor colocarPintura: pintura.	
	pintor deshacer; rehacer; deshacer.
	
	self assert: (pintor cantidadPinturas: 0).
	
	
	
	
	
	

	
	
	
	
! !
