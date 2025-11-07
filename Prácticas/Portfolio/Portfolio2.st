!classDefinition: #PortfolioTest category: 'Portfolio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 02:35:39'!
"no creo que sea relevante este test. Pero parece relevante por el simple hecho de que los portfolios tienen 'nombre'. Me obliga a crear el mensaje de creación de instancia."
test16PortfolioIsNamed
	| portfolio |
	portfolio := Portfolio named: 'Portfolio de la familia'.
	self assert: portfolio isNamed.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 02:48:21'!
"no creo que sea relevante este test. Pero parece relevante por el simple hecho de que los portfolios tienen 'nombre'. Me obliga a crear el mensaje de creación de instancia."
test17PortfolioTreeReportIncludesAnAccount
	| portfolio account expectedReport |
	account := ReceptiveAccount named: 'Cuenta de Furfi'.
	portfolio := Portfolio named: 'Portfolio de la familia' with: account.
	expectedReport := OrderedCollection new; yourself; add: 'Portfolio de la familia'; add: '   Cuenta de Furfi'.
	self assert: portfolio report equals: expectedReport.
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 02:38:33'!
test08AccountCanBeNamed

	| account |
	
	account := ReceptiveAccount named: 'Cuenta de Furfi'.

	self assert: (account isNamed).
! !


!classDefinition: #ReportTest category: 'Portfolio2'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:53:05'!
testAccountSummaryWithDepositHasCorrectFormatting
	| account accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 5 on: account.
	
	accountSummary := (AccountSummary on: account) lines.
	
	self assert: accountSummary first = 'Depósito por 5'.
	self assert: accountSummary last = 'Balance = 5'.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:51:46'!
testAccountSummaryWithTransferenceDepositHasCorrectFormatting
	| sourceAccount receptorAccount receptorAccountSummary |
	
	sourceAccount := ReceptiveAccount new.
	receptorAccount := ReceptiveAccount new.
	Transference take: 5 from: sourceAccount to: receptorAccount.
	
	receptorAccountSummary :=  (AccountSummary on: receptorAccount) lines.
	
	self assert: receptorAccountSummary first = 'Entrada por transferencia de 5'.
	self assert: receptorAccountSummary last = 'Balance = 5'.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:51:43'!
testAccountSummaryWithTransferenceWithdrawHasCorrectFormatting
	| sourceAccount receptorAccount sourceAccountSummary |
	
	sourceAccount := ReceptiveAccount new.
	receptorAccount := ReceptiveAccount new.
	Transference take: 5 from: sourceAccount to: receptorAccount.
	
	sourceAccountSummary :=  (AccountSummary on: sourceAccount) lines.
	
	self assert: sourceAccountSummary first = 'Salida por transferencia de 5'.
	self assert: sourceAccountSummary last = 'Balance = -5'.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:51:39'!
testAccountSummaryWithWithdrawHasCorrectFormatting
	| account accountSummary |
	
	account := ReceptiveAccount new.
	Withdraw register: 5 on: account.
	
	accountSummary :=  (AccountSummary on: account) lines.
	
	self assert: accountSummary first = 'Extracción por 5'.
	self assert: accountSummary last = 'Balance = -5'.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:51:56'!
testEmptyAccountSummaryOnlyKnowsBalance
	| account accountSummary |
	
	account := ReceptiveAccount new.
	accountSummary :=  (AccountSummary on: account) lines.
	
	self assert: accountSummary last = 'Balance = 0'.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:52:17'!
testNetTransferIsZeroForAccountWithoutTransactions
	| account |
	
	account := ReceptiveAccount new.
	
	self assert:  (AccountTransferNet on: account) value = 0.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:52:31'!
testTransferenceAffectsNetTransferenceOfReceptorAccount
	| sourceAccount receptorAccount |
	
	sourceAccount := ReceptiveAccount new.
	receptorAccount := ReceptiveAccount new.
	
	Transference take: 5 from: sourceAccount to: receptorAccount.
	
	self assert: (AccountTransferNet on: receptorAccount) value = 5.! !

!ReportTest methodsFor: 'tests' stamp: 'Tom 11/7/2025 01:52:42'!
testTransferenceAffectsNetTransferenceOfSourceAccount
	| sourceAccount receptorAccount |
	
	sourceAccount := ReceptiveAccount new.
	receptorAccount := ReceptiveAccount new.
	
	Transference take: 5 from: sourceAccount to: receptorAccount.
	
	self assert: (AccountTransferNet on: sourceAccount) value= -5.! !


!classDefinition: #TransferenceTest category: 'Portfolio2'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'sourceAccount receptorAccount transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:36:24'!
testCantTransferBetweenTheSameAccount
	self initializeEqualAccounts.
	
	self should: [self betweenAccountsTransfer: 5]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: sourceAccount transactions isEmpty.
			self assert: transference isNil.
			self assert: anException messageText = Transference tryingToTransferFromAndToTheSameAccountErrorDescription
		]! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:36:35'!
testCantTransferNonPositiveAmountOfMoney
	self initializeDifferentAccounts.
	
	self should: [self betweenAccountsTransfer: 0]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: sourceAccount balance = 0.
			self assert: sourceAccount transactions isEmpty.
			
			self assert: receptorAccount balance = 0.
			self assert: receptorAccount transactions isEmpty.
			
			self assert: transference isNil.
			self assert: anException messageText = Transference tryingToTransferANonPositiveAmountOfMoneyErrorDescription
		]! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:37:16'!
testEachAccountHoldsTheirRespectiveTransferenceTransaction
	self initializeDifferentAccounts.
	self betweenAccountsTransfer: 5.
	
	self assert: (sourceAccount hasRegistered: transference withdraw).
	self assert: (receptorAccount hasRegistered: transference deposit).! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:36:48'!
testTransferenceAffectsBalanceOfBothAccounts
	self initializeDifferentAccounts.
	self betweenAccountsTransfer: 5.
	
	self assert: sourceAccount balance = -5.
	self assert: receptorAccount balance = 5.! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:37:34'!
testTransferenceDepositHasReferenceToTransference
	self initializeDifferentAccounts.
	self betweenAccountsTransfer: 5.
	
	self assert: transference deposit transference = transference.! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:37:43'!
testTransferenceKnowsTheValueBeingTransfered
	self initializeDifferentAccounts.
	self betweenAccountsTransfer: 5.
	
	self assert: sourceAccount balance = transference value negated.
	self assert: receptorAccount balance = transference value.! !

!TransferenceTest methodsFor: 'tests' stamp: 'en 11/4/2025 12:37:27'!
testTransferenceWithdrawHasReferenceToTransference
	self initializeDifferentAccounts.
	self betweenAccountsTransfer: 5.
	
	self assert: transference withdraw transference = transference.! !


!TransferenceTest methodsFor: 'initialization' stamp: 'en 11/4/2025 10:48:07'!
betweenAccountsTransfer: anAmountOfMoney
	transference := Transference take: anAmountOfMoney from: sourceAccount to: receptorAccount! !

!TransferenceTest methodsFor: 'initialization' stamp: 'en 11/4/2025 11:14:21'!
initializeDifferentAccounts
	sourceAccount := ReceptiveAccount new.
	receptorAccount := ReceptiveAccount new.! !

!TransferenceTest methodsFor: 'initialization' stamp: 'en 11/4/2025 11:14:28'!
initializeEqualAccounts
	sourceAccount := ReceptiveAccount new.
	receptorAccount := sourceAccount.! !


!classDefinition: #Account category: 'Portfolio2'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:40:09'!
initialize
	name := ''.! !


!classDefinition: #Portfolio category: 'Portfolio2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'Tom 11/7/2025 02:39:26'!
initialize
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:35:08'!
isNamed
	^name size > 0.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:46:36'!
withName: aPortfolioName
	name := aPortfolioName.
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:46:50'!
withName: aPortfolioName andAccount: anAccount
	self withName: aPortfolioName.
	accounts add: anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:33:48'!
named: aNameForPortfolio
	^self new withName: aNameForPortfolio! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:44:36'!
named: aNameForPortfolio with: anAccount
	^self new withName: aNameForPortfolio andAccount: anAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Tom 11/7/2025 02:39:21'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'Tom 11/7/2025 01:58:52'!
summary
	^self linesOn: self transactions andBalance: self balance.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'Tom 11/7/2025 02:00:05'!
transferNet
	^self valueOf: transactions.! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:41:22'!
initializeWithName: aReceptiveAccountName
	self initialize.
	name := aReceptiveAccountName.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:41:50'!
isNamed
	^name size > 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:39:00'!
named: aNameForAReceptiveAccount
	^self new initializeWithName: aNameForAReceptiveAccount.! !


!classDefinition: #AccountReport category: 'Portfolio2'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountReport methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 01:32:54'!
initializeWith: anAccount
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio2'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 01:33:16'!
on: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio2'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:06:11'!
"aca arranca el double dispatch para que account nos provea lo que necesitamos (o eso creo) "
lines
	^account summary! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:11:08'!
"nico creo que este es el double dispatch que se llama desde AccountSummary. Esto rompe el encapsulamiento del balance del account. Pero lo hice así porque las stransferencias son radioactivas.
Pensé en dejar esta lógica en account pero creo que sería bastante tedioso de mantener si el día de mañana cambia el 'formato de la salida', y no debería ser responsabilidad de la clase Account saber de eso. 
"
linesOn: aListOfTransferences andBalance: aBalance
	^(aListOfTransferences collect: [:aTransaction |aTransaction stringForSummary ]) add: ('Balance = ', aBalance asString) ; yourself.! !


!classDefinition: #AccountTransferNet category: 'Portfolio2'!
AccountReport subclass: #AccountTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 01:49:53'!
value
	^account transferNet.! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'Tom 11/7/2025 02:04:55'!
"nico, creo que esto hace del double dispatch AccountTransferNet -> Account -> AccountTransferNet. No obstante ¿lo estamos atando a usar AccountTransferNet como objeto particular? ¿Estaría bien? ¿Qué opinás? ¿O el propio 'Account' debería conocer a estos objetos? Para mí, está bien así. Si querés el reporte, creá el Account, creá el reporte y prepará el objeto para esa acount en particular "
valueOf: aListOfTransactions
	^aListOfTransactions sum: [:aTransaction | aTransaction valueForTransferNet] ifEmpty: [0]! !


!classDefinition: #GenericTransaction category: 'Portfolio2'!
Object subclass: #GenericTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!GenericTransaction methodsFor: 'value' stamp: 'en 11/4/2025 10:58:49'!
value 
	self subclassResponsibility! !


!GenericTransaction methodsFor: 'balance' stamp: 'en 11/4/2025 10:58:46'!
affectBalance: aBalance
	self subclassResponsibility! !


!GenericTransaction methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:19:46'!
stringForSummary
	^self subclassResponsibility! !

!GenericTransaction methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:29:41'!
valueForTransferNet
	^0.! !


!classDefinition: #AccountTransaction category: 'Portfolio2'!
GenericTransaction subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:21:31'!
stringForSummary
	^'Depósito por ', self value asString! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:29:15'!
valueForTransferNet
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'Tom 11/6/2025 21:29:32'!
valueForTransferNet
	^0.! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:21:25'!
stringForSummary
	^'Extracción por ', self value asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceTransaction category: 'Portfolio2'!
GenericTransaction subclass: #TransferenceTransaction
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferenceTransaction methodsFor: 'initialization' stamp: 'en 11/4/2025 11:01:06'!
initializeFor: anAmountOfMoney asPartOf: aTransference 
	value := anAmountOfMoney.
	transference := aTransference.! !


!TransferenceTransaction methodsFor: 'transference' stamp: 'en 11/4/2025 11:01:06'!
transference
	^transference! !


!TransferenceTransaction methodsFor: 'value' stamp: 'en 11/4/2025 11:07:10'!
value
	^transference value! !


!TransferenceTransaction methodsFor: 'balance' stamp: 'en 11/4/2025 11:01:14'!
affectBalance: aBalance
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceTransaction class' category: 'Portfolio2'!
TransferenceTransaction class
	instanceVariableNames: ''!

!TransferenceTransaction class methodsFor: 'instance creation' stamp: 'en 11/4/2025 11:01:33'!
register: anAmountOfMoney on: anAccount asPartOf: aTransference
	| transaction |
	
	transaction := self new initializeFor: anAmountOfMoney asPartOf: aTransference.	
	anAccount register: transaction.

	^transaction! !


!classDefinition: #TransferenceDeposit category: 'Portfolio2'!
TransferenceTransaction subclass: #TransferenceDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferenceDeposit methodsFor: 'balance' stamp: 'en 11/4/2025 11:07:16'!
affectBalance: aBalance
	^aBalance + self value! !


!TransferenceDeposit methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:21:50'!
stringForSummary
	^'Entrada por transferencia de ', self value asString! !

!TransferenceDeposit methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:30:00'!
valueForTransferNet
	^self value.! !


!classDefinition: #TransferenceWithdraw category: 'Portfolio2'!
TransferenceTransaction subclass: #TransferenceWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferenceWithdraw methodsFor: 'balance' stamp: 'en 11/4/2025 11:07:19'!
affectBalance: aBalance
	^aBalance - self value! !


!TransferenceWithdraw methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:21:58'!
stringForSummary
	^'Salida por transferencia de ', self value asString! !

!TransferenceWithdraw methodsFor: 'as yet unclassified' stamp: 'Tom 11/6/2025 21:30:11'!
valueForTransferNet
	^self value negated.! !


!classDefinition: #Transference category: 'Portfolio2'!
Object subclass: #Transference
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Transference methodsFor: 'initialization' stamp: 'en 11/4/2025 11:07:55'!
initializeFor: anAmountOfMoney from: aWithdraw to: aDeposit
	value := anAmountOfMoney.
	withdraw := aWithdraw.
	deposit := aDeposit.! !


!Transference methodsFor: 'transactions' stamp: 'en 11/4/2025 10:40:16'!
deposit
	^deposit! !

!Transference methodsFor: 'transactions' stamp: 'en 11/4/2025 10:40:11'!
withdraw
	^withdraw! !


!Transference methodsFor: 'value' stamp: 'en 11/4/2025 11:06:52'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio2'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'en 11/4/2025 11:14:04'!
take: anAmountOfMoney from: aSourceAccount to: aReceptorAccount
	| transference withdraw deposit |
	
	self assertAnAmountOfMoneyIsPositive: anAmountOfMoney.
	self assertSource: aSourceAccount isDifferentToReceptor: aReceptorAccount.
	
	transference := self new.
	
	withdraw := TransferenceWithdraw register: anAmountOfMoney on: aSourceAccount asPartOf: transference.
	deposit := TransferenceDeposit register: anAmountOfMoney on: aReceptorAccount asPartOf: transference.
	
	^transference initializeFor: anAmountOfMoney from: withdraw to: deposit! !


!Transference class methodsFor: 'error messages' stamp: 'en 11/4/2025 11:10:32'!
tryingToTransferANonPositiveAmountOfMoneyErrorDescription
	^'Trying to transfer a non positive amount of money.'! !

!Transference class methodsFor: 'error messages' stamp: 'en 11/4/2025 11:13:08'!
tryingToTransferFromAndToTheSameAccountErrorDescription
	^'Trying to transfer from and to the same account.'! !


!Transference class methodsFor: 'assertion' stamp: 'en 11/4/2025 11:11:37'!
assertAnAmountOfMoneyIsPositive: anAmountOfMoney
	^anAmountOfMoney <= 0 ifTrue: [self error: self tryingToTransferANonPositiveAmountOfMoneyErrorDescription]! !

!Transference class methodsFor: 'assertion' stamp: 'en 11/4/2025 11:13:51'!
assertSource: aSourceAccount isDifferentToReceptor: aReceptorAccount
	^aSourceAccount = aReceptorAccount ifTrue: [self error: self tryingToTransferFromAndToTheSameAccountErrorDescription]! !
