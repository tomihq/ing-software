!classDefinition: #MediaStat category: #MultimediaSystem!
Object subclass: #MediaStat
	instanceVariableNames: 'element count'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!MediaStat methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:52:12'!
counterAt: aCounterValue
	^count = aCounterValue.! !

!MediaStat methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:51:02'!
counterAtZero
	^count = 0.! !

!MediaStat methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:42:07'!
increment
    count := count + 1.! !

!MediaStat methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:43:07'!
initializeForElement: aMultimediaElement
	element := aMultimediaElement.
	count := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MediaStat class' category: #MultimediaSystem!
MediaStat class
	instanceVariableNames: ''!

!MediaStat class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:42:46'!
for: anElement
    ^ self new initializeForElement: anElement.! !


!classDefinition: #MultimediaElement category: #MultimediaSystem!
Object subclass: #MultimediaElement
	instanceVariableNames: 'name author duration multimediaId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:37:39'!
duration
	^duration.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:26:51'!
id
	^multimediaId.! !


!MultimediaElement methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:50:20'!
addElementsTo: aQueue
    aQueue addLast: self.! !


!MultimediaElement methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 00:20:18'!
initializeWith: aSongName author: anAuthorName duration: aSongDuration id: anId
	multimediaId := anId.
	name := aSongName.
	author := anAuthorName.
	duration := aSongDuration.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MultimediaElement class' category: #MultimediaSystem!
MultimediaElement class
	instanceVariableNames: ''!

!MultimediaElement class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:18:35'!
id: anId named: aSongName author: anAuthorName duration: aSongDuration
	^self new initializeWith: aSongName author: anAuthorName duration: aSongDuration id: anId.! !


!classDefinition: #Playlist category: #MultimediaSystem!
MultimediaElement subclass: #Playlist
	instanceVariableNames: 'multimedia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!Playlist methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:49:58'!
addElementsTo: aQueue
	multimedia do: [:each | each addElementsTo: aQueue ].! !


!Playlist methodsFor: 'initializations' stamp: 'tomihq 11/24/2025 23:42:04'!
initializeWith: aPlaylistName media: aListOfMultimediaElement.
	name := aPlaylistName.
	multimedia := aListOfMultimediaElement.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Playlist class' category: #MultimediaSystem!
Playlist class
	instanceVariableNames: ''!

!Playlist class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 23:33:29'!
named: aPlaylistName withMedia: aListOfMultimediaElement
	^self new initializeWith: aPlaylistName media: aListOfMultimediaElement.! !


!classDefinition: #Song category: #MultimediaSystem!
MultimediaElement subclass: #Song
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!


!classDefinition: #Video category: #MultimediaSystem!
MultimediaElement subclass: #Video
	instanceVariableNames: 'resolution'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!Video methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 00:19:25'!
initializeWith: aSongName author: anAuthorName duration: aSongDuration resolution: aResolution id: anId
	resolution := aResolution.
	super initializeWith:  aSongName author:  anAuthorName duration: aSongDuration id: anId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Video class' category: #MultimediaSystem!
Video class
	instanceVariableNames: ''!

!Video class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:19:58'!
id: anId named: aSongName author: anAuthorName duration: aSongDuration resolution: aResolution 
	^self new initializeWith: aSongName author: anAuthorName duration: aSongDuration resolution: aResolution id: anId.! !


!classDefinition: #Player category: #MultimediaSystem!
Object subclass: #Player
	instanceVariableNames: 'queue currentlyPlaying remainingPlayTime state playerStats'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!Player methodsFor: 'assertions' stamp: 'tomihq 11/24/2025 23:07:35'!
assertMultimediaElementNotPresentAtQueue: aMultimediaElement
	(queue includes: aMultimediaElement) ifTrue: [^self error: self class cannotAddMultimediaOfElementThatIsAlreadyPresentErrorMessage ].! !

!Player methodsFor: 'assertions' stamp: 'tomihq 11/24/2025 23:09:51'!
assertMultimediaElementPresentAtQueue: aMultimediaElement
	(queue includes: aMultimediaElement) not ifTrue: [^self error: self class cannotRemoveMultimediaOfElementIfNotPresentInQueueErrorMessage ].! !

!Player methodsFor: 'assertions' stamp: 'tomihq 11/24/2025 23:01:09'!
assertPlayerHasMultimediaElementLoaded
	currentlyPlaying = nil ifTrue: [^self error: self class cannotRequestNextMultimediaElementIfThereIsNotCurrentOneAtPlayerErrorMessage ].! !

!Player methodsFor: 'assertions' stamp: 'tomihq 11/24/2025 23:08:29'!
assertQueueNotEmpty
	self isQueueEmpty ifTrue: [^self error: self class queueIsEmptyErrorMessage].! !


!Player methodsFor: 'testing' stamp: 'tomihq 11/25/2025 01:10:43'!
accept: aVisitor
    aVisitor visitPlayer: self.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 20:56:41'!
atQueue: aMultimediaElement
	^queue includes: aMultimediaElement.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 21:11:11'!
currentMediaRemainingPlayTime: aPlayTime
	^remainingPlayTime = aPlayTime.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 21:07:44'!
isPlaying: aMultimediaElement
	^currentlyPlaying = aMultimediaElement.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 23:08:19'!
isQueueEmpty
	^queue size = 0.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 22:35:44'!
isStopped
	^state isStopped.! !

!Player methodsFor: 'testing' stamp: 'tomihq 11/24/2025 21:04:38'!
queueSize: aQueueSize
	^queue size = aQueueSize.! !


!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:07:45'!
add: aMultimediaElement
	self assertMultimediaElementNotPresentAtQueue: aMultimediaElement.
	queue add: aMultimediaElement.! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:37:48'!
addPlaylist: aPlaylist
	aPlaylist addElementsTo: queue.! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:40:01'!
advanceTime: anElapsedTime
	state advanceTime: anElapsedTime.! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/25/2025 00:44:41'!
advanceTimeWhenPlaying: anElapsedTime
	remainingPlayTime := (remainingPlayTime - anElapsedTime) max: 0.
	remainingPlayTime  = 0 ifTrue: [
		self updateMediaStats.
		self remove: currentlyPlaying.
	].! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:13:56'!
firstInQueue
	^queue first! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:05:53'!
next
	self assertPlayerHasMultimediaElementLoaded.
	self remove: currentlyPlaying.
	self play.
	
	
	
	! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:26:36'!
pause
	state pause.
	! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:19:12'!
play
	self assertQueueNotEmpty.
	state play: self firstInQueue.
	
	! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:20:51'!
playWhenNotRunning: aMultimediaElementToPlay
	currentlyPlaying := aMultimediaElementToPlay.
	remainingPlayTime := currentlyPlaying duration.! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:09:39'!
remove: aMultimediaElement
	self assertMultimediaElementPresentAtQueue: aMultimediaElement.
	queue remove: aMultimediaElement.
	(aMultimediaElement = currentlyPlaying) ifTrue: [^self stopPlayer].
	! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:40:47'!
stop
	state stop.
	! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:33:09'!
stopPlayer
	currentlyPlaying  := nil.
	remainingPlayTime := nil.
	state := StoppedState for: self.! !

!Player methodsFor: 'actions' stamp: 'tomihq 11/25/2025 00:44:52'!
updateMediaStats
	| key stat |
	key := currentlyPlaying id.

	stat := playerStats 
	    at: key 
	    ifAbsentPut: [ MediaStat for: currentlyPlaying ].

	stat increment.! !


!Player methodsFor: 'setters' stamp: 'tomihq 11/24/2025 22:28:32'!
state: aPlayerState
	state := aPlayerState.! !


!Player methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 00:23:29'!
initialize
	queue := OrderedCollection new.
	state := StoppedState for: self.
	playerStats := Dictionary new.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #MultimediaSystem!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:03:03'!
cannotAddMultimediaOfElementThatIsAlreadyPresentErrorMessage
	^'Cannot add to the queue because is already present'.! !

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:34:57'!
cannotPauseIfNotRunningErrorMessage
	^'Cannot pause player if not running'.! !

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:03:08'!
cannotRemoveMultimediaOfElementIfNotPresentInQueueErrorMessage
	^'Cannot remove an element of the queue that is not present'.! !

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 22:59:45'!
cannotRequestNextMultimediaElementIfThereIsNotCurrentOneAtPlayerErrorMessage
	^'Cannot request next multimedia element if there is not an active one'! !

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:31:49'!
cannotStopIfNotRunningErrorMessage
	^'Cannot stop player if not running'.! !

!Player class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 20:50:40'!
queueIsEmptyErrorMessage
	^'Queue is empty'.! !


!classDefinition: #PlayerReportVisitor category: #MultimediaSystem!
Object subclass: #PlayerReportVisitor
	instanceVariableNames: 'player collectedStats'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlayerReportVisitor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 01:10:01'!
initializeFor: aPlayer
	player := aPlayer.
	collectedStats := OrderedCollection new.! !

!PlayerReportVisitor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 01:10:01'!
isEmpty
	^collectedStats size = 0.
	! !

!PlayerReportVisitor methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 01:40:47'!
visitPlayer: aPlayer
    ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerReportVisitor class' category: #MultimediaSystem!
PlayerReportVisitor class
	instanceVariableNames: ''!

!PlayerReportVisitor class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:34:55'!
for: aPlayer
	^self new initializeFor: aPlayer.! !


!classDefinition: #PlayerState category: #MultimediaSystem!
Object subclass: #PlayerState
	instanceVariableNames: 'player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlayerState methodsFor: 'initializations' stamp: 'tomihq 11/24/2025 22:25:59'!
initializeFor: aPlayer
	player := aPlayer.! !


!PlayerState methodsFor: 'testing' stamp: 'tomihq 11/24/2025 22:36:01'!
isStopped
	^false.! !


!PlayerState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:38:58'!
advanceTime: anElapsedTime! !

!PlayerState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:43:33'!
pause
	^self error: player class cannotPauseIfNotRunningErrorMessage! !

!PlayerState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:22:02'!
play: aMultimediaElement
	player state: (PlayingState for: player).
	player playWhenNotRunning: aMultimediaElement.! !

!PlayerState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:41:07'!
stop
	player stopPlayer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerState class' category: #MultimediaSystem!
PlayerState class
	instanceVariableNames: ''!

!PlayerState class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 22:25:50'!
for: aPlayer
	^self new initializeFor: aPlayer! !


!classDefinition: #PausedState category: #MultimediaSystem!
PlayerState subclass: #PausedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PausedState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 23:21:12'!
play: aMultimediaElement
	player state: (PlayingState for: player).! !


!classDefinition: #PlayingState category: #MultimediaSystem!
PlayerState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlayingState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:39:11'!
advanceTime: anElapsedTime
	player advanceTimeWhenPlaying: anElapsedTime! !

!PlayingState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:28:09'!
pause
	player state: (PausedState for: player).! !


!classDefinition: #StoppedState category: #MultimediaSystem!
PlayerState subclass: #StoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!StoppedState methodsFor: 'actions' stamp: 'tomihq 11/24/2025 22:42:55'!
stop
	^self error: player class cannotStopIfNotRunningErrorMessage! !


!StoppedState methodsFor: 'testing' stamp: 'tomihq 11/24/2025 22:35:55'!
isStopped
	^true.! !


!classDefinition: #MediaStatTest category: #MultimediaSystem!
TestCase subclass: #MediaStatTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!MediaStatTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:50:40'!
test001MediaStatCounterStartsAtZero
	|mediaStat|
	mediaStat := MediaStat for: '1'.
	
	self assert: mediaStat counterAtZero.! !

!MediaStatTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:51:56'!
test002MediaStatIncrementsCounterCorrectly
	|mediaStat|
	mediaStat := MediaStat for: '1'.
	mediaStat increment.
	
	
	self deny: mediaStat counterAtZero.
	self assert: (mediaStat counterAt: 1).! !


!classDefinition: #PlayerTest category: #MultimediaSystem!
TestCase subclass: #PlayerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 20:52:51'!
test001PlayerCannotPlayIfQueueIsEmpty
	|player|
	player := Player new.
	
	self should: [player play] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
			self assert: anError messageText equals: Player queueIsEmptyErrorMessage.
			
	]! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test002AMultimediaElementCanBeAddedToTheQueueOfThePlayer
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	
	self assert: (player atQueue: song).
	self assert: (player queueSize: 1).! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test003AMultimediaElementThatIsPresentAtTheQueueCannotBeAdded
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	
	self should: [player add: song] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
		self assert: anError messageText equals: Player cannotAddMultimediaOfElementThatIsAlreadyPresentErrorMessage.
		self assert: (player queueSize: 1).
	].! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test004AMultimediaElementCannotBeRemovedOfTheQueueIfNotPresent
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.

	
	self should:  [ player remove: song.] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
		self assert: anError messageText equals: Player cannotRemoveMultimediaOfElementIfNotPresentInQueueErrorMessage.
		self assert: (player queueSize: 0)
	].! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test005AMultimediaElementCanBeRemovedOfTheQueue
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player remove: song.
	
	self deny: (player atQueue: song).! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test006PlayerPlayShouldStartPlayingFirstElementOfQueue
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	
	self assert: (player atQueue: song).
	self assert: (player isPlaying: song).
	self deny: (player isStopped)! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test007PlayerShouldTrackPlayingTimeOfAMultimediaElement
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	
	self assert: (player currentMediaRemainingPlayTime: 380 * second).
	player advanceTime: 80 * second.
	self assert: (player currentMediaRemainingPlayTime: 300 * second).
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:48:33'!
test008PlayerRemovesMultimediaElementOfQueueIfRemainingTimeIsZero
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	
	self assert: (player currentMediaRemainingPlayTime: 380 * second).
	player advanceTime: 390 * second.
	self deny: (player atQueue: song)
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 21:21:12'!
test009PlayerStartsStopped
	|player |
	player := Player new.
	
	self assert: player isStopped.
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test010PausingAndPlayingTheSameMultimediaElementShouldNotResetPlayerMultimediaElementState
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	
	player add: song.
	player play.
	player advanceTime: 300 * second.
	self assert: (player isPlaying: song).
	self assert: (player currentMediaRemainingPlayTime: 80 * second).
	
	player pause.
	player play.
	self assert: (player currentMediaRemainingPlayTime: 80 * second).
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test011PausingThePlayerAndPlayingItShouldHaveTheSameRemainingTimeOfMultimediaAsWhenPaused
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	
	player advanceTime: 300 * second.
	self assert: (player currentMediaRemainingPlayTime: 80 * second).
	
	player pause.
	player advanceTime: 10 * second.
	self assert: (player currentMediaRemainingPlayTime: 80 * second).
	
	player play.
	self assert: (player currentMediaRemainingPlayTime: 80 * second).
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test012RemovingFromQueueActualPlayingElementShouldStopPlayer
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	
	player remove: song.
	
	self assert: (player isStopped).
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test013PlayerCannotBeStoppedIfNotRunning
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	
	
	self should: [player stop.] raise: Error - MessageNotUnderstood  withExceptionDo: [:anError | 
		self assert: anError messageText equals: Player cannotStopIfNotRunningErrorMessage
	].
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test014PlayerCannotBePausedIfAMultimediaElementIsNotPlaying
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	
	self should: [player pause.] raise: Error - MessageNotUnderstood  withExceptionDo: [:anError | 
		self assert: anError messageText equals: Player cannotPauseIfNotRunningErrorMessage
	].
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:18:51'!
test015PlayerWillPlayNextMultimediaElementIfQueueIsNotEmpty
	|player song song2 |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	song2 := Song id: 2 named: 'Its my life' author: 'Bon Jovi' duration: 258 * second.
	player add: song.
	player add: song2.
	player play.
	player next.
	
	self assert: (player isPlaying: song2).
	self assert: (player atQueue: song2).

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test016PlayerWillFailIfNextMultimediaElementIsRequestedButThereIsNotCurrentOne
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	self should: [	player next.] raise: Error - MessageNotUnderstood withExceptionDo: [:anError |
		self assert: anError messageText equals: Player cannotRequestNextMultimediaElementIfThereIsNotCurrentOneAtPlayerErrorMessage.
	]

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:43'!
test017PlayerWillFailIfNextMultimediaElementIsRequestedButQueueIsEmpty
	|player song |
	player := Player new.
	song := Song id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second.
	player add: song.
	player play.
	self should: [	player next.] raise: Error - MessageNotUnderstood withExceptionDo: [:anError |
		self assert: anError messageText equals: Player queueIsEmptyErrorMessage.
		self assert: player isStopped.
	]

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:18:58'!
test018PlayerCanPlayVideo
	|player video |
	player := Player new.
	video := Video id: 1 named: 'Oops, I did it again' author: 'Britney Spears' duration: 380 * second resolution: 1920@1080.
	player add: video.
	player play.
	self assert: (player isPlaying: video).

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:19:06'!
test019PlayerQueueContainsPlaylistMediaAtSameOrderAsPlaylist
	|player video song playlist |
	player := Player new.
	video := Video id: 1 named: 'Eye Of The Tiger' author: 'Survivor Band' duration: 244 * second resolution: 1920@1080.
	song := Song id: 2 named: 'Numb' author: 'Linkin Park' duration: 187 * second.

	playlist := Playlist named: 'Music'  withMedia: {video. song} asOrderedCollection.
	
	player addPlaylist: playlist.
	player play.
	
	self assert: (player atQueue: video).
	self assert: (player atQueue: song).
	self assert: (player isPlaying: video).
	
	
	
	
	
	
	

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 00:16:12'!
test020PlayerQueueContainsEveryElementOfAPlaylistIncludingNestedPlaylists
	|player video song playlist playlist2 |
	player := Player new.
	video := Video id: 1 named: 'Eye Of The Tiger' author: 'Survivor Band' duration: 244 * second resolution: 1920@1080.
	song := Song id: 2 named: 'Numb' author: 'Linkin Park' duration: 187 * second.
	
	playlist2 := Playlist named: 'Linkin Park'  withMedia: {song} asOrderedCollection.
	playlist := Playlist named: 'Music'  withMedia: {video. playlist2} asOrderedCollection.
	
	player addPlaylist: playlist.
	player play.
	
	self assert: (player atQueue: video).
	self assert: (player atQueue: song).
	self assert: (player isPlaying: video).
	
	
	
	
	
	
	

	
	
	
	
	
	
	! !

!PlayerTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 01:06:07'!
test021PlayerReportIsEmpty
	|player statsReport |
	player := Player new.
	statsReport := PlayerReportVisitor for: player.
	
	self assert: statsReport isEmpty.

	
	
	
	
	
	
	

	
	
	
	
	
	
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 61 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 25 17 56 64 57 53 56 61 63 53 55 53 56 63 17 123 118 116 112 111 120 17 123 118 116 112 111 120 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 55 57 65 56 61 53 57 62 61 63 55 58 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 56 62 60 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 57 59 65 58 61 53 60 63 56 62 60 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 202 168 106 123 112 106 104 122 54 87 118 121 123 109 118 115 112 118 54 87 118 121 123 109 118 115 112 118 57 53 122 123 17 58 59 63 59 63 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 58 58 65 57 62 53 57 55 64 63 62 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 60 60 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 60 58 65 55 59 53 57 55 62 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 61 58 60 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 57 62 65 57 61 53 57 57 58 56 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 62 57 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 58 60 65 59 58 53 59 60 62 55 63 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 62 58 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 55 56 65 59 57 65 55 58 53 58 56 64 62 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 57 60 55 55 61 17 52 52 52 52 52 52 52 52 52 52 17 17))!