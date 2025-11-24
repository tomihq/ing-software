!classDefinition: #MultimediaElement category: #MultimediaSystem!
Object subclass: #MultimediaElement
	instanceVariableNames: 'name duration artist state remainingTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:46:47'!
pause
	state := #Paused.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:46:54'!
play
	state := #Playing.! !

!MultimediaElement methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:09:09'!
stop
	state !!= #Playing ifTrue: [^self error: self class notPlayingDescriptionErrorMessage ].
	state := #NotPlaying.
	remainingTime := duration.! !


!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:15:42'!
duration
	^duration.! !

!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 13:46:30'!
isPaused
	^state = #Paused.! !

!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 13:46:36'!
isReproducing
	^state = #Playing.! !

!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 13:46:40'!
isStopped
	^state = #NotPlaying! !

!MultimediaElement methodsFor: 'accessing' stamp: 'tomihq 11/24/2025 14:11:24'!
size
	^1.! !


!MultimediaElement methodsFor: 'testing' stamp: 'tomihq 11/24/2025 14:07:58'!
goInTime: aTimeToPass
	remainingTime := remainingTime - aTimeToPass.! !

!MultimediaElement methodsFor: 'testing' stamp: 'tomihq 11/24/2025 14:03:39'!
remainingTime: aTimeToCompare
	^remainingTime = aTimeToCompare.! !


!MultimediaElement methodsFor: 'initializations' stamp: 'tomihq 11/24/2025 14:04:09'!
initializeSongWith: aName duration: aDurationInSeconds artist: anArtist
	name := aName.
	duration := aDurationInSeconds.
	artist := anArtist.
	state := #NotPlaying.
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


!classDefinition: #Playlist category: #MultimediaSystem!
Object subclass: #Playlist
	instanceVariableNames: 'name elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultimediaSystem'!

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:20:52'!
add: aMultimediaElement
	elements add: aMultimediaElement.! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:13:39'!
duration
	^elements sum: [:element | element duration].! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:21:36'!
initializeWith: aName and: aListOfMultimediaElements
	name := aName.
	elements := aListOfMultimediaElements asOrderedCollection .! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:55:22'!
nowPlaying: aMultimediaElement
	^elements anySatisfy: [:multimediaElement | multimediaElement isReproducing].! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 13:59:43'!
play
	| multimedia |
	elements size = 0 ifTrue: [^self error: self class cannotPlayIfPlaylistIsEmptyErrorMessage ].
	multimedia := elements first.
	multimedia play.
	! !

!Playlist methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:11:16'!
size
	^elements sum: [:element | element size].! !

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

!SongTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/24/2025 14:19:11'!
test13CanAddMultimediaElementsToAPlaylistAfterCreated
	| playlist video song |
	
	song := Song named: 'Oops, I did it again' duration: 213 * second artist: 'Britney Spears'.
	video := Video named: '1 Hour - Serenity and Rain - Resident Evil 4' duration: 3600 * second artist: 'CAPCOM'.
	
	playlist := Playlist named: 'Relax' with: {video}.
	
	playlist add: song.

	self assert: (playlist contains: song)
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
