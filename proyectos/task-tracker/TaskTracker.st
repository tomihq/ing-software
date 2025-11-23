!classDefinition: #Proyecto category: #TaskTracker!
Object subclass: #Proyecto
	instanceVariableNames: 'nombre fechaInicio compuestoPor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 18:15:29'!
crearCon: unNombre y: unasDependencias
	nombre := unNombre.
	compuestoPor := unasDependencias.
	self calcularFechaDeInicio.! !


!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 18:25:05'!
fechaInicioDeseada
	compuestoPor size = 0 ifTrue: [^self].
	^(compuestoPor min: [:tarea | tarea fechaInicioDeseada]) next.! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 10:13:16'!
nombre
	^nombre.! !


!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 18:25:05'!
calcularFechaDeInicio
	fechaInicio := self fechaInicioDeseada.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 18:13:24'!
contiene: unaDependencia
	^compuestoPor includes: unaDependencia.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 18:15:43'!
fechaInicio: unaFechaDeInicio
	^fechaInicio = unaFechaDeInicio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Proyecto class' category: #TaskTracker!
Proyecto class
	instanceVariableNames: ''!

!Proyecto class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 18:11:49'!
llamado: unNombre compuestoPor: unConjuntoDeDependencias
	^self new crearCon: unNombre y: unConjuntoDeDependencias ! !


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


!classDefinition: #TareaConcreta category: #TaskTracker!
Object subclass: #TareaConcreta
	instanceVariableNames: 'nombre fechaInicioDeseada horasEsfuerzo responsable dependientes'
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

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 13:04:58'!
finalizaEn: unaFechaFinalización
	^unaFechaFinalización = self fechaFinalización.
	! !


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

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:13:53'!
"notar que un proyecto a sí mismo su fecha de inicio es la mínima de una tarea por lo que basta recursivamente con buscar la fecha mínima de todas las tareas - Tomás"
test04ProyectoArrancaEnLaFechaMasTempranaDeTareaOSubproyecto
	| proyecto tarea tareas |
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls dependeDe: OrderedCollection new.
	tareas := {tarea}.
	proyecto := Proyecto llamado: 'Modelo' compuestoPor: tareas.
	
	
	self assert: (proyecto contiene: tarea).
	self assert: (proyecto fechaInicio: July/2/2024 ).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 18:25:32'!
"acá nos damos cuenta que hay una especie de Composite entre Tarea y Proyecto a nivel de fechaInicio"
test05ProyectoContieneSubproyectosYTareas
	| tareaSSA tareaSSC proyectoModelo proyectoERP |
	
	tareaSSA := TareaConcreta conNombre: 'SS A' fechaDeInicioDeseada: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: OrderedCollection new. 
	tareaSSC := TareaConcreta conNombre: 'SS C' fechaDeInicioDeseada: July/2/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependeDe: OrderedCollection new.
	
	proyectoModelo := Proyecto llamado: 'Modelo' compuestoPor: {tareaSSA.}.

	proyectoERP := Proyecto llamado: 'Sistema ERP' compuestoPor: {proyectoModelo. tareaSSC}.
	
	
	self assert: (proyectoERP contiene: proyectoModelo).
	self assert: (proyectoERP contiene: tareaSSC).
	self assert: (proyectoERP fechaInicio: (July/3/2024 ))
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
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 39 47 57 48 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 39 47 57 48 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 60 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 48 17 56 64 57 53 56 61 63 53 55 53 59 56 17 123 118 116 112 111 120 17 123 118 116 112 111 120 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 62 65 57 55 65 59 61 53 62 63 62 60 57 61 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 57 63 57 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 62 65 57 56 65 55 58 53 55 55 56 56 57 57 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 57 63 57 63 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 56 60 65 57 62 53 64 55 59 55 58 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 87 121 118 128 108 106 123 118 53 122 123 17 56 55 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 56 60 65 60 60 53 60 58 58 62 62 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 55 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 57 60 65 55 55 53 63 56 55 57 59 56 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 57 59 55 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 55 61 65 60 57 53 55 55 61 56 64 60 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 59 63 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 58 55 65 56 64 53 58 56 63 57 63 56 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 63 55 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 60 59 65 57 56 53 60 61 62 61 57 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 64 63 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 62 65 59 64 65 56 61 53 56 61 60 64 64 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 59 60 64 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 62 65 60 60 65 57 58 53 59 57 55 64 60 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 59 63 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 63 65 55 60 65 55 57 53 56 59 56 62 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 60 59 55 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 63 65 57 60 65 60 62 53 61 55 57 57 55 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 58 62 57 58 17 52 52 52 52 52 52 52 52 52 52 17 17))!