!classDefinition: #Automobile2 category: #'2.Replace-if-State'!
Object subclass: #Automobile2
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile2 methodsFor: 'initialization' stamp: 'tomihq 9/23/2025 01:35:16'!
initialize
	state := AutomobileOff new.
	speed := 0 * kilometer / hour! !


!Automobile2 methodsFor: 'move' stamp: 'tomihq 9/23/2025 01:36:03'!
accelerate
	state accelerate: speed.! !

!Automobile2 methodsFor: 'move' stamp: 'tomihq 9/23/2025 01:35:36'!
turnOn
	state := AutomobileOn new.! !


!classDefinition: #AutomobileOff category: #'2.Replace-if-State'!
Object subclass: #AutomobileOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutomobileOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:35:47'!
accelerate: aSpeed
	^ self error: 'Can not accelerate when turned off'.! !


!classDefinition: #AutomobileOn category: #'2.Replace-if-State'!
Object subclass: #AutomobileOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutomobileOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:35:55'!
accelerate: aSpeed
	^ aSpeed + (10 * kilometer / hour)! !
