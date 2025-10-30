!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:10:21'!
register: aValue on: account

	| transaction |
	
	transaction := self forAccount: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:10:21'!
forAccount: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:10:21'!
forAccount: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:13:16'!
accountsAmount
	^accounts size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:11:49'!
addAccount: anAccount
	accounts add: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:19:20'!
addPortfolio: aPortfolio
	portfolios add: aPortfolio! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:45:52'!
balance
	|currentBalance|
	currentBalance := 0.
	accounts do: [:account | currentBalance := currentBalance + account balance].
	portfolios do: [:portfolio | currentBalance := currentBalance + portfolio balance].
	^currentBalance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:44:56'!
balancePositivo
	^self balance > 0! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:30:27'!
hasRegistered: aTransaction
	^ (accounts anySatisfy: [:account | account hasRegistered: aTransaction]) or: [portfolios anySatisfy: [:portfolio | portfolio hasRegistered: aTransaction]].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:12:35'!
initialize
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:09:49'!
initializeWithAccount: anAccount
	super initialize.
	accounts add: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:09:18'!
initializeWithPortfolio: anPortfolio
	super initialize.
	portfolios add: anPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:17:37'!
portfoliosAmount
	^portfolios size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:15:07'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	accounts do: [:account | account transactions do: [:transaction | transactions add: transaction]. ].
	portfolios  do: [:portfolio | portfolio transactions do: [:transaction | transactions add: transaction]. ].
	
	^transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:10:21'!
forAccount: anAccount
	^self new initializeWithAccount: anAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:08:53'!
forPortfolio: anPortfolio
	^self new initializeWithPortfolio: anPortfolio.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
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


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:47:06'!
"caso Z"
test01PortfolioSinCuentasAsignadasTieneBalanceCero
	|portfolio|
	portfolio := Portfolio new.
	self assert: 0 equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:47:20'!
"generalizo la cantidad de cuentas que puede tener un portfolio. Este claramente generaliza el O/M"
test02PortfolioTieneMasDeUnaCuentaAsignadaSinTransaccionesTieneBalance0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio forAccount: account.
	
	account2 := ReceptiveAccount new.
	portfolio addAccount: account2.
	self assert: (portfolio accountsAmount) equals: 2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:47:28'!
"generalizo el calculo del balance para mas de una cuenta. Este claramente generaliza el O/M"
test03PortfolioConMasDeUnaCuentaAsignadaConTransaccionesTieneBalanceDistintoDe0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio forAccount: account.
	
	account2 := ReceptiveAccount new.
	portfolio addAccount: account2.
	self assert: portfolio balancePositivo.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:10:21'!
"aca la solucion es trivial. Me basta con chequear del portfolio, si alguna cuenta satisface hasRegistered"
test04TransaccionEsDeUnaCuentaAsociadaAlPortfolio
	|portfolio account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio := Portfolio forAccount: account.
	self assert: (portfolio hasRegistered: deposit) equals: true.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:10:21'!
"creo que este deberia haber estado antes del balance? porque aca estoy hablando de cantidad de transacciones, que incluyen balances. Osea antes de haber hablado de balances antes, deberia haber considerado la cantidad de transacciones.
El tema es que cuando lo hice lei esto despues daksjdaskdja, y lo tome como otra funcionalidad
"
test05TransaccionesPortfolioEstanVaciasSiLasCuentasNoTienenTransacciones
	|portfolio account |
	account := ReceptiveAccount new.
	portfolio := Portfolio forAccount: account.
	
	self assert: portfolio transactions size equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:10:21'!
"aca generalizo devolviendo la lista posta"
test06TransaccionesPortfolioNoEstanVaciasSiAlgunaCuentaTieneTransacciones
	|portfolio account deposit|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio forAccount: account.
	
	self assert: portfolio transactions size > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:21:38'!
"Caso Z. Me obliga a incluir un portfolio portfoliosAmount"
test07PortfolioNoTieneAsociadoOtroPortfolio
	|portfolio account deposit|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio forAccount: account.
	
	self assert: portfolio transactions size > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:21:47'!
"caso O. Me obliga a hardcodear que es un unico portfolio"
test08PortfolioManejaUnPortfolioDiferente
	|portfolio portfolio2 |
	portfolio2 := Portfolio new.
	portfolio := Portfolio forPortfolio: portfolio2.
	
	self assert: (portfolio portfoliosAmount) > 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:23:58'!
"Caso M: aca ya el portfolio es una lista"
test09PortfolioConMasDeUnPortfolioAsignado
	|portfolio portfolio2 portfolio3 |
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio := Portfolio forPortfolio: portfolio2.
	portfolio addPortfolio: portfolio3.
	
	self assert: (portfolio portfoliosAmount) > 1.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:23:23'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)"
test10TransaccionesPortfolioEstanVaciasSiSoloContienePortfolioQueNoTieneTransacciones
	|portfolio portfolio2 |
	portfolio2 := Portfolio new.
	portfolio := Portfolio forPortfolio: portfolio2.
	
	self assert: (portfolio transactions size) = 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:27:51'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)
Aca me fuerza a agregar el contado de las transacciones de los portfolios
"
test11CantidadTransaccionesPortfolioEsLaCantidadDeTransaccionesDelPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio forAccount: account.
	portfolio := Portfolio forPortfolio: portfolio2.
	
	self assert: (portfolio transactions size) = 1.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:48:08'!
"Aca empiezo con la rama transacciones con portfolios (me da igual si es uno o 2 portfolios. Ya probe lo de las cantidades)
Acá me fuerza a incluir en hasRegistered la búsqueda en portfolio.
"
test12PortfolioContieneTransaccionDeUnaCuentaAsociadaAUnPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio forAccount: account.
	portfolio := Portfolio forPortfolio: portfolio2.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:46:10'!
test13PortfolioTieneBalancePositivoPorTransaccionDeUnaCuentaAsociadaAUnPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio forAccount: account.
	portfolio := Portfolio forPortfolio: portfolio2.
	
	self assert: portfolio balancePositivo.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:10:21'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit forAccount: 200.
	withdraw := Withdraw forAccount: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
! !
