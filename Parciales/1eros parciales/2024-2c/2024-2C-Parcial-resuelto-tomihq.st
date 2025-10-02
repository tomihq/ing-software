!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: 'objetivo tipo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeAtaque class' category: #'2024-2C-Parcial-1'!
ItemDeAtaque class
	instanceVariableNames: ''!

!ItemDeAtaque class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 17:42:47'!
baculo
	^Baculo new.! !

!ItemDeAtaque class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:35:56'!
espadaPara: monstruo
	^Espada conObjetivo: monstruo.! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'ataque-guerrero-goblin' stamp: 'tomihq 10/2/2025 19:06:18'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo
	unMonstruo serAtacadoPorGuerrero: unGuerrero conBaculo: self.
! !

!Baculo methodsFor: 'ataque-guerrero-goblin' stamp: 'tomihq 10/2/2025 18:33:09'!
atacarSiendoGuerreroAGoblin: unGoblin
	unGoblin duplicarPV.
	! !


!Baculo methodsFor: 'ataque-mago-goblin' stamp: 'tomihq 10/2/2025 19:06:22'!
atacarSiendoMago: unMago a: unMonstruo
	unMonstruo serAtacadoPorMago: unMago conBaculo: self.
! !

!Baculo methodsFor: 'ataque-mago-goblin' stamp: 'tomihq 10/2/2025 19:19:08'!
atacarSiendoMagoAGoblin: unGoblin
	unGoblin perderTodosLosPuntosDeVida.
	! !


!Baculo methodsFor: 'ataque-aventurero-ogro' stamp: 'tomihq 10/2/2025 19:10:47'!
atacarAOgro: unOgro siendo: unAventurero
	unAventurero atacarConFuerzaA: unOgro.! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'initialization' stamp: 'tomihq 10/2/2025 19:38:13'!
initializeConObjetivo: monstruo
	objetivo := monstruo.! !

!Espada methodsFor: 'initialization' stamp: 'tomihq 10/2/2025 19:37:24'!
tieneComoObjetivoA: unMonstruo
	^objetivo = unMonstruo.! !


!Espada methodsFor: 'ataques-guerrero' stamp: 'tomihq 10/2/2025 19:09:29'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo
	(self tieneComoObjetivoA: unMonstruo) ifTrue: [unGuerrero atacarConFuerzaA: unMonstruo]

! !


!Espada methodsFor: 'ataques-mago' stamp: 'tomihq 10/2/2025 18:44:00'!
atacarSiendoMago: unMago a: unMonstruo
	unMago perderTodosLosPuntosDeVida.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:37:07'!
assertObjetivoTieneAlturaSuficiente: unObjetivo

	^ (unObjetivo tieneAlturaMenorA: 100*centimeter) ifTrue: [self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ]! !

!Espada class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:36:58'!
conObjetivo: unObjetivo
	self assertObjetivoTieneAlturaSuficiente: unObjetivo.
	^self new initializeConObjetivo: unObjetivo.
	! !

!Espada class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 15:05:00'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	^'no se puede atacar a monstruo menor a un metro'.! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'protegiendoPor'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'initialization' stamp: 'tomihq 10/2/2025 12:46:41'!
initializeProtegiendoPor: puntosDeDefensa
	protegiendoPor := puntosDeDefensa ! !


!ItemDeDefensa methodsFor: 'getters' stamp: 'tomihq 10/2/2025 12:49:56'!
puntosDeDefensa
	^protegiendoPor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 12:54:34'!
armadura
	^self new initializeProtegiendoPor: 5 * pv.! !

!ItemDeDefensa class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 12:54:31'!
escudoMagico
	^self new initializeProtegiendoPor: 3 * pv.! !


!classDefinition: #PersonajeMyA category: #'2024-2C-Parcial-1'!
Object subclass: #PersonajeMyA
	instanceVariableNames: 'puntosVida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!PersonajeMyA methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:33:08'!
initializeConPuntosDeVida: unosPuntosDeVida
	puntosVida  := unosPuntosDeVida.! !

!PersonajeMyA methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:17:48'!
perderTodosLosPuntosDeVida
	puntosVida := 0.! !

!PersonajeMyA methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:31:57'!
puntosDeDefensa

	self subclassResponsibility! !

!PersonajeMyA methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:30:59'!
recibirDaño: puntosDeDaño
	|puntosARestar| 
	puntosARestar := (puntosDeDaño - self puntosDeDefensa) max: 0.
	puntosVida := puntosVida - puntosARestar.! !

!PersonajeMyA methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:17:37'!
tienePuntosDeVida: unosPuntosDeVida
	^puntosVida = unosPuntosDeVida. ! !


!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
PersonajeMyA subclass: #Aventurero
	instanceVariableNames: 'itemsDeDefensa itemsDeAtaque fuerza'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'asserts' stamp: 'tomihq 10/2/2025 19:40:11'!
assertItemDeAtaqueFueEquipado: unItemDeAtaque

	^ (itemsDeAtaque includes: unItemDeAtaque) ifFalse: [self error: self itemNoDisponibleMensajeDeError ]! !


!Aventurero methodsFor: 'assignations' stamp: 'tomihq 10/2/2025 13:30:24'!
equiparItemDeAtaque: unItemDeAtaque
	itemsDeAtaque add: unItemDeAtaque.! !

!Aventurero methodsFor: 'assignations' stamp: 'tomihq 10/2/2025 12:48:15'!
equiparItemDeDefensa: itemDeDefensa
	itemsDeDefensa add: itemDeDefensa.! !


!Aventurero methodsFor: 'initialization' stamp: 'tomihq 10/2/2025 19:32:51'!
initializeConPuntosDeVida: puntosDeVida fuerza: unaFuerza   
	self initializeConPuntosDeVida: puntosDeVida.
	itemsDeDefensa := OrderedCollection new.
	itemsDeAtaque := OrderedCollection new.
	fuerza := unaFuerza.! !


!Aventurero methodsFor: 'calculus' stamp: 'tomihq 10/2/2025 19:14:00'!
puntosDeDefensa

	^ itemsDeDefensa sum: [:unItemDeDefensa | unItemDeDefensa puntosDeDefensa] ifEmpty: 0! !


!Aventurero methodsFor: 'errormessages' stamp: 'tomihq 10/2/2025 13:26:09'!
itemNoDisponibleMensajeDeError
	^'item no disponible'.! !


!Aventurero methodsFor: 'subclassResponsibility' stamp: 'tomihq 10/2/2025 18:08:00'!
atacarA: unMonstruo con: unItemDeAtaque
	self subclassResponsibility 
! !


!Aventurero methodsFor: 'attack' stamp: 'tomihq 10/2/2025 19:09:12'!
atacarConFuerzaA: unMonstruo
	unMonstruo recibirDaño: fuerza.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Aventurero class' category: #'2024-2C-Parcial-1'!
Aventurero class
	instanceVariableNames: ''!

!Aventurero class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:11:52'!
guerrero
	^Guerrero new initializeConPuntosDeVida: 10 * pv fuerza: 4 * pv .! !

!Aventurero class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:11:52'!
mago
	^Mago new initializeConPuntosDeVida: 15 * pv fuerza: 2 * pv .! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!


!Guerrero methodsFor: 'attack' stamp: 'tomihq 10/2/2025 19:40:01'!
atacarA: unMonstruo con: unItemDeAtaque
	self assertItemDeAtaqueFueEquipado: unItemDeAtaque.
	 ^ unItemDeAtaque atacarSiendoGuerrero: self a: unMonstruo.
! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'attack' stamp: 'tomihq 10/2/2025 19:40:06'!
atacarA: unMonstruo con: unItemDeAtaque
	self assertItemDeAtaqueFueEquipado: unItemDeAtaque.
	^ unItemDeAtaque atacarSiendoMago: self a: unMonstruo.! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
PersonajeMyA subclass: #Monstruo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:28:58'!
atacarA: unAventurero
	unAventurero recibirDaño: puntosVida! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:28:51'!
duplicarPV
	puntosVida := puntosVida  * 2.! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:32:41'!
initializeConPuntosDeVida: unosPuntosDeVida conAltura: unaAltura 
	self initializeConPuntosDeVida: unosPuntosDeVida.
	altura := unaAltura.! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 19:31:36'!
puntosDeDefensa
	^0.! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:29:11'!
serAtacadoPorGuerrero: puntosDeDaño conBaculo: unItemDeAtaque 

	self subclassResponsibility! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:29:17'!
serAtacadoPorMago: puntosDeDaño conBaculo: unItemDeAtaque 

	self subclassResponsibility! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 15:00:04'!
tieneAlturaMenorA: unaAlturaPotencial
	^altura < unaAlturaPotencial.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:15:09'!
goblin
	^Goblin new initializeConPuntosDeVida: 5 * pv conAltura: 90 * centimeter.! !

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/2/2025 18:15:09'!
ogro
	^Ogro new initializeConPuntosDeVida: 15 * pv conAltura: 220 * centimeter.! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'recibir-ataques' stamp: 'tomihq 10/2/2025 19:40:28'!
serAtacadoPorGuerrero: puntosDeDaño conBaculo: unItemDeAtaque 
	unItemDeAtaque atacarSiendoGuerreroAGoblin: self.! !

!Goblin methodsFor: 'recibir-ataques' stamp: 'tomihq 10/2/2025 19:40:31'!
serAtacadoPorMago: puntosDeDaño conBaculo: unItemDeAtaque 
	unItemDeAtaque atacarSiendoMagoAGoblin: self.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'recibir-ataques' stamp: 'tomihq 10/2/2025 19:06:55'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo 
	unBaculo atacarAOgro: self siendo: unGuerrero.! !

!Ogro methodsFor: 'recibir-ataques' stamp: 'tomihq 10/2/2025 19:06:53'!
serAtacadoPorMago: unGuerrero conBaculo: unBaculo 
	unBaculo atacarAOgro: self siendo: unGuerrero.! !


!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'tomihq 10/2/2025 15:05:17'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'tomihq 10/2/2025 12:28:35'!
crearArmadura

	^ItemDeDefensa armadura
! !

!TestMyA methodsFor: 'crear items' stamp: 'tomihq 10/2/2025 14:18:00'!
crearBaculo
	^ItemDeAtaque baculo! !

!TestMyA methodsFor: 'crear items' stamp: 'tomihq 10/2/2025 12:28:16'!
crearEscudoMagico

	^ItemDeDefensa escudoMagico
! !

!TestMyA methodsFor: 'crear items' stamp: 'tomihq 10/2/2025 13:23:49'!
crearEspadaPara: monstruo
	^ItemDeAtaque espadaPara: monstruo.
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'tomihq 10/2/2025 17:10:29'!
crearGoblin
	^Monstruo goblin.
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'tomihq 10/2/2025 11:48:07'!
crearGuerrero
	^Aventurero guerrero.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'tomihq 10/2/2025 14:07:49'!
crearMago
	^Aventurero mago.
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'tomihq 10/2/2025 17:06:01'!
crearOgro
	^Monstruo ogro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !

TestMyA initialize!