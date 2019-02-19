"
I'm responsable of loading mse files
"
Class {
	#name : #MVSMSELoader,
	#superclass : #MVSAbstractModelImporter,
	#category : #MooseVisuOnSpecModelLoader
}

{ #category : #utilities }
MVSMSELoader class >> importModel [
	| fileRef |
	fileRef := self loadFileWithExtension:#('mse') andWindowTitle:'Import model from MSE file'.
	fileRef isNotNil
		ifFalse: [ ^ self ].
	MooseModel new
		installWithCache: true;
		importFromMSEStream: fileRef asFileReference readStream.
	
]
