!classDefinition: #Desarrollador category: #TaskTracker!
Object subclass: #Desarrollador
	instanceVariableNames: 'nombre tiempoDeDedicación costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Desarrollador methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:02:02'!
crearCon: unNombre dedicación: unTiempoDeDedicacion costo: unCosto
	nombre := unNombre.
	tiempoDeDedicación  := unTiempoDeDedicacion.
	costo := unCosto.! !

!Desarrollador methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:11:12'!
dedicacion
	^tiempoDeDedicación.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Desarrollador class' category: #TaskTracker!
Desarrollador class
	instanceVariableNames: ''!

!Desarrollador class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:01:31'!
nombre: unNombre dedicación: tiempoDeDedicación costo: unCosto
	^self new crearCon: unNombre dedicación: tiempoDeDedicación costo: unCosto.
	! !


!classDefinition: #Proyecto category: #TaskTracker!
Object subclass: #Proyecto
	instanceVariableNames: 'nombre tareas fechaInicio subproyectos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 11:14:14'!
crearCon: unNombre subproyectos: unosSubproyectos yTareas: unasTareas
	nombre := unNombre.
	tareas := unasTareas.
	subproyectos := unosSubproyectos.
	self calcularFechaDeInicio.! !

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 10:59:30'!
crearCon: unNombre y: unosSubproyectos
	nombre := unNombre.
	subproyectos := unosSubproyectos.
	self calcularFechaDeInicio.! !

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 10:51:28'!
crearCon: unNombre yUnConjuntoDe: unasTareas
	nombre := unNombre.
	tareas := unasTareas.
	self calcularFechaDeInicio.! !

!Proyecto methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 11:00:29'!
initialize
	tareas := OrderedCollection new.
	subproyectos := OrderedCollection new.! !


!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 11:04:22'!
fechaInicio
	tareas size = 0 ifTrue: [^self].
	^(tareas collect: [:tarea | tarea fechaInicio]) min.! !

!Proyecto methodsFor: 'accessing' stamp: 'tomihq 11/23/2025 10:13:16'!
nombre
	^nombre.! !


!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 11:03:42'!
calcularFechaDeInicio
	tareas size = 0 ifTrue: [^self].
	fechaInicio := self fechaInicio.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 11:00:22'!
contieneSubproyecto: unSubproyecto
	^subproyectos includes: unSubproyecto.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 10:24:22'!
contieneTarea: unaTarea
	^tareas includes: unaTarea.! !

!Proyecto methodsFor: 'testing' stamp: 'tomihq 11/23/2025 10:52:42'!
fechaInicio: unaFechaDeInicio
	^fechaInicio = unaFechaDeInicio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Proyecto class' category: #TaskTracker!
Proyecto class
	instanceVariableNames: ''!

!Proyecto class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 11:13:38'!
conNombre: unNombre subproyectos: unosSubproyectos tareas: unasTareas 
	^self new crearCon: unNombre subproyectos: unosSubproyectos yTareas: unasTareas.! !

!Proyecto class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 10:59:56'!
conNombre: unNombre ySubproyectos: subproyectos 
	^self new crearCon: unNombre y: subproyectos.! !

!Proyecto class methodsFor: 'instance creation' stamp: 'tomihq 11/23/2025 11:06:40'!
conNombre: unNombre yTareas: tareas 
	^self new crearCon: unNombre yUnConjuntoDe: tareas.! !


!classDefinition: #TareaConcreta category: #TaskTracker!
Object subclass: #TareaConcreta
	instanceVariableNames: 'nombre fechaInicio horasEsfuerzo responsable dependientes'
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


!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 12:18:51'!
fechaFinalizacion
	|tiempoDedicacionResponsable|
	tiempoDedicacionResponsable := responsable dedicacion.
	! !

!TareaConcreta methodsFor: 'time' stamp: 'tomihq 11/23/2025 10:48:48'!
fechaInicio
	^fechaInicio.! !


!TareaConcreta methodsFor: 'initializations' stamp: 'tomihq 11/23/2025 11:52:59'!
inicializarCon: unNombre fechaDeInicio: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes   
	nombre := unNombre. 
	fechaInicio := unaFechaDeInicio.
	horasEsfuerzo := unasHorasDeEsfuerzo.
	responsable := unResponsable.
	dependientes := unosDependientes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TareaConcreta class' category: #TaskTracker!
TareaConcreta class
	instanceVariableNames: ''!

!TareaConcreta class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:53:10'!
conNombre: unNombre fechaDeInicio: unaFechaDeInicio horasEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes   
	^self new inicializarCon: unNombre fechaDeInicio: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes.! !


!classDefinition: #ProyectoTest category: #TaskTracker!
TestCase subclass: #ProyectoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:49:59'!
danIngalls
	^Desarrollador nombre: 'Dan Ingalls' dedicación: 8 *hour/day costo: 60*dollar/hour.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:06:40'!
test01ProyectoContieneNombre
	|tareas|
	tareas := OrderedCollection new.
	self assert: (Proyecto conNombre: 'Hey' yTareas: tareas) nombre equals: 'Hey'.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:48:28'!
test02ProyectoContieneTareas
	| proyecto tarea tareas|
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicio: July/1/2024 horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new.
	tareas := OrderedCollection new.
	tareas addLast: tarea.
	proyecto := Proyecto conNombre: 'Modelo' yTareas: tareas.
	
	
	self assert: (proyecto contieneTarea: tarea).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:23:25'!
test03ProyectoPuedeContenerOtroProyectosDentro
	| proyecto proyecto2 proyectos |
	proyectos := OrderedCollection new.
	proyecto2 := Proyecto conNombre: 'Modelo' yTareas: proyectos.
	proyectos addLast: proyecto2.

	proyecto := Proyecto conNombre: 'Sistema ERP' ySubproyectos: proyectos.
	
	
	self assert: (proyecto contieneSubproyecto: proyecto2).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:50:27'!
"notar que un proyecto a sí mismo su fecha de inicio es la mínima de una tarea por lo que basta recursivamente con buscar la fecha mínima de todas las tareas - Tomás"
test04ProyectoArrancaEnLaFechaMasTempranaDeTareaOSubproyecto
	| proyecto tarea tareas |
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicio: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls dependientes: OrderedCollection new.
	tareas := OrderedCollection new.
	tareas addLast: tarea.
	proyecto := Proyecto conNombre: 'Modelo' yTareas: tareas.
	
	
	self assert: (proyecto contieneTarea: tarea).
	self assert: (proyecto fechaInicio: July/1/2024 ).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:50:23'!
"acá nos damos cuenta que hay una especie de Composite entre Tarea y Proyecto a nivel de fechaInicio"
test05ProyectoContieneSubproyectosYTareas
	| proyecto proyecto2 tareasProyecto2 proyectos tarea tareas |
	proyectos := OrderedCollection new.
	tareas := OrderedCollection new. 
	tareasProyecto2 := OrderedCollection new.
	
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicio: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependientes: OrderedCollection new. 
	tareas addLast: tarea.
	

	tarea := TareaConcreta conNombre: 'SS C' fechaDeInicio: July/2/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependientes: OrderedCollection new.
	tareas addLast: tarea.
	
	proyecto2 := Proyecto conNombre: 'Modelo' yTareas: proyectos.
	proyectos addLast: proyecto2.

	proyecto := Proyecto conNombre: 'Sistema ERP' subproyectos: proyectos tareas: tareas.
	
	
	self assert: (proyecto contieneSubproyecto: proyecto2).
	self assert: (proyecto contieneTarea: tarea).
	self assert: (proyecto fechaInicio: (July/1/2024 ))
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:50:19'!
test06TareaContieneEsfuerzoEnHorasQueToma
	|  tarea |
	
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicio: July/1/2024  horasEsfuerzo: 8 * hour responsable: self danIngalls  dependientes: OrderedCollection new. 
	self assert: (tarea contieneHorasEsfuerzo: 8 * hour)
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:51:17'!
test07ContieneDesarrolladorResponsableARealizarla
	|  tarea desarrollador |
	desarrollador := self danIngalls .
	tarea := TareaConcreta conNombre: 'SS A' fechaDeInicio: July/1/2024 horasEsfuerzo: 8 * hour responsable: desarrollador dependientes: OrderedCollection new. 
	self assert: (tarea esResponsable: desarrollador )
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 12:50:10'!
test08TareaConMismoEsfuerzoQueTiempoDeDedicacionTerminaElMismoDia
	|  tarea fechaInicio |
	tarea := TareaConcreta  conNombre: 'A' fechaDeInicio: July/1/2024 horasEsfuerzo: 8 * hour  responsable:  self danIngalls dependientes: OrderedCollection new.
	
	self assert: tarea fechaFinalización equals: fechaInicio
	
	
	
! !
