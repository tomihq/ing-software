!classDefinition: #PowerStatus category: #'3.Replace-if-Type+State'!
Object subclass: #PowerStatus
	instanceVariableNames: 'vehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerStatus methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:27:35'!
accelerate
	^self subclassResponsibility.! !

!PowerStatus methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:27:05'!
initializePowerStatusOf: aVehicle
	vehicleToPower := aVehicle.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerStatus class' category: #'3.Replace-if-Type+State'!
PowerStatus class
	instanceVariableNames: ''!

!PowerStatus class methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:26:42'!
on: aVehicle
	^(self new) initializePowerStatusOf: aVehicle! !


!classDefinition: #PowerOff category: #'3.Replace-if-Type+State'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:28:13'!
accelerate
	^vehicleToPower acceleratePoweredOff.! !


!classDefinition: #PowerOn category: #'3.Replace-if-Type+State'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:27:59'!
accelerate
	^vehicleToPower acceleratePoweredOn.! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed powerStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'tomihq 9/23/2025 12:37:19'!
initialize
	self turnOff.
	speed := 0 * kilometer / hour.
	! !


!Vehicle methodsFor: 'move' stamp: 'tomihq 9/23/2025 12:39:49'!
accelerate
	^powerStatus accelerate.! !


!Vehicle methodsFor: 'on/off' stamp: 'tomihq 9/23/2025 12:34:10'!
turnOff
	powerStatus := PowerOff on: self.! !

!Vehicle methodsFor: 'on/off' stamp: 'tomihq 9/23/2025 12:33:58'!
turnOn
	powerStatus := PowerOn on: self! !



!Vehicle methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:28:29'!
acceleratePoweredOn
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:35:40'!
acceleratePoweredOff
	^self error: 'Can not fly when turned off'.! !

!Helicopter methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:36:24'!
acceleratePoweredOn
	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter).! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:36:01'!
acceleratePoweredOff
	^self error: 'Can not run when turned off'.! !

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 12:29:34'!
acceleratePoweredOn
	speed := speed + (20 * kilometer / hour).! !
