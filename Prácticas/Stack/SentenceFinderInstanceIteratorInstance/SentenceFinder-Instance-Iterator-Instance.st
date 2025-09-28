!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 10:32:31'!
isEmpty
	^self size = 0! !

!OOStack methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 10:32:23'!
size
	^contents size! !

!OOStack methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 11:12:39'!
top
	^self state topOfStack! !

!OOStack methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 10:56:51'!
topWhenEmpty
	self raiseEmptyStackError! !

!OOStack methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 10:57:01'!
topWhenNotEmpty
	^contents at: self size! !


!OOStack methodsFor: 'updating' stamp: 'ENSR 9/26/2025 11:01:37'!
pop
	|topOfStack|
	
	topOfStack := self top.
	
	contents removeLast.
	
	^topOfStack! !

!OOStack methodsFor: 'updating' stamp: 'ENSR 9/26/2025 10:37:31'!
push: aValue
	contents addLast: aValue! !


!OOStack methodsFor: 'error' stamp: 'ENSR 9/26/2025 10:35:00'!
raiseEmptyStackError
	self error: self class stackEmptyErrorDescription! !


!OOStack methodsFor: 'initialization' stamp: 'ENSR 9/26/2025 11:04:01'!
initialize
	contents := OrderedCollection new.! !


!OOStack methodsFor: 'private accessing' stamp: 'ENSR 9/26/2025 11:04:45'!
state
	^OOStackState stateFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'ENSR 9/20/2025 17:02:35'!
stackEmptyErrorDescription
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackIterator category: #'Stack-Exercise'!
Object subclass: #OOStackIterator
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:39:17'!
do: aBlock
	|auxiliarStack|
	
	auxiliarStack := OOStack new.
	
	self moveAllOnto: auxiliarStack whileDoing: aBlock.
	self moveAllOnto: auxiliarStack! !

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:32:38'!
initializeWith: aStack
	stack := aStack! !

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:34:04'!
moveAllOnto: anotherStack
	self moveAllOnto: anotherStack whileDoing: [:anElement|].! !

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:38:34'!
moveAllOnto: anotherStack whileDoing: aBlock
	[stack isEmpty not] whileTrue: [
		aBlock value: stack top.
		self moveTopOnto: anotherStack
	]! !

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:34:22'!
moveTopOnto: anotherStack
	^anotherStack push: stack pop! !

!OOStackIterator methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:38:43'!
select: aBlock
	|resultingOrderedCollection|
	
	resultingOrderedCollection := OrderedCollection new.

	self do: [:anElement | (aBlock value: anElement) ifTrue: [resultingOrderedCollection add: stack top ]].
	
	^resultingOrderedCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackIterator class' category: #'Stack-Exercise'!
OOStackIterator class
	instanceVariableNames: ''!

!OOStackIterator class methodsFor: 'enumerating' stamp: 'tomihq 9/27/2025 22:32:28'!
for: aStack
	^(self new) initializeWith: aStack! !



!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 10:45:41'!
topOfStack
	self subclassResponsibility! !


!OOStackState methodsFor: 'initialization' stamp: 'ENSR 9/26/2025 10:50:39'!
initializeWithStack: aStack
	stack := aStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'evaluating' stamp: 'ENSR 9/26/2025 10:52:29'!
canHandle: aStack
	self subclassResponsibility! !

!OOStackState class methodsFor: 'evaluating' stamp: 'ENSR 9/26/2025 11:08:17'!
stateFor: aStack
	^(self subclasses detect: [:anOOStackStateSubclass | anOOStackStateSubclass canHandle: aStack]) for: aStack! !


!OOStackState class methodsFor: 'instance creation' stamp: 'ENSR 9/26/2025 10:52:44'!
for: aStack
	^self new initializeWithStack: aStack! !


!classDefinition: #OOStackEmptyState category: #'Stack-Exercise'!
OOStackState subclass: #OOStackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 11:11:11'!
topOfStack
	^stack topWhenEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackEmptyState class' category: #'Stack-Exercise'!
OOStackEmptyState class
	instanceVariableNames: ''!

!OOStackEmptyState class methodsFor: 'evaluating' stamp: 'ENSR 9/26/2025 10:57:50'!
canHandle: aStack
	^aStack isEmpty! !


!classDefinition: #OOStackNonEmptyState category: #'Stack-Exercise'!
OOStackState subclass: #OOStackNonEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNonEmptyState methodsFor: 'accessing' stamp: 'ENSR 9/26/2025 11:11:01'!
topOfStack
	^stack topWhenNotEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNonEmptyState class' category: #'Stack-Exercise'!
OOStackNonEmptyState class
	instanceVariableNames: ''!

!OOStackNonEmptyState class methodsFor: 'evaluating' stamp: 'ENSR 9/26/2025 10:58:05'!
canHandle: aStack
	^aStack isEmpty not! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack prefix stackIterator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:36:45'!
initializeWith: aStack and: aPrefix
	stack := aStack.
	prefix := aPrefix.
	stackIterator := OOStackIterator for: aStack. "red flag!!!! primer paso a la modularizacion. SentenceFinder no deberia conocer a ningun iterador."! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:40:35'!
iterator
	^stackIterator.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'tomihq 9/27/2025 22:37:55'!
sentences
	^ stackIterator select: [:elem | elem beginsWith: prefix].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error raising' stamp: 'ENSR 9/26/2025 12:23:22'!
raiseEmptyPrefixError
	self error: self emptyPrefixErrorDescription! !

!SentenceFinderByPrefix class methodsFor: 'error raising' stamp: 'ENSR 9/26/2025 12:23:26'!
raisePrefixWithSpacesError
	self error: self prefixWithSpacesErrorDescription! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ENSR 9/21/2025 11:35:32'!
emptyPrefixErrorDescription
	^'Prefix can''t be empty.'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ENSR 9/21/2025 11:35:59'!
prefixWithSpacesErrorDescription
	^'Prefix can''t have spaces.'! !


!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/27/2025 21:46:09'!
assertPrefixNotEmpty: aPrefix
	^ aPrefix isEmpty ifTrue: [self raiseEmptyPrefixError]! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/27/2025 21:58:25'!
assertPrefixWithoutSpaces: aPrefix

	^ (aPrefix includesSubString: ' ')  ifTrue: [self  raisePrefixWithSpacesError]! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/27/2025 21:58:15'!
assertValidPrefix: aPrefix
	self assertPrefixNotEmpty: aPrefix.
	self assertPrefixWithoutSpaces: aPrefix.! !


!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Tom 9/27/2025 22:08:52'!
for: aStack withPrefix: aPrefix
	self assertValidPrefix: aPrefix.
	^(self new) initializeWith: aStack and: aPrefix.! !


!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'tomihq 9/26/2025 12:59:32'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 22:02:01'!
test01WontSelectSentencesOnEmptyStack
	|stack sentenceFinder|
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix for: stack withPrefix: 'Silksong'. 
	
	self assert: sentenceFinder sentences isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 22:01:54'!
test02WontSelectSentencesOnStackWithSentencesThatDontStartWithPrefix
	|stack sentenceFinder stackValues|
	stack := OOStack new.
	stackValues := self initializerForStackValues: #('Hollow Knight esta re piola.' 'Me gusta la planta de la alegria.').
	sentenceFinder := SentenceFinderByPrefix for: stack withPrefix: 'Silksong'.
	stackValues value: stack.
	
	self assert: sentenceFinder sentences isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 22:01:46'!
test03SelectsSentencesFromStackIfSentencesHavePrefix	
	| stack sentenceFinder stackValues |
	stack := OOStack new.
	stackValues := self initializerForStackValues: #('Silksong esta re piola.' 'Me gusta la planta de la alegria.').
	stackValues value: stack.
	sentenceFinder := SentenceFinderByPrefix for: stack withPrefix: 'Silksong'.
	
	self deny: sentenceFinder sentences isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 21:52:27'!
test04SelectionIsCaseSensitive
	| stack sentenceFinder stackValues | 
	stack := OOStack new.
	stackValues := self initializerForStackValues: #('Silksong esta re piola.').
	stackValues value: stack. 
	sentenceFinder := SentenceFinderByPrefix for: stack withPrefix: 'silksong'.

	self assert: sentenceFinder sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 22:01:22'!
test05CantSelectWhenPrefixIsEmpty
	|stack sentenceFinder expectedMessage|
	stack := OOStack new.
	sentenceFinder := [SentenceFinderByPrefix for: stack withPrefix: ''].
	expectedMessage := SentenceFinderByPrefix emptyPrefixErrorDescription.
	
	self should: [sentenceFinder value.]  raise: Error withExceptionDo: [:anError | self assert: anError messageText = expectedMessage ].
	"el self should tiene encapsulado el self fail si se cuelgan de throwear el msg desde el metodo llamado"! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Tom 9/27/2025 21:57:27'!
test06CantSelectWhenPrefixContainsSpaces
	| stack sentenceFinder expectedErrorMessage |
	stack := OOStack new.
	sentenceFinder := [SentenceFinderByPrefix for: stack withPrefix: ' '].
	expectedErrorMessage := SentenceFinderByPrefix prefixWithSpacesErrorDescription.
	
	self should: [sentenceFinder value] raise: Error withExceptionDo: [:anError | self assert: anError messageText = expectedErrorMessage ].
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'tomihq 9/27/2025 22:40:12'!
test07AtTheEndOfSelectionStackRemainsTheSame
	| stack auxiliarStack stackValues sentenceFinder assertResult |
	stackValues := self initializerForStackValues: #('Silksong esta re piola.' 'sILKSONG esta re piola.').
	stack := OOStack new.
	auxiliarStack := OOStack new.
	
	stackValues value: stack.
	stackValues value: auxiliarStack.
	
	sentenceFinder := SentenceFinderByPrefix for: stack withPrefix: 'Silksong'.
	 
	assertResult := true.
	"la unica manera de verificar que los elementos cambiaron es que la flag haya cambiado. El iterador no se encarga de devolver porque en el stack vamos sacando".
	sentenceFinder iterator do: [:anElement | assertResult := auxiliarStack top = anElement. auxiliarStack pop].
	
	self assert: assertResult.! !


!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'tomihq 9/26/2025 14:04:32'!
initializerForStackValues: anOrderedCollection
    ^[:aStack | anOrderedCollection do: [:value |  aStack push: value ]].! !
