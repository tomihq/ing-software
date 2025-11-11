!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:56:40'!
test001CartStartsEmpty
	| carrito |
	carrito := Cart new. 
	self assert: carrito booksAmount equals: 0.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:57:07'!
test002AddBookFromCatalogToCart
	| carrito book catalogo libros|
	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := OurCatalog con: libros.
	
	
	carrito := Cart acceptingItemsOf: catalogo. 
	
	book := Dictionary new.
	book at: '1' put: 1.
	
	carrito add: book.
	
	self assert: carrito booksAmount equals: 1.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:01:59'!
test003CannotAddToCartABookNotPresentInCatalog
	| carrito book catalogo libros|

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := OurCatalog con: libros.
	
	carrito := Cart acceptingItemsOf: catalogo.
	
	book := Dictionary new. "isbn"
	book at: '2' put: 1.
	self should: [ carrito add: book ] 
       raise: Error withExceptionDo: [:anError | 
		self assert: carrito booksAmount equals: 0.
		self assert: (anError messageText = 'Libro no presente en el catálogo').
	].




	
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:00:01'!
test004AddMultipleUnitsOfSameBookToCart
	| carrito book catalogo libros|

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := OurCatalog con: libros.
	
	carrito := Cart acceptingItemsOf: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	carrito add: book.
	
	self assert: carrito booksAmount equals: 2.
	




	
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:59:53'!
test005GetCartElements
	| carrito book catalogo book2 libros|

	libros := OrderedCollection new.
	libros add: '1'.
	libros add: '2'.
	catalogo := OurCatalog con: libros.
	
	carrito := Cart acceptingItemsOf: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 2.
	
	book2 := Dictionary new.
	book2 at: '2' put: 3.
	
	carrito add: book.
	carrito add: book2.
	
	self assert: (carrito showBooks) equals: '1 | 2 | 2 | 3'.
	




	
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:59:44'!
test006BookQuantityShouldBePositiveToAddToCart
	| carrito book catalogo libros |

	libros := OrderedCollection new.
	libros add: '1'.
	catalogo := OurCatalog con: libros.
	
	carrito := Cart acceptingItemsOf: catalogo.
	
	book := Dictionary new.
	book at: '1' put: 0.
	
	self should: [carrito add: book] raise: Error withExceptionDo: [:anError |
		self assert:  (carrito booksAmount) equals: 0.
		self assert: (anError messageText = 'La cantidad de unidades del libro debe ser positiva').
	].
	




	
	
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:56:04'!
add: aBook
    | isbn unidades |
    isbn := aBook keys first.
    unidades := aBook at: isbn.
    catalog assertContieneLibroConIsbn: isbn.
  

   (unidades <= 0) ifTrue: [self error: 'La cantidad de unidades del libro debe ser positiva'].

    books at: isbn put: unidades.

! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:56:13'!
booksAmount
    ^(books values) inject: 0 into: [:sum :val | sum + val]
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:55:59'!
initialize
	books := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/11/2025 00:01:34'!
initializeWith: aCatalog
	catalog := aCatalog.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:56:30'!
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


!classDefinition: #OurCatalog category: #TusLibros!
Object subclass: #OurCatalog
	instanceVariableNames: 'libros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:49:07'!
assertContieneLibroConIsbn: unIsbn
 (libros includes: unIsbn) ifFalse: [
        self error: 'Libro no presente en el catálogo'
    ].! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:32'!
inicializarCon: unConjuntoDeLibros
	libros := unConjuntoDeLibros.! !

!OurCatalog methodsFor: 'as yet unclassified' stamp: 'Tom 11/10/2025 23:49:18'!
initialize
	libros := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OurCatalog class' category: #TusLibros!
OurCatalog class
	instanceVariableNames: ''!

!OurCatalog class methodsFor: 'as yet unclassified' stamp: 'Tom 11/8/2025 22:24:08'!
con: unConjuntoDeLibros
	^self new inicializarCon: unConjuntoDeLibros.! !
