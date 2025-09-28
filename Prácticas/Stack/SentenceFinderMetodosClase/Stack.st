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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ENSR 9/26/2025 12:07:58'!
test01WontSelectSentencesOnEmptyStack
	self onNewStackRun: [:aStack | self assert: (SentenceFinderByPrefix from: aStack selectSentencesStartingWith: 'Silksong') isEmpty]
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'tomihq 9/26/2025 14:04:32'!
test02WontSelectSentencesOnStackWithSentencesThatDontStartWithPrefix
	|stackValues|
	stackValues := self initializerForStackValues: #('Hollow Knight esta re piola.' 'Me gusta la planta de la alegria.').
	self onNewStackWith: stackValues run: [:aStack | self assert: (SentenceFinderByPrefix from: aStack selectSentencesStartingWith: 'Silksong') isEmpty]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'tomihq 9/26/2025 14:04:32'!
test03SelectsSentencesFromStackIfSentencesHavePrefix	
	| stackValues |
	stackValues := self initializerForStackValues: #('Silksong esta re piola.' 'Me gusta la planta de la alegria.').
	self onNewStackWith: stackValues
	run: [:aStack | self deny: (SentenceFinderByPrefix from: aStack selectSentencesStartingWith: 'Silksong') isEmpty]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'tomihq 9/26/2025 14:04:32'!
test04SelectionIsCaseSensitive
	self onNewStackWith: (self initializerForStackValues: #('Silksong esta re piola.'))
	run: [:aStack | self assert: (SentenceFinderByPrefix from: aStack selectSentencesStartingWith: 'silksong') isEmpty]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ENSR 9/26/2025 12:21:43'!
test05CantSelectWhenPrefixIsEmpty
	self onNewStackRun: [:aStack |
		self
		should: [ SentenceFinderByPrefix from: aStack selectSentencesStartingWith: '' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]
	]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'ENSR 9/26/2025 12:13:52'!
test06CantSelectWhenPrefixContainsSpaces
	self onNewStackRun: [:aStack |
		self
		should: [ SentenceFinderByPrefix from: aStack selectSentencesStartingWith: ' ' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription ]
	]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'tomihq 9/26/2025 14:49:48'!
test07AtTheEndOfSelectionStackRemainsTheSame
	| controlStack |
	
	controlStack := OOStack new push: 'Silksong esta re piola.'; push: 'sILKSONG esta re piola.'.
	self onNewStackWith: (self initializerForStackValues: #('Silksong esta re piola.' 'sILKSONG esta re piola.'))
	do: [:aStack | SentenceFinderByPrefix from: aStack selectSentencesStartingWith: 'Silksong']
	thenRun: [:aStack |
		| assertResult | 
		assertResult := true. 
		OOStackIterator withElementsOf: aStack do: [:anElement | assertResult := controlStack top = anElement. controlStack pop]. 
		self assert: assertResult.
	]! !


!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'tomihq 9/26/2025 14:04:32'!
initializerForStackValues: anOrderedCollection
    ^[:aStack | anOrderedCollection do: [:value |  aStack push: value ]].! !

!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'ENSR 9/26/2025 12:06:35'!
onNewStackRun: aTest
	self onNewStackWith: [:aStack |] run: aTest
	! !

!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'ENSR 9/26/2025 12:05:41'!
onNewStackWith: anInitialization do: anOperation thenRun: aTest
	| stack |
	stack := OOStack new.
	anInitialization value: stack.
	anOperation value: stack.
	aTest value: stack.! !

!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'tomihq 9/26/2025 13:50:16'!
onNewStackWith: anInitialization run: aTest
	self onNewStackWith: anInitialization do: [:aStack |] thenRun: aTest! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackIterator class' category: #'Stack-Exercise'!
OOStackIterator class
	instanceVariableNames: ''!

!OOStackIterator class methodsFor: 'enumerating' stamp: 'tomihq 9/26/2025 14:49:30'!
from: aStack select: aBlock
	|resultingOrderedCollection|
	
	resultingOrderedCollection := OrderedCollection new.

	self withElementsOf: aStack do: [:anElement | (aBlock value: anElement) ifTrue: [resultingOrderedCollection add: aStack top ]].
	
	^resultingOrderedCollection.! !

!OOStackIterator class methodsFor: 'enumerating' stamp: 'tomihq 9/26/2025 14:54:58'!
withElementsOf: aStack do: aBlock
	|auxiliarStack|
	
	auxiliarStack := OOStack new.
	
	self moveAllFrom: aStack onto: auxiliarStack whileDoing: aBlock.
	self moveAllFrom: auxiliarStack onto: aStack! !


!OOStackIterator class methodsFor: 'private moving' stamp: 'tomihq 9/26/2025 14:54:58'!
moveAllFrom: aStack onto: anotherStack
	self moveAllFrom: aStack onto: anotherStack whileDoing: [:anElement|].! !

!OOStackIterator class methodsFor: 'private moving' stamp: 'tomihq 9/26/2025 14:55:17'!
moveAllFrom: aStack onto: anotherStack whileDoing: aBlock
	[aStack isEmpty not] whileTrue: [
		aBlock value: aStack top.
		self moveTop: aStack onto: anotherStack
	]! !

!OOStackIterator class methodsFor: 'private moving' stamp: 'tomihq 9/26/2025 14:55:17'!
moveTop: aStack onto: anotherStack
	^anotherStack push: aStack pop! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

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


!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/26/2025 17:19:07'!
assertPrefixNotEmpty: aPrefix

	^ aPrefix isEmpty ifTrue: [self raiseEmptyPrefixError]! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/26/2025 17:19:28'!
assertPrefixWithoutSpaces: aPrefix

	^ (aPrefix includesSubString: ' ')  ifTrue: [self raisePrefixWithSpacesError]! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'Tom 9/26/2025 17:19:28'!
assertValidPrefix: aPrefix
	self assertPrefixNotEmpty: aPrefix.
	self assertPrefixWithoutSpaces: aPrefix! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'tomihq 9/26/2025 12:44:01'!
from: aStack selectSentencesStartingWith: aPrefix
	self assertValidPrefix: aPrefix.
	^self sentencesByPrefix: aPrefix InStack: aStack! !

!SentenceFinderByPrefix class methodsFor: 'inspecting' stamp: 'tomihq 9/26/2025 12:44:28'!
sentencesByPrefix: aPrefix InStack: aStack
	^ OOStackIterator from: aStack select: [:elem | elem beginsWith: aPrefix]! !
