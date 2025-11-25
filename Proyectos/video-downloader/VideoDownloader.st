!classDefinition: #FileProvidersTest category: #VideoDownloader!
TestCase subclass: #FileProvidersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProvidersTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:48:45'!
test001UserCanDownloadFileDirectlyFromFileProviderA
	|fileProviderA aStream expectedResponse |
	fileProviderA := FileProviderA new.
	aStream := WriteStream with: {}.
	expectedResponse := #('fileDownloaded').
	fileProviderA fetch: 'file.txt' into: aStream.
	
	self assert: aStream contents equals: expectedResponse.
	
	! !

!FileProvidersTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:37:05'!
test002UserCanDownloadFileDirectlyFromFileProviderB
	|fileProviderB aStream expectedResponse |
	fileProviderB := FileProviderB new.
	aStream := WriteStream with: {}.
	expectedResponse := #('fileDownloaded').
	aStream := fileProviderB fetch: 'file.txt'.
	
	self assert: aStream contents equals: expectedResponse.
	
	! !

!FileProvidersTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:49:09'!
test003UserCanDownloadFileDirectlyUsingAdapterToProviderAAndB
	|adapterFileProviderA adapterFileProviderB aStream aStream2 expectedResponse |
	adapterFileProviderA := FileProviderAAdapter adapting: FileProviderA new.
	adapterFileProviderB := FileProviderBAdapter adapting: FileProviderB new.
	aStream := WriteStream with: {}.
	expectedResponse := #('fileDownloaded').
	aStream := adapterFileProviderA download: 'file.txt'.
	aStream2 := adapterFileProviderB download: 'file.txt'.
	
	
	self assert: aStream contents equals: expectedResponse.
	self assert: aStream2 contents equals: expectedResponse.
	! !


!classDefinition: #FileServiceDownloaderTest category: #VideoDownloader!
TestCase subclass: #FileServiceDownloaderTest
	instanceVariableNames: 'downloaders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileServiceDownloaderTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 15:15:24'!
test001UserCanDownloadFileSuccessfully
	|fileServiceDownloader streamResponse expectedResponse |
	expectedResponse := #('fileDownloaded').
	fileServiceDownloader := FileServiceDownloader new.
	streamResponse := fileServiceDownloader download: 'file.txt'.
	
	self assert: (streamResponse contents) equals: expectedResponse! !


!classDefinition: #VideoDownloaderTest category: #VideoDownloader!
TestCase subclass: #VideoDownloaderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!VideoDownloaderTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 15:08:28'!
test001VideoProxyDownloaderDownloadsFileAtFirstTime
	|videoDownloaderFile adapterFileProviderA aStream expectedResponse |
	expectedResponse := #('fileDownloaded').
	
	adapterFileProviderA := FileProviderAAdapter adapting: FileProviderA new.
	videoDownloaderFile := VideoDownloader for: adapterFileProviderA.
	
	aStream := videoDownloaderFile download: 'file.txt'.
	
	self assert: aStream contents equals: #('fileDownloaded').! !

!VideoDownloaderTest methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 15:08:28'!
test002VideoProxyDownloaderCachesFileAfterDownloadingForFirstTime
	|videoDownloaderFile adapterFileProviderA aStream expectedResponse |
	expectedResponse := #('fileDownloaded').
	
	adapterFileProviderA := FileProviderAAdapter adapting: FileProviderA new.
	videoDownloaderFile := VideoDownloader for: adapterFileProviderA.
	
	self deny: (videoDownloaderFile isCached: 'file.txt').
	aStream := videoDownloaderFile download: 'file.txt'.
	
	self assert: aStream contents equals: #('fileDownloaded').
	self assert: (videoDownloaderFile isCached: 'file.txt').
	
! !


!classDefinition: #FileProvider category: #VideoDownloader!
Object subclass: #FileProvider
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProvider methodsFor: 'actions' stamp: 'tomihq 11/25/2025 14:46:21'!
download: aFileName
	^self subclassResponsibility ! !


!FileProvider methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 14:47:14'!
initializeFor: aFileProvider
	adaptee := aFileProvider.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FileProvider class' category: #VideoDownloader!
FileProvider class
	instanceVariableNames: ''!

!FileProvider class methodsFor: 'instance creation' stamp: 'tomihq 11/25/2025 14:47:27'!
adapting: aFileProvider
	^self new initializeFor: aFileProvider.! !


!classDefinition: #FileProviderAAdapter category: #VideoDownloader!
FileProvider subclass: #FileProviderAAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProviderAAdapter methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:50:18'!
download: aFileName
	|aStream|
	aStream := WriteStream on: {}.
	adaptee fetch: 'aFileName' into: aStream.
	 ^aStream
	! !


!classDefinition: #FileProviderBAdapter category: #VideoDownloader!
FileProvider subclass: #FileProviderBAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProviderBAdapter methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:48:34'!
download: aFileName
	^adaptee fetch: aFileName
! !


!classDefinition: #FileProviderA category: #VideoDownloader!
Object subclass: #FileProviderA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProviderA methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:45:47'!
fetch: aFileName into: anStream
	anStream nextPut: 'fileDownloaded'.! !


!classDefinition: #FileProviderB category: #VideoDownloader!
Object subclass: #FileProviderB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileProviderB methodsFor: 'as yet unclassified' stamp: 'tomihq 11/25/2025 14:39:06'!
fetch: aFileName
	^WriteStream with: {'fileDownloaded'}! !


!classDefinition: #FileServiceDownloader category: #VideoDownloader!
Object subclass: #FileServiceDownloader
	instanceVariableNames: 'downloaders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!FileServiceDownloader methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 15:14:59'!
initialize
    downloaders := OrderedCollection new.

    downloaders add: (VideoDownloader for: (FileProviderAAdapter adapting: FileProviderA new)).
    downloaders add: (VideoDownloader for: (FileProviderBAdapter adapting: FileProviderB new)).
! !


!FileServiceDownloader methodsFor: 'actions' stamp: 'tomihq 11/25/2025 15:14:09'!
download: fileName
    | downloader |
    downloader := downloaders first.  
    ^ downloader download: fileName
! !


!classDefinition: #VideoDownloader category: #VideoDownloader!
Object subclass: #VideoDownloader
	instanceVariableNames: 'fileProvider downloads'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VideoDownloader'!

!VideoDownloader methodsFor: 'testing' stamp: 'tomihq 11/25/2025 15:06:12'!
cachedFile: aFileName
	^downloads at: aFileName value.! !

!VideoDownloader methodsFor: 'testing' stamp: 'tomihq 11/25/2025 15:02:36'!
isCached: aFileName
	^downloads includesKey: aFileName.! !


!VideoDownloader methodsFor: 'initializations' stamp: 'tomihq 11/25/2025 15:00:48'!
initializeFor: aFileProvider
	fileProvider := aFileProvider.
	downloads := Dictionary new.! !


!VideoDownloader methodsFor: 'actions' stamp: 'tomihq 11/25/2025 15:07:02'!
download: aFileName
	| aStream |
	self retrieveFileFromCache: aFileName.
	aStream := fileProvider download: aFileName.
	self saveCacheFor: aFileName with: aStream.
	^aStream.
	
	! !

!VideoDownloader methodsFor: 'actions' stamp: 'tomihq 11/25/2025 15:07:13'!
retrieveFileFromCache: aFileName
	^(self isCached: aFileName) ifTrue: [self cachedFile: aFileName].! !

!VideoDownloader methodsFor: 'actions' stamp: 'tomihq 11/25/2025 15:00:36'!
saveCacheFor: aFileName with: aStream
	downloads at: aFileName ifAbsent: [downloads at: aFileName put: aStream.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VideoDownloader class' category: #VideoDownloader!
VideoDownloader class
	instanceVariableNames: ''!

!VideoDownloader class methodsFor: 'instance creation' stamp: 'tomihq 11/25/2025 14:54:46'!
for: aFileProvider
	^self new initializeFor: aFileProvider.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 74 124 112 122 108 122 54 74 124 112 122 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 61 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 25 17 56 64 57 53 56 61 63 53 55 53 56 63 17 123 118 116 112 111 120 17 123 118 116 112 111 120 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 55 57 65 56 61 53 57 62 61 63 55 58 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 56 62 60 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 57 59 65 58 61 53 60 63 56 62 60 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 202 168 106 123 112 106 104 122 54 87 118 121 123 109 118 115 112 118 54 87 118 121 123 109 118 115 112 118 57 53 122 123 17 58 59 63 59 63 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 58 58 65 57 62 53 57 55 64 63 62 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 60 60 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 60 65 60 58 65 55 59 53 57 55 62 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 61 58 60 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 57 62 65 57 61 53 57 57 58 56 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 62 57 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 59 91 56 61 65 58 60 65 59 58 53 59 60 62 55 63 59 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 56 62 58 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 55 56 65 59 57 65 55 58 53 58 56 64 62 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 116 124 115 123 112 116 108 107 112 104 52 122 128 122 123 108 116 54 84 124 115 123 112 116 108 107 112 104 90 128 122 123 108 116 53 122 123 17 57 60 55 55 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 57 60 91 56 60 65 57 57 65 56 64 53 63 55 55 60 57 64 52 55 58 65 55 55 17 54 111 118 116 108 54 123 118 116 112 111 120 54 76 122 106 121 112 123 118 121 112 118 54 92 73 72 54 80 90 94 54 112 117 110 52 122 118 109 123 126 104 121 108 54 87 121 118 128 108 106 123 118 122 54 125 112 107 108 118 52 107 118 126 117 115 118 104 107 108 121 54 93 112 107 108 118 75 118 126 117 115 118 104 107 108 121 53 122 123 17 63 59 64 57 17 52 52 52 52 52 52 52 52 52 52 17 17))!