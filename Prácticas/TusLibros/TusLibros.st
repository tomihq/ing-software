!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:13:39'!
test001CartStartsEmpty
	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:22:47'!
test002AddBookFromCatalogToCart
	| cart catalog catalogBooks|
	catalogBooks := OrderedCollection new.
	catalogBooks add: '1'.
	catalog := OurCatalog with: catalogBooks.
	
	cart := Cart acceptingItemsOf: catalog. 
	
	cart add: 1 of: '1'.
	
	self assert: (cart ocurrencesOf: '1') equals: 1.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:21:49'!
test003CannotAddToCartABookNotPresentInCatalog
	| cart catalog catalogBooks|

	catalogBooks := OrderedCollection new.
	catalogBooks add: '1'.
	catalog := OurCatalog with: catalogBooks.
	
	cart := Cart acceptingItemsOf: catalog.
	
	self should: [ cart add: 1 of: '2' ] 
       raise: Error withExceptionDo: [:anError | 
		self assert: cart booksAmount equals: 0.
		self assert: (anError messageText = catalog bookNotPresentAtCatalogMessage ).
	].




	
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:22:30'!
test004AddMultipleUnitsOfSameBookToCart
	| cart catalog catalogBooks|

	catalogBooks := OrderedCollection new.
	catalogBooks add: '1'.
	catalog := OurCatalog with: catalogBooks.
	cart := Cart acceptingItemsOf: catalog.
	
	cart add: 2 of: '1'.
	
	self assert: (cart ocurrencesOf: '1') equals: 2.

	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:22:37'!
test005GetCartElements
	| cart catalog catalogBooks|

	catalogBooks := OrderedCollection new.
	catalogBooks add: '1'.
	catalogBooks add: '2'.
	catalog := OurCatalog with: catalogBooks.
	cart := Cart acceptingItemsOf: catalog.
	
	
	cart add: 2 of: '1'.
	cart add: 3 of: '2'.
	
	self assert: (cart showBooks) equals: '1 | 2 | 2 | 3'.
	
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:20:27'!
test006BookQuantityShouldBePositiveToAddToCart
	| cart catalog catalogBooks |

	catalogBooks := OrderedCollection new.
	catalogBooks add: '1'.
	catalog := OurCatalog with: catalogBooks.
	
	cart := Cart acceptingItemsOf: catalog.

	
	self should: [cart add: 0 of: '1'] raise: Error withExceptionDo: [:anError |
		self assert:  (cart booksAmount) equals: 0.
		self assert: (anError messageText = cart amountOfCopiesShouldBePositiveMessage).
	].
	




	
	
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:56:13'!
booksAmount
    ^(books values) inject: 0 into: [:sum :val | sum + val]
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:13:29'!
isEmpty
	^books size = 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:14:11'!
ocurrencesOf: aBook
	^books at: aBook.! !


!Cart methodsFor: 'adding' stamp: 'Tom 11/11/2025 00:11:57'!
add: aBook
    catalog assertContainsBook: aBook.
    books at: aBook put: 1.

! !

!Cart methodsFor: 'adding' stamp: 'Tom 11/11/2025 00:13:07'!
add: anAmountOfCopies of: aBook    
    catalog assertContainsBook: aBook.
   (anAmountOfCopies <= 0) ifTrue: [self error: self amountOfCopiesShouldBePositiveMessage ].
    books at: aBook put: anAmountOfCopies.

! !


!Cart methodsFor: 'messages' stamp: 'Tom 11/11/2025 00:13:13'!
amountOfCopiesShouldBePositiveMessage
	^'The number of copies should be positive.'.! !


!Cart methodsFor: 'initializations' stamp: 'Tom 11/10/2025 23:55:59'!
initialize
	books := Dictionary new.! !

!Cart methodsFor: 'initializations' stamp: 'Tom 11/11/2025 00:01:34'!
initializeWith: aCatalog
	catalog := aCatalog.! !


!Cart methodsFor: 'print' stamp: 'Tom 11/10/2025 23:56:30'!
showBooks
    | stream first sortedKeys |
    stream := WriteStream on: String new.
    first := true.
    sortedKeys := (books keys asSortedCollection). 
    sortedKeys do: [:key |
        first ifTrue: [ first := false ] ifFalse: [ stream nextPutAll: ' | ' ].
        stream nextPutAll: key asString.
        stream nextPutAll: ' | '.
        stream nextPutAll: (books at: key) printString.
    ].
    ^stream contents
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:01:18'!
acceptingItemsOf: aCatalog
	^self new initializeWith: aCatalog.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #OurCatalog category: #TusLibros!
Object subclass: #OurCatalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:12:24'!
assertContainsBook: unIsbn
 (books includes: unIsbn) ifFalse: [
        self error: self bookNotPresentAtCatalogMessage
    ].! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:12:43'!
bookNotPresentAtCatalogMessage
	^'Book is not present at the Catalog.'.! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:11:34'!
includes: anIsbn
	^books includes: anIsbn.! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:11:34'!
initialize
	books := OrderedCollection new.! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:17:33'!
initializeWith: aListOfBooks
	books := aListOfBooks.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OurCatalog class' category: #TusLibros!
OurCatalog class
	instanceVariableNames: ''!

!OurCatalog class methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:17:41'!
with: aListOfBooks
	^self new initializeWith: aListOfBooks.! !
