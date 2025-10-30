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

!AccountTransaction class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
register: aValue on: account

	| transaction |
	
	transaction := self with: aValue.
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

!Deposit class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
with: aValue

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

!Withdraw class methodsFor: 'instance creation' stamp: 'tomihq 10/30/2025 12:54:21'!
with: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios accountables'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 13:02:59'!
accountsAmount
	^(accountables select: [:accountable | accountable isKindOf: ReceptiveAccount]) size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:51:56'!
add: anAccountable
	accountables add: anAccountable! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:52:22'!
balance
	|currentBalance|
	currentBalance := 0.
	accountables do: [:accountable | currentBalance := currentBalance + accountable balance].
	^currentBalance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:44:56'!
balancePositivo
	^self balance > 0! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:52:33'!
hasRegistered: aTransaction
	^ accountables anySatisfy: [:account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:59:42'!
initialize
	accountables := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/30/2025 12:56:11'!
initializeWithAccountables: aListOfAccountables
	super initialize.
	accountables := aListOfAccountables.! !

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

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:21'!
"generalizo el calculo del balance para mas de una cuenta. Este claramente generaliza el O/M"
test03PortfolioConMasDeUnaCuentaAsignadaConTransaccionesTieneBalanceDistintoDe0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	self assert: portfolio balancePositivo.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 12:54:21'!
"aca la solucion es trivial. Me basta con chequear del portfolio, si alguna cuenta satisface hasRegistered"
test04TransaccionEsDeUnaCuentaAsociadaAlPortfolio
	|portfolio account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	self assert: (portfolio hasRegistered: deposit) equals: true.
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

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:08'!
"caso O. Me obliga a hardcodear que es un unico portfolio"
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

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/30/2025 13:00:40'!
test13PortfolioTieneBalancePositivoPorTransaccionDeUnaCuentaAsociadaAUnPortfolioQueGestiona
	|portfolio portfolio2 account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio2 := Portfolio with: account.
	portfolio := Portfolio with: portfolio2.
	
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
