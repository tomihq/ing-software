!classDefinition: #Automobile1 category: #'1.Replace-if-Strategy'!
Object subclass: #Automobile1
	instanceVariableNames: 'speed engine'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Strategy'!
!Automobile1 commentStamp: '<historical>' prior: 0!
|automobile|
automobile := Automobile initialize: #ElectricEngine.
!


!Automobile1 methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:26:47'!
accelerate
	speed := speed + (engine contributionToSpeed: speed).! !

!Automobile1 methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:27:47'!
initialize: aEngine
	engine := aEngine.
	speed := 0 * kilometer / hour.! !


!classDefinition: #Engine category: #'1.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Strategy'!

!Engine methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 14:26:29'!
contributionToSpeed: aSpeed
	^self subclassResponsibility ! !


!classDefinition: #ElectricEngine category: #'1.Replace-if-Strategy'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Strategy'!

!ElectricEngine methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 14:16:54'!
contributionToSpeed: aSpeed
	^ (aSpeed + (5 * kilometer / hour))* 2! !


!classDefinition: #GasolineEngine category: #'1.Replace-if-Strategy'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Strategy'!

!GasolineEngine methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 14:18:06'!
contributionToSpeed: aSpeed
	^ aSpeed + (10 * kilometer / hour)! !


!classDefinition: #JetFueledEngine category: #'1.Replace-if-Strategy'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Strategy'!

!JetFueledEngine methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 14:19:20'!
contributionToSpeed: aSpeed
	^ ((aSpeed amount + 1 ) ^2) * kilometer / hour.! !
