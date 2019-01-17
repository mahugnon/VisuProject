"
I'm responsable of loading mse files
"
Class {
	#name : #MSELoader,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Homework-core'
}

{ #category : #initialization }
MSELoader >> initialize [ 
super initialize .
model:=MooseModel new.
]

{ #category : #utilities }
MSELoader >> loadMSE [
	| fileRef mooseModel |
	fileRef := UIManager default
		chooseExistingFileReference: 'Import model from MSE file'
		extensions: #('mse')
		path: ''
		preview: ''.
	fileRef isNotNil
		ifFalse: [ ^ self ].
	mooseModel := MooseModel new
		importFromMSEStream: fileRef asFileReference readStream.
	^ mooseModel cacheMooseGroups entityCache
]

{ #category : #utilities }
MSELoader >> loadMSEIn:aPresenter [
	| fileRef |
	fileRef := UIManager default
		chooseExistingFileReference: 'Import model from MSE file'
		extensions: #('mse')
		path: ''
		preview: ''.
	fileRef isNotNil
		ifTrue: [ ^ MooseModel new importFromMSEStream: fileRef asFileReference readStream ]
]

{ #category : #accessing }
MSELoader >> model [
	^ model
]

{ #category : #accessing }
MSELoader >> model: anObject [
	model := anObject
]
