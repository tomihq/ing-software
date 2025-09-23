!classDefinition: #Automobile category: '2.Replace-if-State-multiples-lugares-que-instancian'!
Object subclass: #Automobile
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian'!

!Automobile methodsFor: 'initialization' stamp: 'tomihq 9/23/2025 02:43:59'!
initialize
	state := VehiclePowerOff new.
	state setVehicleToPower: self.
	speed := 0 * kilometer / hour.
	^self.! !


!Automobile methodsFor: 'move' stamp: 'tomihq 9/23/2025 02:15:07'!
accelerate
	state accelerate.! !

!Automobile methodsFor: 'move' stamp: 'tomihq 9/23/2025 02:44:10'!
turnOn
	state := VehiclePowerOn new.
	state setVehicleToPower: self.! !


!Automobile methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:15:32'!
acceleratePowerOff
	^ self error: 'no se puede acelerar si esta apagado'.! !

!Automobile methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:16:24'!
acceleratePowerOn
	speed := speed + (10 * kilometer / hour)! !


!classDefinition: #VehiclePowerOff category: '2.Replace-if-State-multiples-lugares-que-instancian'!
Object subclass: #VehiclePowerOff
	instanceVariableNames: 'vehicle'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian'!

!VehiclePowerOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:14:45'!
accelerate
	^vehicle acceleratePowerOff.! !

!VehiclePowerOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:31:46'!
setVehicleToPower: aVehicleToPower
	vehicle := aVehicleToPower.! !


!classDefinition: #VehiclePowerOn category: '2.Replace-if-State-multiples-lugares-que-instancian'!
Object subclass: #VehiclePowerOn
	instanceVariableNames: 'vehicle'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian'!

!VehiclePowerOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:14:49'!
accelerate
	^vehicle acceleratePowerOn.! !

!VehiclePowerOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 02:32:11'!
setVehicleToPower: aVehicleToPower
	vehicle := aVehicleToPower.! !
!classDefinition: #Automobile2 category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!
Object subclass: #Automobile2
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!

!Automobile2 methodsFor: 'initialization' stamp: 'tomihq 9/23/2025 01:35:16'!
initialize
	state := VehicleOff new.
	speed := 0 * kilometer / hour! !


!Automobile2 methodsFor: 'move' stamp: 'tomihq 9/23/2025 01:36:03'!
accelerate
	state accelerate: speed.! !

!Automobile2 methodsFor: 'move' stamp: 'tomihq 9/23/2025 01:35:36'!
turnOn
	state := VehicleOn new.! !


!classDefinition: #VehicleOff category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!
Object subclass: #VehicleOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!

!VehicleOff methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:35:47'!
accelerate: aSpeed
	^ self error: 'Can not accelerate when turned off'.! !


!classDefinition: #VehicleOn category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!
Object subclass: #VehicleOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-multiples-lugares-que-instancian-y-rompe-encapsulamiento'!

!VehicleOn methodsFor: 'as yet unclassified' stamp: 'tomihq 9/23/2025 01:35:55'!
accelerate: aSpeed
	^ aSpeed + (10 * kilometer / hour)! !
