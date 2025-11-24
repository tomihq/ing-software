!classDefinition: #MultimediaElement category: #MultimediaSystem!
Object subclass: #MultimediaElement
	instanceVariableNames: 'name duration artist state remainingTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:23:08'!
isPaused
	^state isPaused.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:22:53'!
isReproducing
	^state isReproducing.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:24:31'!
isStopped
	^state isStopped.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:18:14'!
pause
	state pause.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:17:00'!
play
	state play.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:32:38'!
resetRemainingTime
	remainingTime := duration.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:29:21'!
state: aState
	state := aState.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:18:27'!
stop
	state stop.! !


!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:15:42'!
duration
	^duration.! !

!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:11:24'!
size
	^1.! !


!MultimediaElement methodsFor: 'testing' stamp: 'tomihq 11/24/2025 14:07:58'!
goInTime: aTimeToPass
	remainingTime := remainingTime - aTimeToPass.! !

!MultimediaElement methodsFor: 'testing' stamp: 'tomihq 11/24/2025 14:03:39'!
remainingTime: aTimeToCompare
	^remainingTime = aTimeToCompare.! !


!MultimediaElement methodsFor: 'initializations' stamp: 'tomihq 11/24/2025 15:14:49'!
initializeSongWith: aName duration: aDurationInSeconds artist: anArtist
	name := aName.
	duration := aDurationInSeconds.
	artist := anArtist.
	state := StoppedState for: self.
	remainingTime := aDurationInSeconds.! !


!classDefinition: #Song category: #MultimediaSystem!
MultimediaElement subclass: #Song
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Song class' category: #MultimediaSystem!
Song class
	instanceVariableNames: ''!

!Song class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:27:21'!
named: aName duration: aDurationInSeconds artist: anArtist
	^self new initializeSongWith: aName duration: aDurationInSeconds artist: anArtist! !

!Song class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:47:50'!
notPlayingDescriptionErrorMessage
	^'Song is not playing'! !


!classDefinition: #Video category: #MultimediaSystem!
MultimediaElement subclass: #Video
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Video class' category: #MultimediaSystem!
Video class
	instanceVariableNames: ''!

!Video class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:43:08'!
named: aName duration: aDurationInSeconds artist: anArtist
	^self new initializeSongWith: aName duration: aDurationInSeconds artist: anArtist! !

!Video class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:48:02'!
notPlayingDescriptionErrorMessage
	^'Video is not playing'! !


!classDefinition: #PlaybackState category: #MultimediaSystem!
Object subclass: #PlaybackState
	instanceVariableNames: 'element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlaybackState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:30:37'!
initializeFor: aMultimediaElement
	element := aMultimediaElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlaybackState class' category: #MultimediaSystem!
PlaybackState class
	instanceVariableNames: ''!

!PlaybackState class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:11:12'!
for: aMultimediaElement
	^self new initializeFor: aMultimediaElement.! !


!classDefinition: #PausedState category: #MultimediaSystem!
PlaybackState subclass: #PausedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:24'!
isPaused
	^true.! !

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:11'!
isReproducing
	^false! !

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:15:48'!
isStopped
	^false! !

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:13:55'!
pause
! !

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:30:44'!
play
	element state: (PlayingState for: element).! !

!PausedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:30:37'!
stop
	^self error: element class notPlayingDescriptionErrorMessage ! !


!classDefinition: #PlayingState category: #MultimediaSystem!
PlaybackState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!PlayingState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:36'!
isPaused
	^false.! !

!PlayingState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:07'!
isReproducing
	^true! !

!PlayingState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:15:44'!
isStopped
	^false! !

!PlayingState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:30:59'!
pause
	element state: (PausedState for: element).! !

!PlayingState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:32:58'!
stop
	element state: (StoppedState for: element).
	element resetRemainingTime.! !


!classDefinition: #StoppedState category: #MultimediaSystem!
PlaybackState subclass: #StoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:40'!
isPaused
	^false.! !

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:16:15'!
isReproducing
	^false! !

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:15:35'!
isStopped
	^true! !

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:13:52'!
pause
! !

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:31:28'!
play
	element state: (PlayingState for: element).! !

!StoppedState methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:30:37'!
stop
	^self error: element class notPlayingDescriptionErrorMessage ! !


!classDefinition: #Playlist category: #MultimediaSystem!
Object subclass: #Playlist
	instanceVariableNames: 'name elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:20:52'!
add: aMultimediaElement
	elements add: aMultimediaElement.! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:05:34'!
play
	| multimedia |
	self assertPlaylistIsNotEmpty.
	multimedia := elements first.
	multimedia play.
	! !


!Playlist methodsFor: 'initializations' stamp: 'tomihq 11/24/2025 14:21:36'!
initializeWith: aName and: aListOfMultimediaElements
	name := aName.
	elements := aListOfMultimediaElements asOrderedCollection .! !


!Playlist methodsFor: 'testing' stamp: 'tomihq 11/24/2025 15:03:21'!
includes: aMultimediaElement
	^elements includes: aMultimediaElement.! !

!Playlist methodsFor: 'testing' stamp: 'tomihq 11/24/2025 13:55:22'!
nowPlaying: aMultimediaElement
	^elements anySatisfy: [:multimediaElement | multimediaElement isReproducing].! !


!Playlist methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:13:39'!
duration
	^elements sum: [:element | element duration].! !

!Playlist methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:11:16'!
size
	^elements sum: [:element | element size].! !


!Playlist methodsFor: 'assertions' stamp: 'tomihq 11/24/2025 15:05:45'!
assertPlaylistIsNotEmpty
	elements size = 0 ifTrue: [^self error: self class cannotPlayIfPlaylistIsEmptyErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Playlist class' category: #MultimediaSystem!
Playlist class
	instanceVariableNames: ''!

!Playlist class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:58:38'!
cannotPlayIfPlaylistIsEmptyErrorMessage
	^'Playlist do not contains elements to play'! !

!Playlist class methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:52:07'!
named: aName with: aListOfMultimediaElements
	^self new initializeWith: aName and: aListOfMultimediaElements! !


!classDefinition: #SongTest category: #MultimediaSystem!
TestCase subclass: #SongTest
	instanceVariableNames: 'name duration artist'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:36:31'!
test01CanPlaySongIfSongIsNotPlaying
	| song |
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	song play.
	
	self assert: song isReproducing.
	self deny: song isPaused.! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:40:12'!
test02CanStopSongIfIsPlaying
	| song |
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	song play.
	song stop.
	
	self deny: song isReproducing.
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:47:50'!
test03CannotStopSongIfIsNotPlaying
	| song |
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	
	self should: [song stop.] raise: Error - MessageNotUnderstood  withExceptionDo: [:anError | 
		self assert: song isStopped.
		self assert: anError messageText equals: Song notPlayingDescriptionErrorMessage.
	]
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:38:15'!
test04CanPauseSongAndPlayItLater
	| song |
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.

	song play.
	self assert: song isReproducing.
	song pause.
	self assert: song isPaused.
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:15:15'!
test05CanPlayVideoIfVideoIsNotPlaying
	| video |

	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	video play.
	self assert: video isReproducing.
	video pause.
	self assert: video isPaused.
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:15:13'!
test06CanStopVideoIfIsPlaying
	| video |

	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	video play.
	self assert: video isReproducing.
	video stop.
	self assert: video isStopped.
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:15:11'!
test07CannotStopVideoIfIsNotPlaying
	| video |

	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	self should: [video stop.] raise: Error - MessageNotUnderstood  withExceptionDo: [:anError | 
		self assert: video isStopped.
		self assert: anError messageText equals: Video notPlayingDescriptionErrorMessage.
	]
	
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:15:08'!
test08CanPauseVideoAndPlayItLater
	| video |

	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	video play.
	self assert: video isReproducing.
	video pause.
	self assert: video isPaused.
	
	
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:58:51'!
test09PlayPlaylistFailsIfTheresNotMultimediaToPlay
	| playlist |
	playlist := Playlist named: 'Relax' with: {}.
	
	self should: [playlist play.] raise:  Error - MessageNotUnderstood withMessageText: Playlist cannotPlayIfPlaylistIsEmptyErrorMessage.
	
	
	
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:15:02'!
test10PlayingPlaylistStartReproducingFirstElementOfThePlaylist
	| playlist video song |
	
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	
	playlist := Playlist named: 'Relax' with: {video. song}.
	playlist play.
	self assert: (playlist nowPlaying: video).
	
	
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:14:55'!
test11PlaylistSizeIsTheAmountOfTheElementsThatContains
	| playlist video song |
	
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	
	playlist := Playlist named: 'Relax' with: {video. song}.

	self assert: (playlist duration) equals: 3813 * second.
	
! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:14:09'!
test12PlaylistDurationIsTheDurationOfAllEachMultimediaElementsThatContains
	| song |
	
	song := Song 
		named: 'Oops, I did it again'
		duration: 213 * second
		artist: 'Britney Spears'.

	self assert: (song remainingTime: 213 * second).

	song play.                
	song goInTime: 10 * second.  

	self assert: (song remainingTime: 203 * second).
	song stop.
	self assert: (song remainingTime: 213 * second).
! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 15:02:55'!
test13CanAddMultimediaElementsToAPlaylistAfterCreated
	| playlist video song |
	
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	
	playlist := Playlist named: 'Relax' with: {video}.
	
	playlist add: song.

	self assert: (playlist includes: song)
! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:18:15'!
test14MultimediaElementRemainingTimeIsEqualsToDurationIfNotPlayedYet
	| playlist video song |
	
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	
	self assert: (song remainingTime: 213 * second).
	
	
	! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:18:20'!
test15MultimediaElementDecreasesRemainingTimeWhilePlaying
	| song |
	
	song := Song 
		named: 'Oops, I did it again'
		duration: 213 * second
		artist: 'Britney Spears'.

	self assert: (song remainingTime: 213 * second).

	song play.                
	song goInTime: 10 * second.  

	self assert: (song remainingTime: 203 * second).
! !

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:18:22'!
test16MultimediaElementRemainingTimeIsBackToMultimediaElementDurationIfHasBeenStopped
	| song |
	
	song := Song 
		named: 'Oops, I did it again'
		duration: 213 * second
		artist: 'Britney Spears'.

	self assert: (song remainingTime: 213 * second).

	song play.                
	song goInTime: 10 * second.  

	self assert: (song remainingTime: 203 * second).
	song stop.
	self assert: (song remainingTime: 213 * second).
! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 61 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 25 17 56 64 57 53 56 61 63 53 55 53 56 63 17 123 118 116 112 111 120 17 123 118 116 112 111 120 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 55 57 65 56 61 53 57 62 61 63 55 58 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 56 62 60 59 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 58 58 65 57 62 53 57 55 64 63 62 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 60 60 59 59 17 52 52 52 52 52 52 52 52 52 52 17 17))!