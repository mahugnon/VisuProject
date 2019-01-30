"
I'm responsable of loading mse files
"
Class {
	#name : #MSELoader,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #utilities }
MSELoader class >> loadMSE [
	| fileRef mooseModel |
	fileRef := UIManager default
		chooseExistingFileReference: 'Import model from MSE file'
		extensions: #('mse')
		path: ''
		preview: ''.
	fileRef isNotNil
		ifFalse: [ ^ self ].
	mooseModel := MooseModel new
		installWithCache: true;
		importFromMSEStream: fileRef asFileReference readStream.
	^ mooseModel cacheMooseGroups entityCache
]
