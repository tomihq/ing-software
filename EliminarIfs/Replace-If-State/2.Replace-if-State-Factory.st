!classDefinition: #Automobile category: '2.Replace-if-State-Factory'!
Object subclass: #Automobile
	instanceVariableNames: 'powerStatus speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Factory'!

!Automobile methodsFor: 'initialization' stamp: 'tomihq 9/23/2025 02:59:44'!
initialize
	self turnOff.
	speed := 0 * kilometer / hour.! !


!Automobile methodsFor: 'move' stamp: 'tomihq 9/23/2025 02:15:07'!
accelerate
	state accelerate.! !

!Automobile methodsFor: 'move' stamp: 'tomihq 9/23/2025 03:00:14'!
turnOff
	powerStatus := VehiclePowerOff on: self.! !

!Automobile methodsFor: 'move' stamp: 'tomihq 9/23/2025 03:00:08'!
turnOn
	powerStatus := VehiclePowerOn on: self.! !


!Automobile methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:57:40'!
accelerateWhenPoweredOff
	^ self error: 'no se puede acelerar si esta apagado'.! !

!Automobile methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:57:48'!
accelerateWhenPoweredOn
	speed := speed + (10 * kilometer / hour)! !


!classDefinition: #VehiclePowerStatus category: '2.Replace-if-State-Factory'!
Object subclass: #VehiclePowerStatus
	instanceVariableNames: 'vehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Factory'!

!VehiclePowerStatus methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:55:50'!
accelerate
	^self subclassResponsibility.! !

!VehiclePowerStatus methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 03:10:28'!
initializeVehiclePowerStatusOf: aVehicle
	vehicleToPower := aVehicle.! !

!VehiclePowerStatus methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 03:08:40'!
on: aVehicle
	^(self new) initializeVehiclePowerStatusOf: aVehicle.! !


!classDefinition: #VehiclePowerOff category: '2.Replace-if-State-Factory'!
VehiclePowerStatus subclass: #VehiclePowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Factory'!

!VehiclePowerOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:57:28'!
accelerate
	^vehicleToPower accelerateWhenPoweredOff.! !


!classDefinition: #VehiclePowerOn category: '2.Replace-if-State-Factory'!
VehiclePowerStatus subclass: #VehiclePowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Factory'!

!VehiclePowerOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:57:21'!
accelerate
	^vehicleToPower accelerateWhenPoweredOn.! !
