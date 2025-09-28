!classDefinition: #VehicleTests category: #'4.Replace-if-All'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:25:03'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:27:17'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:20'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := Vehicle electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:16'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := Vehicle gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:11'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := Vehicle helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:47:14'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:05'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:53:50'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:55:32'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!classDefinition: #Engine category: #'4.Replace-if-All'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Engine class' category: #'4.Replace-if-All'!
Engine class
	instanceVariableNames: ''!

!Engine class methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:54:13'!
accelerationFor: aSpeed
	^ self subclassResponsibility.! !


!classDefinition: #ElectricEngine category: #'4.Replace-if-All'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!ElectricEngine methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:55:05'!
accelerationFor: aSpeed
	^ (aSpeed + (5 * kilometer / hour)) * 2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElectricEngine class' category: #'4.Replace-if-All'!
ElectricEngine class
	instanceVariableNames: ''!

!ElectricEngine class methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:54:43'!
accelerationFor: aSpeed
	^ (aSpeed + (5 * kilometer / hour)) * 2! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-All'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!GasolineEngine methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:55:44'!
accelerationFor: aSpeed
	^ 10 * kilometer / hour! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-All'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!JetFueledEngine methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:56:29'!
accelerationFor: aSpeed
	^((aSpeed amount + 1) ^ 2) * kilometer / hour ! !


!classDefinition: #Place category: #'4.Replace-if-All'!
Object subclass: #Place
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Place class' category: #'4.Replace-if-All'!
Place class
	instanceVariableNames: ''!

!Place class methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:02:52'!
maxSpeedAllowed
	^self subclassResponsibility.! !


!classDefinition: #City category: #'4.Replace-if-All'!
Place subclass: #City
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!City methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:03:15'!
maxSpeedAllowed
	^70 * kilometer / hour.! !


!classDefinition: #OpenRoad category: #'4.Replace-if-All'!
Place subclass: #OpenRoad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!OpenRoad methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:03:52'!
maxSpeedAllowed
	^130 * kilometer/hour.! !


!classDefinition: #Skies category: #'4.Replace-if-All'!
Place subclass: #Skies
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Skies methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:04:02'!
maxSpeedAllowed
	^500 * kilometer/hour.! !


!classDefinition: #PowerState category: #'4.Replace-if-All'!
Object subclass: #PowerState
	instanceVariableNames: 'vehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!PowerState methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:44:52'!
initializePowerStateFor: aVehicle
	vehicleToPower := aVehicle.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerState class' category: #'4.Replace-if-All'!
PowerState class
	instanceVariableNames: ''!

!PowerState class methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:41:06'!
accelerate
	^self subclassResponsibility.! !

!PowerState class methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:44:59'!
for: aVehicle
	^(self new) initializePowerStateFor: aVehicle.! !


!classDefinition: #PowerStateOff category: #'4.Replace-if-All'!
PowerState subclass: #PowerStateOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!PowerStateOff methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:42:38'!
accelerate
	^vehicleToPower accelerateWhenPowerOff.! !


!classDefinition: #PowerStateOn category: #'4.Replace-if-All'!
PowerState subclass: #PowerStateOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!PowerStateOn methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:45:38'!
accelerate
	^ vehicleToPower accelerateWhenPowerOn! !


!classDefinition: #SpeedLimiter category: #'4.Replace-if-All'!
Object subclass: #SpeedLimiter
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!SpeedLimiter methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:33:11'!
initializeWithLimit: aLimit
	limit := aLimit.! !

!SpeedLimiter methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:38:15'!
limit: aSpeed
	^ aSpeed min:limit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpeedLimiter class' category: #'4.Replace-if-All'!
SpeedLimiter class
	instanceVariableNames: ''!

!SpeedLimiter class methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:35:32'!
forCity
	|city|
	city := City new.
	^(self new) initializeWithLimit: city maxSpeedAllowed.! !

!SpeedLimiter class methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:36:49'!
forOpenRoad
	|openRoad|
	openRoad := OpenRoad new.
	^(self new) initializeWithLimit: openRoad maxSpeedAllowed.! !

!SpeedLimiter class methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:37:00'!
forSkies
	|skies|
	skies := Skies new.
	^(self new) initializeWithLimit: skies maxSpeedAllowed.! !


!classDefinition: #Vehicle category: #'4.Replace-if-All'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerStatus actualSpeed engine inPlace speedLimiter'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Vehicle methodsFor: 'initialization' stamp: 'Tom 9/28/2025 00:48:02'!
"inicializa todo lo que tienen en comun todos los vehiculos"
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter
	self turnOff.
	actualSpeed := 0.
	engine := anEngine.
	speedLimiter := aSpeedLimiter.
! !


!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:23:27'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'Tom 9/28/2025 00:15:01'!
turnOff
	powerStatus := PowerStateOff for: self.
	actualSpeed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'Tom 9/28/2025 00:15:06'!
turnOn
	powerStatus := PowerStateOn for: self.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-All'!
Vehicle class
	instanceVariableNames: ''!


!Vehicle class methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:44:36'!
withEngine: anEngine andSpeedLimiter: aSpeedLimiter
	^(self new) initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter.! !


!classDefinition: #Helicopter category: #'4.Replace-if-All'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Helicopter methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:46:20'!
accelerateWhenPowerOff
	^'Can not fly when turned off'! !

!Helicopter methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:28:28'!
accelerateWhenPowerOn
	actualSpeed := speedLimiter limit: self accelerationSpeed. 
	altitude := altitude + (5 * meter).
	
	! !

!Helicopter methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:06:13'!
altitude
	^altitude.! !

!Helicopter methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:19:05'!
initializeWithType: typeToTake engineType: anEngineType andSurroundings: surroundings
	super initializeWithType: typeToTake engineType: anEngineType andSurroundings: surroundings.
	altitude := 0.

! !


!classDefinition: #Motorcycle category: #'4.Replace-if-All'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-All'!

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 23:46:38'!
accelerateWhenPowerOff
	^'Can not run when turned off'! !

!Motorcycle methodsFor: 'as yet unclassified' stamp: 'Tom 9/28/2025 00:19:52'!
accelerateWhenPowerOn
	|acceleration|

	acceleration := engine accelerationFor: actualSpeed.
	actualSpeed := actualSpeed + acceleration.
	! !
