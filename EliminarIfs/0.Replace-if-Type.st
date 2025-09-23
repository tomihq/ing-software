!classDefinition: #Vehicle0 category: #'0.Replace-if-Type'!
Object subclass: #Vehicle0
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Type'!


!classDefinition: #Helicopter category: #'0.Replace-if-Type'!
Vehicle0 subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Type'!

!Helicopter methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:21:09'!
accelerate
	speed := speed + (10 * kilometer / hour). 
	altitude := altitude + (5*meter). ! !

!Helicopter methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 13:09:42'!
initialize
	speed := 0 * kilometer / hour.
	altitude := 0 * meter
	! !


!classDefinition: #Motorcycle category: #'0.Replace-if-Type'!
Vehicle0 subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '0.Replace-if-Type'!

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:20:58'!
accelerate
	speed := speed + (20 * kilometer / hour).
	! !

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'tomihq 9/22/2025 13:09:51'!
initialize
	speed := 0 * kilometer / hour.! !
