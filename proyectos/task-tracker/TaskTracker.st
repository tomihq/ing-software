!classDefinition: #Responsable category: #TaskTracker!
Object subclass: #Responsable
	instanceVariableNames: 'nombre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Responsable methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:05:47'!
tiempoEnCompletar: unTiempoEsfuerzo

	self subclassResponsibility! !


!classDefinition: #Desarrollador category: #TaskTracker!
Responsable subclass: #Desarrollador
	instanceVariableNames: 'dedicación costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Desarrollador methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:57:58'!
crearCon: unNombre dedicación: unTiempoDeDedicacion costo: unCosto
	nombre := unNombre.
	dedicación  := unTiempoDeDedicacion.
	costo := unCosto.! !

!Desarrollador methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:10:27'!
tiempoEnCompletar: unasHorasDeEsfuerzo
	^(unasHorasDeEsfuerzo / dedicación) ceiling.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Desarrollador class' category: #TaskTracker!
Desarrollador class
	instanceVariableNames: ''!

!Desarrollador class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 12:01:31'!
nombre: unNombre dedicación: tiempoDeDedicación costo: unCosto
	^self new crearCon: unNombre dedicación: tiempoDeDedicación costo: unCosto.
	! !


!classDefinition: #Equipo category: #TaskTracker!
Responsable subclass: #Equipo
	instanceVariableNames: 'miembros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Equipo methodsFor: 'initialization' stamp: 'tomihq 11/23/2025 13:16:34'!
inicializarCon: unNombre miembros: unosMiembros
	nombre := unNombre.
	miembros := unosMiembros.
	! !


!Equipo methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:30:29'!
tiempoEnCompletar: unTiempoEsfuerzo
	^miembros max: [:miembro | miembro tiempoEnCompletar: unTiempoEsfuerzo].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Equipo class' category: #TaskTracker!
Equipo class
	instanceVariableNames: ''!

!Equipo class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 13:16:22'!
conNombre: unNombre miembros: unosMiembros
	^self new inicializarCon: unNombre miembros: unosMiembros.! !


!classDefinition: #Tarea category: #TaskTracker!
Object subclass: #Tarea
	instanceVariableNames: 'fechaInicioDeseada nombre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Tarea methodsFor: 'time' stamp: 'tomihq 11/23/2025 18:40:23'!
fechaFinalización

	self subclassResponsibility! !

!Tarea methodsFor: 'time' stamp: 'tomihq 11/23/2025 18:40:09'!
fechaInicio

	self subclassResponsibility! !

!Tarea methodsFor: 'time' stamp: 'tomihq 11/23/2025 18:40:16'!
fechaInicioDeseada

	self subclassResponsibility! !

!Tarea methodsFor: 'time' stamp: 'tomihq 11/23/2025 18:41:38'!
finalizaEn: unaFechaFinalización
	^unaFechaFinalización = self fechaFinalización.
	! !


!classDefinition: #Proyecto category: #TaskTracker!
Tarea subclass: #Proyecto
	instanceVariableNames: 'subtareas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 18:43:56'!
crearCon: unNombre y: unasDependencias
	nombre := unNombre.
	subtareas := unasDependencias.
	fechaInicioDeseada := self fechaInicioDeseada.! !


!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 18:34:31'!
fechaFinalización
	^subtareas max: [:subtarea | subtarea fechaFinalización ].! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 18:28:10'!
fechaInicio
	^subtareas min: [:subtarea | subtarea fechaInicio].! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 18:30:53'!
fechaInicioDeseada
	subtareas size = 0 ifTrue: [^self].
	^subtareas min: [:tarea | tarea fechaInicio].! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 10:13:16'!
nombre
	^nombre.! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 18:49:43'!
tieneSobretrabajo
	^false.! !


!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 18:28:10'!
contiene: unaDependencia
	^subtareas includes: unaDependencia.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 21:32:39'!
"si tiene más de una tarea para hacer en un unico día está sobrecargado"
diasDeSobrecargaDe: unDesarrollador
	|tareas tareasPorDia |
	tareas := self tareasCorrespondientesA: unDesarrollador.
	tareasPorDia := self obtenerCantidadTareasPorDiaDe: tareas.
	
	^OrderedCollection newFrom: (tareasPorDia keys select: [:k | (tareasPorDia at: k) > 1 ]) .
! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 18:38:56'!
fechaInicio: unaFechaDeInicio
	^fechaInicioDeseada = unaFechaDeInicio.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 21:33:15'!
obtenerCantidadTareasPorDiaDe: unaCantidadDeTareas
	|fecha cantTareas tareasPorDia|
	tareasPorDia := Dictionary new.
	unaCantidadDeTareas do: [:subtareasResponsable | 
		
		fecha := subtareasResponsable fechaInicio.
		cantTareas := tareasPorDia at: fecha ifAbsent: 0.
		tareasPorDia at:  fecha put: cantTareas+1.

	].
	^tareasPorDia.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 21:28:26'!
tareasCorrespondientesA: unDesarrollador

	^ subtareas select: [:subtarea | subtarea esResponsable: unDesarrollador]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Proyecto class' category: #TaskTracker!
Proyecto class
	instanceVariableNames: ''!

!Proyecto class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 18:11:49'!
llamado: unNombre compuestoPor: unConjuntoDeDependencias
	^self new crearCon: unNombre y: unConjuntoDeDependencias ! !


!classDefinition: #TareaConcreta category: #TaskTracker!
Tarea subclass: #TareaConcreta
	instanceVariableNames: 'horasEsfuerzo responsable dependientes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!TareaConcreta methodsFor: 'testing' stamp: 'tomihq 11/23/2025 11:54:01'!
contieneDependientes: unasTareasDependientes
	^dependientes = unasTareasDependientes.! !

!TareaConcreta methodsFor: 'testing' stamp: 'tomihq 11/23/2025 11:39:06'!
contieneHorasEsfuerzo: unasHorasDeEsfuerzo
	^horasEsfuerzo = unasHorasDeEsfuerzo.! !

!TareaConcreta methodsFor: 'testing' stamp: 'tomihq 11/23/2025 11:44:28'!
esResponsable: unResponsable
	^responsable = unResponsable.! !


!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 17:50:54'!
arrancaEn: unaFechaDeseadaDeArranque
	^ unaFechaDeseadaDeArranque = self fechaInicio! !

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 17:56:16'!
fechaFinalización

	| tiempoFinalización |
	tiempoFinalización := (responsable tiempoEnCompletar: horasEsfuerzo) - (1 * day).
	^ self fechaInicio next: tiempoFinalización! !

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 17:55:12'!
fechaInicio

	^ dependientes ifEmpty: [fechaInicioDeseada ] ifNotEmpty: [(self fechaMáximaFinalizaciónDeDependientes) next max: fechaInicioDeseada ]! !

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 17:43:03'!
fechaInicioDeseada
	^fechaInicioDeseada.! !

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 17:55:01'!
fechaMáximaFinalizaciónDeDependientes

	^ dependientes max: [:unDependiente | unDependiente fechaFinalización ]! !


!TareaConcreta methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 12:59:49'!
inicializarCon: unNombre fechaDeInicioDeseada: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependeDe: unosDependientes   
	nombre := unNombre. 
	fechaInicioDeseada := unaFechaDeInicio.
	horasEsfuerzo := unasHorasDeEsfuerzo.
	responsable := unResponsable.
	dependientes := unosDependientes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TareaConcreta class' category: #TaskTracker!
TareaConcreta class
	instanceVariableNames: ''!

!TareaConcreta class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:00:01'!
conNombre: unNombre fechaDeInicioDeseada: unaFechaDeInicio horasEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependeDe: unosDependientes   
	^self new inicializarCon: unNombre fechaDeInicioDeseada: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependeDe: unosDependientes.! !


!classDefinition: #ProyectoTest category: #TaskTracker!
TestCase subclass: #ProyectoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:26:10'!
alanKay
	^Desarrollador nombre: 'Alan Kay' dedicación: 6 *hour/day costo: 80*dollar/hour.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:49:59'!
danIngalls
	^Desarrollador nombre: 'Dan Ingalls' dedicación: 8 *hour/day costo: 60*dollar/hour.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:25:55'!
parcMobTeam
	^Equipo conNombre: 'Parc Team' miembros: {self danIngalls. self alanKay}.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:09:27'!
test01ProyectoContieneNombre
	|tareas|
	tareas := OrderedCollection new.
	self assert: (Proyecto llamado: 'Hey' compuestoPor: tareas) nombre equals: 'Hey'.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:13:31'!
test02ProyectoContieneTareas
	| proyecto tarea tareas|
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependeDe: OrderedCollection new.
	tareas := OrderedCollection new.
	tareas addLast: tarea.
	proyecto := Proyecto llamado: 'Modelo' compuestoPor: tareas.
	
	
	self assert: (proyecto contiene: tarea).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:31:02'!
"notar que un proyecto a sí mismo su fecha de inicio es la mínima de una tarea por lo que basta recursivamente con buscar la fecha mínima de todas las tareas - Tomás"
test04ProyectoArrancaEnLaFechaMasTempranaDeTareaOSubproyecto
	| proyecto tarea tareas |
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls dependeDe: OrderedCollection new.
	tareas := {tarea}.
	proyecto := Proyecto llamado: 'Modelo' compuestoPor: tareas.
	
	
	self assert: (proyecto contiene: tarea).
	self assert: (proyecto fechaInicio: July/1/2024 ).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:30:02'!
"acá nos damos cuenta que hay una especie de Composite entre Tarea y Proyecto a nivel de fechaInicio"
test05ProyectoContieneSubproyectosYTareas
	| tareaSSA tareaSSC proyectoModelo proyectoERP |
	
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: {}. 
	tareaSSC := TareaConcreta conNombre: 'SS C' fechaDeInicioDeseada: July/2/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: {}.
	
	proyectoModelo := Proyecto llamado: 'Modelo' compuestoPor: {tareaSSA.}.

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {proyectoModelo. tareaSSC}.
	
	
	self assert: (proyectoERP contiene: proyectoModelo).
	self assert: (proyectoERP contiene: tareaSSC).
	self assert: (proyectoERP fechaInicio: (July/1/2024 ))
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:00:01'!
test06TareaContieneEsfuerzoEnHorasQueToma
	|  tarea |
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: OrderedCollection new. 
	self assert: (tarea contieneHorasEsfuerzo: 8 * hour)
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:00:01'!
test07ContieneDesarrolladorResponsableARealizarla
	|  tarea desarrollador |
	desarrollador := self danIngalls .
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 8 * hour responsable: desarrollador dependeDe: OrderedCollection new. 
	self assert: (tarea esResponsable: desarrollador )
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:00:01'!
test08TareaConMismoEsfuerzoQueTiempoDeDedicacionTerminaElMismoDia
	|  tarea |
	tarea := TareaConcreta  conNombre: 'A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 8 * hour  responsable:  self danIngalls dependeDe: OrderedCollection new.
	
	self assert: (tarea finalizaEn: July/1/2024).
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:07:45'!
test09TareaConDiferenteEsfuerzoQueTiempoDeDedicacionTomaVariosDias
	|  tarea |
	tarea := TareaConcreta  conNombre: 'A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 10 * hour  responsable:  self danIngalls dependeDe: OrderedCollection new.
	
	self assert: (tarea finalizaEn: July/2/2024).
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 13:26:24'!
test10TareaRealizadaPorEquipoTomaElTiempoDelDesarrolladorMasLento
	|  tarea equipo |
	
	equipo := self parcMobTeam.
	
	tarea := TareaConcreta  conNombre: 'A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 16 * hour  responsable:  equipo dependeDe: OrderedCollection new.
	
	self assert: (tarea finalizaEn: ( July/1/2024 next: (16 * hour/(6*hour/day)) ceiling) previous)
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 17:41:01'!
test11TareaIniciaEnElDíaDeseadoLuegoDeQueLasQueDependíaYaTerminaronAntes
	|  tareaSSA tareaSSB tareaSSC equipo |
	
	equipo := self parcMobTeam.
	
	tareaSSA := TareaConcreta  conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 8 * hour  responsable:  self danIngalls dependeDe: {}.
	tareaSSB := TareaConcreta  conNombre: 'SS B' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 16 * hour  responsable:  equipo dependeDe: {}.
	tareaSSC := TareaConcreta  conNombre: 'SS C' fechaDeInicioDeseada: July/2/2024 horasEsfuerzo: 16 * hour  responsable:  self alanKay dependeDe: {tareaSSA . tareaSSB}.
	
	self assert: (tareaSSC arrancaEn: tareaSSB fechaFinalización next)
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 17:45:17'!
test12TareaIniciaUnDíaDespuésDeLasQueDependeTerminaronYLaFechaInicioDeseadaEstaEnRango
	|  tareaSSA tareaSSC equipo |
	
	equipo := self parcMobTeam.
	
	tareaSSA := TareaConcreta  conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024 horasEsfuerzo: 8 * hour  responsable:  self danIngalls dependeDe: {}.
	tareaSSC := TareaConcreta  conNombre: 'SS C' fechaDeInicioDeseada: July/3/2024 horasEsfuerzo: 16 * hour  responsable:  self alanKay dependeDe: {tareaSSA}.
	
	self assert: (tareaSSC arrancaEn: tareaSSC fechaInicioDeseada)
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:04:46'!
test13TareaFechaFinalizaciónUsaFechaInicioYNoFechaDeseadaDeArranque
	|  tareaSSA tareaSSC equipo |
	
	equipo := self parcMobTeam.
	
	tareaSSA := TareaConcreta  conNombre: 'SS A' fechaDeInicioDeseada: July/2/2024 horasEsfuerzo: 8 * hour  responsable:  self danIngalls dependeDe: {}.
	tareaSSC := TareaConcreta  conNombre: 'SS C' fechaDeInicioDeseada: July/2/2024 horasEsfuerzo: 16 * hour  responsable:  self danIngalls dependeDe: {tareaSSA}.
	
	self assert: (tareaSSC finalizaEn: July/4/2024)
	
	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:37:32'!
test14ProyectoFinalizaEnFechaQueFinalizaLaUltimaSubtarea
	| tareaSSA tareaSSC proyectoModelo proyectoERP |
	
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: {}. 
	tareaSSC := TareaConcreta conNombre: 'SS C' fechaDeInicioDeseada: July/2/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: {}.
	
	proyectoModelo := Proyecto llamado: 'Modelo' compuestoPor: {tareaSSA.}.

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {proyectoModelo. tareaSSC}.
	
	
	self assert: (proyectoERP contiene: proyectoModelo).
	self assert: (proyectoERP contiene: tareaSSC).
	self assert: (proyectoERP finalizaEn: (July/2/2024 ))

	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:49:32'!
test15CuandoDesarrolladorNoTieneSobreTrabajoElProyectoNoTieneSobreTrabajo
	| tareaSSA proyectoERP |
	
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: {}. 

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {tareaSSA}.
	
	self deny: (proyectoERP tieneSobretrabajo).

	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 21:26:14'!
test16ElDesarrolladorNoEstáSobrecargado
	| tareaSSA tareaSSB proyectoERP danIngalls danIngallsDiasSobrecargado |
	
	danIngalls := self danIngalls.
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable:  danIngalls  dependeDe: {}. 
	tareaSSB := TareaConcreta conNombre: 'SS B' fechaDeInicioDeseada: July/2/2024  horasEsfuerzo: 8 * hour responsable: danIngalls  dependeDe: {}. 

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {tareaSSA . tareaSSB}.
	
	danIngallsDiasSobrecargado := proyectoERP diasDeSobrecargaDe: danIngalls.
	
	self assert: (danIngallsDiasSobrecargado size) equals: 0.


	
	
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 21:27:13'!
test17ElDesarrolladorEstáSobrecargadoSiTieneMásDeUnProyectoARealizarEnElMismoDía
	| tareaSSA tareaSSB proyectoERP danIngalls danIngallsDiasSobrecargado |
	
	danIngalls := self danIngalls.
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable:  danIngalls  dependeDe: {}. 
	tareaSSB := TareaConcreta conNombre: 'SS B' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: danIngalls  dependeDe: {}. 

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {tareaSSA . tareaSSB}.
	
	danIngallsDiasSobrecargado := proyectoERP diasDeSobrecargaDe: danIngalls.
	
	self assert: (danIngallsDiasSobrecargado size) equals: 1.


	
	
! !
