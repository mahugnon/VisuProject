"
I'm responsable of loading mse files
"
Class {
	#name : #MSELoader,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #utilities }
MSELoader class >> loadFileWithExtesion:anExtension [
^UIManager default
		chooseExistingFileReference: 'Import model from MSE file'
		extensions: anExtension 
		path: ''
		preview: ''.
]

{ #category : #utilities }
MSELoader class >> loadMSE [
	| fileRef |
	fileRef := self loadFileWithExtesion:#('mse').
	fileRef isNotNil
		ifFalse: [ ^ self ].
	MooseModel new
		installWithCache: true;
		importFromMSEStream: fileRef asFileReference readStream.
	^ MooseModel root allModels
]

{ #category : #'as yet unclassified' }
MSELoader >> loadFileWithExtesion:anExtension [
^UIManager default
		chooseExistingFileReference: 'Import model from MSE file'
		extensions: anExtension 
		path: ''
		preview: ''.
]
