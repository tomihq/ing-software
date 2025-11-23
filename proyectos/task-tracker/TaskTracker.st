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


!classDefinition: #Tarea category: #TaskTracker!
Object subclass: #Tarea
	instanceVariableNames: 'nombre fechaInicio horasEsfuerzo responsable dependientes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!Tarea methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:54:01'!
contieneDependientes: unasTareasDependientes
	^dependientes = unasTareasDependientes.! !

!Tarea methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:39:06'!
contieneHorasEsfuerzo: unasHorasDeEsfuerzo
	^horasEsfuerzo = unasHorasDeEsfuerzo.! !

!Tarea methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:44:28'!
esResponsable: unResponsable
	^responsable = unResponsable.! !

!Tarea methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 10:48:48'!
fechaInicio
	^fechaInicio.! !

!Tarea methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:52:59'!
inicializarCon: unNombre fechaDeInicio: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes   
	nombre := unNombre. 
	fechaInicio := unaFechaDeInicio.
	horasEsfuerzo := unasHorasDeEsfuerzo.
	responsable := unResponsable.
	dependientes := unosDependientes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tarea class' category: #TaskTracker!
Tarea class
	instanceVariableNames: ''!

!Tarea class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:53:10'!
conNombre: unNombre fechaDeInicio: unaFechaDeInicio horasEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes   
	^self new inicializarCon: unNombre fechaDeInicio: unaFechaDeInicio horasDeEsfuerzo: unasHorasDeEsfuerzo responsable: unResponsable dependientes: unosDependientes.! !


!classDefinition: #ProyectoTest category: #TaskTracker!
TestCase subclass: #ProyectoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaskTracker'!

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:06:40'!
test01ProyectoContieneNombre
	|tareas|
	tareas := OrderedCollection new.
	self assert: (Proyecto conNombre: 'Hey' yTareas: tareas) nombre equals: 'Hey'.! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:51:52'!
test02ProyectoContieneTareas
	| proyecto tarea tareas|
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: (FixedGregorianDate yearNumber: 2024 monthNumber: 07 dayNumber: 1) horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new.
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

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:51:52'!
"notar que un proyecto a sí mismo su fecha de inicio es la mínima de una tarea por lo que basta recursivamente con buscar la fecha mínima de todas las tareas - Tomás"
test04ProyectoArrancaEnLaFechaMasTempranaDeTareaOSubproyecto
	| proyecto tarea tareas fechaInicio|
	fechaInicio := FixedGregorianDate yearNumber: 2024 monthNumber: 07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: fechaInicio horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new.
	tareas := OrderedCollection new.
	tareas addLast: tarea.
	proyecto := Proyecto conNombre: 'Modelo' yTareas: tareas.
	
	
	self assert: (proyecto contieneTarea: tarea).
	self assert: (proyecto fechaInicio: fechaInicio).! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:51:52'!
test05ProyectoContieneSubproyectosYTareas
	| proyecto proyecto2 tareasProyecto2 proyectos tarea tareas fechaInicioTarea |
	proyectos := OrderedCollection new.
	tareas := OrderedCollection new. 
	tareasProyecto2 := OrderedCollection new.
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new. 
	tareas addLast: tarea.
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 2.
	tarea := Tarea conNombre: 'SS C' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new.
	tareas addLast: tarea.
	
	proyecto2 := Proyecto conNombre: 'Modelo' yTareas: proyectos.
	proyectos addLast: proyecto2.

	proyecto := Proyecto conNombre: 'Sistema ERP' subproyectos: proyectos tareas: tareas.
	
	
	self assert: (proyecto contieneSubproyecto: proyecto2).
	self assert: (proyecto contieneTarea: tarea).
	self assert: (proyecto fechaInicio: (FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1)).
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:51:52'!
test06TareaContieneEsfuerzoEnHorasQueToma
	|  tarea fechaInicioTarea |
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new. 
	self assert: (tarea contieneHorasEsfuerzo: 8 * hour)
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:51:52'!
test07ContieneResponsableARealizarla
	|  tarea fechaInicioTarea |
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new. 
	self assert: (tarea esResponsable: 'Alan Kay')
! !

!ProyectoTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/23/2025 11:53:25'!
test08TareaContieneTareasDependientes
	|  tarea tarea2 fechaInicioTarea dependientes|
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS A' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new. 
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea2 := Tarea conNombre: 'SS B' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: OrderedCollection new. 
	
	dependientes := OrderedCollection new.
	dependientes addLast: tarea.
	dependientes addLast: tarea2.
	
	fechaInicioTarea := FixedGregorianDate yearNumber: 2024 monthNumber:  07 dayNumber: 1.
	tarea := Tarea conNombre: 'SS C' fechaDeInicio: fechaInicioTarea horasEsfuerzo: 8 * hour responsable: 'Alan Kay' dependientes: dependientes.
	
	self assert: (tarea contieneDependientes: dependientes)
! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 39 47 57 48 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 115 112 117 124 127 61 59 39 47 57 48 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 60 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 48 17 56 64 57 53 56 61 63 53 55 53 59 56 17 123 118 116 112 111 120 17 123 118 116 112 111 120 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 56 60 65 57 62 53 64 55 59 55 58 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 87 121 118 128 108 106 123 118 53 122 123 17 56 55 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 56 60 65 60 60 53 60 58 58 62 62 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 56 55 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 55 65 57 60 65 55 55 53 63 56 55 57 59 56 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 57 59 55 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 55 61 65 60 57 53 55 55 61 56 64 60 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 59 63 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 58 55 65 56 64 53 58 56 63 57 63 56 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 63 55 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 58 91 56 56 65 60 59 65 57 56 53 60 61 62 61 57 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 112 122 126 54 112 117 110 52 122 118 109 123 126 104 121 108 54 119 121 118 128 108 106 123 118 122 54 123 104 122 114 52 123 121 104 106 114 108 121 54 91 104 122 114 91 121 104 106 114 108 121 53 122 123 17 64 63 58 56 17 52 52 52 52 52 52 52 52 52 52 17 17))!