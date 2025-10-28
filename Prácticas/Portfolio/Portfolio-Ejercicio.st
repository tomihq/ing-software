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

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
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

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

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

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:13:16'!
accountsAmount
	^accounts size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:11:49'!
addAccount: anAccount
	accounts add: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:12:25'!
balance
	|currentBalance|
	currentBalance := 0.
	accounts do: [:account | currentBalance := currentBalance + account balance].
	^currentBalance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:18:00'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:12:54'!
initialize
	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:13:02'!
initializeWith: anAccount
	super initialize.
	accounts add: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:33:46'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	accounts do: [:account | 
		account transactions do: [:transaction | transactions add: transaction].
	].
	^transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'tomihq 10/28/2025 15:02:00'!
for: anAccount
	^self new initializeWith: anAccount.! !


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

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 14:58:24'!
test01PortfolioSinCuentasAsignadasTieneBalanceCero
	|portfolio|
	portfolio := Portfolio new.
	self assert: 0 equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:04:37'!
"solamente falla porque necesito incluir una forma de agregar una cuenta al portfolio"
test02PortfolioConCuentaAsignadaSinTransaccionesTieneBalance0
	|portfolio account|
	account := ReceptiveAccount new.
	portfolio := Portfolio for: account.
	self assert: 0 equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:04:11'!
"no me importa que transaccion es. Me obliga a cambiar el hardcodeo del balance."
test03PortfolioConCuentaAsignadaConTransaccionesTieneBalanceDistintoDe0
	|portfolio account|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio for: account.
	self assert: 100 equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:24:40'!
"generalizo la cantidad de cuentas que puede tener un portfolio. Este claramente generaliza el 2"
test04PortfolioTieneMasDeUnaCuentaAsignadaSinTransaccionesTieneBalance0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio for: account.
	
	account2 := ReceptiveAccount new.
	portfolio addAccount: account2.
	self assert: (portfolio accountsAmount) equals: 2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:23:58'!
"generalizo el calculo del balance para mas de una cuenta. Este claramente generaliza el 3."
test05PortfolioConMasDeUnaCuentaAsignadaConTransaccionesTieneBalanceDistintoDe0
	|portfolio account account2|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio for: account.
	
	account2 := ReceptiveAccount new.
	portfolio addAccount: account2.
	self assert: (portfolio balance > 0).! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:22:36'!
"aca la solucion es trivial. Me basta con chequear del portfolio, si alguna cuenta satisface hasRegistered"
test06TransaccionEsDeUnaCuentaAsociadaAlPortfolio
	|portfolio account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio := Portfolio for: account.
	self assert: (portfolio hasRegistered: deposit) equals: true.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:26:43'!
"creo que este deberia haber estado antes del balance? porque aca estoy hablando de cantidad de transacciones, que incluyen balances. Osea antes de haber hablado de balances antes, deberia haber considerado la cantidad de transacciones.
El tema es que cuando lo hice lei esto despues daksjdaskdja, y lo tome como otra funcionalidad
"
test07TransaccionesPortfolioEstanVaciasSiLasCuentasNoTienenTransacciones
	|portfolio account |
	account := ReceptiveAccount new.
	portfolio := Portfolio for: account.
	
	self assert: portfolio transactions size equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'tomihq 10/28/2025 15:28:03'!
"aca generalizo devolviendo la lista posta"
test08TransaccionesPortfolioNoEstanVaciasSiAlgunaCuentaTieneTransacciones
	|portfolio account deposit|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio for: account.
	
	self assert: portfolio transactions size > 0.! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !
