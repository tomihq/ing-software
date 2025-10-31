!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
register: aValue on: account

	| transaction |
	
	transaction := self with: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 14:23:17'!
affectBalance: currentBalance
	^currentBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
with: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 14:23:07'!
affectBalance: currentBalance
	^currentBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
with: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Accountable category: 'Portfolio'!
Object subclass: #Accountable
	instanceVariableNames: 'parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 15:10:24'!
balance
	^self subclassResponsibility.! !

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:04:55'!
hasAccountable: anAccountable
	 ^ self = anAccountable.! !

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 15:10:37'!
hasRegistered
	^self subclassResponsibility.! !

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:11:14'!
parent: aParent
	    parent := aParent.
! !

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:11:00'!
root
	 ^ parent ifNil: [ self ] ifNotNil: [ parent root ].! !

!Accountable methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 15:10:29'!
transactions
	^self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio'!
Accountable subclass: #Portfolio
	instanceVariableNames: 'accountables'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 14:07:18'!
"requerido por test de catedra. Responde si no tiene ninguna cuenta asignada."
accountIsEmpty
	^self accountsSize = 0! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 14:56:48'!
accountables
	^accountables.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 13:02:59'!
accountsAmount
	^(accountables select: [:accountable | accountable isKindOf: ReceptiveAccount]) size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 14:06:25'!
"requerido por test de catedra. Responde si tiene un portfolio o cuenta sin recursion"
accountsIncludes: anAccountable
	^accountables includes: anAccountable.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 14:01:52'!
"requerido por test de catedra. Devuelve la cantidad de ReceptiveAccounts o Portfolios tiene de forma directa sin recursion"
accountsSize
	^accountables size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 15:26:27'!
add: anAccountable
	self assertNoAutoreferencing: anAccountable.
	self assertNoDuplicateAccountInPortfolio: anAccountable.
	self assertNoDuplicateAccountsInChildrenOf: anAccountable.
	accountables add: anAccountable.
	anAccountable parent: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 15:25:23'!
assertNoAutoreferencing: anAccountable
	(self = anAccountable) ifTrue: [ self error: 'No se puede hacer autoreferencia a sí mismo.'].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:25:17'!
assertNoDuplicateAccountInPortfolio: anAccountable
	(self root hasAccountable: anAccountable) ifTrue: [ self error: 'Ya existe la cuenta en algún lugar del árbol'].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:25:28'!
assertNoDuplicateAccountsInChildrenOf: anAccountable
	 accountables do: [ :child |
	        (anAccountable hasAccountable: child) ifTrue: [
	            self error: 'Nodo duplicado en algún nivel del árbol'
	        ].
	    ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:52:22'!
balance
	|currentBalance|
	currentBalance := 0.
	accountables do: [:accountable | currentBalance := currentBalance + accountable balance].
	^currentBalance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:05:22'!
hasAccountable: anAccountable
	^ accountables anySatisfy: [ :child | child hasAccountable: anAccountable ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:52:33'!
hasRegistered: aTransaction
	^ accountables anySatisfy: [:account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 15:33:20'!
initialize
	accountables := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:56:11'!
initializeWithAccountables: aListOfAccountables
	super initialize.
	accountables := aListOfAccountables.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/31/2025 14:26:27'!
isBalancePositive
	^self balance > 0! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 14:41:48'!
parent: aParent
	parent := aParent! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 13:03:20'!
portfoliosAmount
	^(accountables select: [:accountable | accountable isKindOf: Portfolio]) size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:59:15'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	accountables do: [:account | account transactions do: [:transaction | transactions add: transaction]. ].
	
	^transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:55:41'!
with: anAccount
	|accounts|
	accounts := OrderedCollection new.
	accounts add: anAccount.
	^self new initializeWithAccountables: accounts.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:58:53'!
with: anAccount with: aSecondAccount
	|portfolio|
	portfolio := self with: anAccount.  
	portfolio add: aSecondAccount.      
	^portfolio! !


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Accountable subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'tomihq 10/31/2025 15:33:30'!
initialize
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'tomihq 10/28/2025 14:24:08'!
balance
      |currentBalance|
	currentBalance := 0.
	transactions do: [ :aTransaction | 
		currentBalance := aTransaction affectBalance: currentBalance
	].
	^currentBalance.
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'tomihq 10/28/2025 14:34:43'!
hasRegistered: aTransaction
	^transactions includes: aTransaction.! !


!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 14:10:06'!
"caso Z"
test01PortfolioSinCuentasAsignadasTieneBalanceCero
	|portfolio|
	portfolio := Portfolio new.
	self assert: 0 equals: (portfolio balance).
	self assert: portfolio accountIsEmpty ! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:22'!
"generalizo la cantidad de cuentas que puede tener un portfolio. Este claramente generaliza el O/M"
test02PortfolioTieneMasDeUnaCuentaAsignadaSinTransaccionesTieneBalance0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	self assert: (portfolio accountsAmount) equals: 2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 14:26:27'!
"generalizo el calculo del balance para mas de una cuenta. Este claramente generaliza el O/M"
test03PortfolioConMasDeUnaCuentaAsignadaConTransaccionesTieneBalanceDistintoDe0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	self assert: portfolio isBalancePositive.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 14:10:21'!
"aca la solucion es trivial. Me basta con chequear del portfolio, si alguna cuenta satisface hasRegistered"
test04TransaccionEsDeUnaCuentaAsociadaAlPortfolio
	|portfolio account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:22'!
"creo que este deberia haber estado antes del balance? porque aca estoy hablando de cantidad de transacciones, que incluyen balances. Osea antes de haber hablado de balances antes, deberia haber considerado la cantidad de transacciones.
El tema es que cuando lo hice lei esto despues daksjdaskdja, y lo tome como otra funcionalidad
"
test05TransaccionesPortfolioEstanVaciasSiLasCuentasNoTienenTransacciones
	|portfolio account |
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self assert: portfolio transactions size equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:21'!
"aca generalizo devolviendo la lista posta"
test06TransaccionesPortfolioNoEstanVaciasSiAlgunaCuentaTieneTransacciones
	|portfolio account deposit|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: portfolio transactions size > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:22'!
"Caso Z. Me obliga a incluir un portfolio portfoliosAmount"
test07PortfolioNoTieneAsociadoOtroPortfolio
	|portfolio account deposit|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: portfolio transactions size > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 14:13:35'!
"caso O. Me obliga a hardcodear que es un unico portfolio.
¿Tiene sentido que tenga un portfoliosAmount si necesito saber la cantidad de portfolios que hay en total manejados por el portfolio?
Pregunto esto porque si bien Account y Portfolio se comportan igual, podría necesitar saber cuántos portfolios maneja un portfolio en total.
"
test08PortfolioManejaUnPortfolioDiferente
	|portfolio portfolio2 |
	portfolio2 := Portfolio new.
	portfolio := Portfolio with: portfolio2.
	
	self assert: (portfolio portfoliosAmount) > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:18'!
"Caso M: aca ya el portfolio es una lista"
test09PortfolioConMasDeUnPortfolioAsignado
	|portfolio portfolio2 portfolio3 |
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio := Portfolio with: portfolio2 with: portfolio3.
	
	self assert: (portfolio portfoliosAmount) > 1.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:20'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)"
test10TransaccionesPortfolioEstanVaciasSiSoloContienePortfolioQueNoTieneTransacciones
	|portfolio portfolio2 |
	portfolio2 := Portfolio new.
	portfolio := Portfolio with: portfolio2.
	
	self assert: (portfolio transactions size) = 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:33'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)
Aca me fuerza a agregar el contado de las transacciones de los portfolios
"
test11CantidadTransaccionesPortfolioEsLaCantidadDeTransaccionesDelPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio with: account.
	portfolio := Portfolio with: portfolio2.
	
	self assert: (portfolio transactions size) = 1.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:38'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)
Acá me fuerza a incluir en hasRegistered la búsqueda en portfolio.
"
test12PortfolioContieneTransaccionDeUnaCuentaAsociadaAUnPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio with: account.
	portfolio := Portfolio with: portfolio2.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 14:26:27'!
test13PortfolioTieneBalancePositivoPorTransaccionDeUnaCuentaAsociadaAUnPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio with: account.
	portfolio := Portfolio with: portfolio2.
	
	self assert: portfolio isBalancePositive.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 14:09:01'!
"me obliga a implementar accountsIncludes que me dice si en la lista sin recursion esta el portfolio o cuenta. Como en este momento la lista es polimórfica no me preocupa diferenciar si es portfolio o cuenta."
test14PortfolioIncluyeHijoDirecto
	|portfolio portfolio2 account |
	account := ReceptiveAccount new.
	portfolio2 := Portfolio with: account.
	portfolio := Portfolio with: portfolio2.
	
	self assert: (portfolio accountsIncludes: portfolio2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 15:26:17'!
test15FallaSiPortfolioSeQuiereAgregarASíMismo
	 | portfolio |
	 portfolio := Portfolio new.
	
	  self should: [ portfolio add: portfolio ] raise: Error withExceptionDo: [:anError |
	        self assert: portfolio accountsSize equals: 0
	    ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 15:18:22'!
test16FallaSiAgregaCuentaQueYaEsHijoDirectoDePortfolio
	 | account portfolio |
	 account := ReceptiveAccount new.
	 portfolio := Portfolio new.
	 portfolio add: account.

	  self should: [portfolio add: account] raise: Error withExceptionDo: [:anError |
	        self assert: portfolio accountsSize equals: 1
	    ].
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 15:18:19'!
"Solo subís"
test17FallaSiAgregaPortfolioQueContieneCuentaQueYaEsHijaDePortfolio
	    | account portfolio portfolio2 |
	    account := ReceptiveAccount new.
	    portfolio := Portfolio new.
	    portfolio add: account.

	    portfolio2 := Portfolio new.
	    portfolio2 add: account.


	    self should: [
	        portfolio add: portfolio2
	    ] raise: Error withExceptionDo: [:anError |
	        self assert: portfolio accountsSize equals: 1
	    ].
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/31/2025 15:18:17'!
"Mirás otra rama"
test18FallaSiAgregaPortfolioConCuentaDuplicadaEnOtroPortfolioDeOtraRama
	   | account account2 portfolio portfolio2 portfolio3 |
    
	    account := ReceptiveAccount new.
	    portfolio := Portfolio new.
	    portfolio add: account.

	    account2 := ReceptiveAccount new.
	    portfolio2 := Portfolio new.
	    portfolio2 add: account2.

	
	    portfolio add: portfolio2.
	
	    portfolio3 := Portfolio new.
	    portfolio3 add: account.

	    self should: [portfolio add: portfolio3] raise: Error withExceptionDo: [:anError |
	        self assert: portfolio accountsSize equals: 2
	    ].! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 14:41:54'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.	
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:22'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit with: 200.
	withdraw := Withdraw with: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
! !
