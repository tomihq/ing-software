!classDefinition: #Booleano category: 'Algebra Boole Clasificación'!
Object subclass: #Booleano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Algebra Boole Clasificación'!

!Booleano methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:39:02'!
and: aBoolean
	^self subclassResponsibility.! !

!Booleano methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:38:56'!
not
	^self subclassResponsibility.! !


!classDefinition: #Falso category: 'Algebra Boole Clasificación'!
Booleano subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Algebra Boole Clasificación'!

!Falso methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:39:34'!
and: aBoolean
	^ Falso new.! !

!Falso methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:39:49'!
not 
 ^ Verdadero new.! !


!classDefinition: #Verdadero category: 'Algebra Boole Clasificación'!
Booleano subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Algebra Boole Clasificación'!

!Verdadero methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:40:06'!
and: aBoolean
	^aBoolean.! !

!Verdadero methodsFor: 'as yet unclassified' stamp: 'Tom 9/23/2025 17:40:15'!
not
	^ Falso new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: 'Algebra Boole Clasificación'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 20:52:46'!
no
^Falso.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 21:03:02'!
siFalso: accionARealizar
	^self.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 21:00:21'!
siVerdadero: accionARealizar
	^accionARealizar value.! !


!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 20:52:46'!
no
^Falso.! !

!Verdadero class methodsFor: '-- all --' stamp: 'Tom 9/5/2025 20:53:26'!
o: unBooleano
^Verdadero.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 21:03:02'!
siFalso: accionARealizar
	^self.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'Tom 9/5/2025 21:00:21'!
siVerdadero: accionARealizar
	^accionARealizar value.! !
