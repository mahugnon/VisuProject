Class {
	#name : #MVSContext,
	#superclass : #Object,
	#instVars : [
		'listeners',
		'mooseModel',
		'focus',
		'isOpenResultNewWindow',
		'errorListener',
		'mvsError'
	],
	#category : #'MooseVisuOnSpec-Context'
}

{ #category : #adding }
MVSContext >> addListener: aListener [
	listeners add: aListener
]

{ #category : #'as yet unclassified' }
MVSContext >> errorListener [
	^ errorListener
]

{ #category : #'as yet unclassified' }
MVSContext >> errorListener: anObject [
	errorListener := anObject
]

{ #category : #accessing }
MVSContext >> focus [
	^ focus
]

{ #category : #accessing }
MVSContext >> focus: aModel [
	focus := aModel
]

{ #category : #'as yet unclassified' }
MVSContext >> focusName [
	^ focus className
]

{ #category : #'as yet unclassified' }
MVSContext >> focusSourceText [
	^ focus sourceText
]

{ #category : #'as yet unclassified' }
MVSContext >> importMSE [
	MVSMSELoader importModel.
	self mooseModel: MooseModel root allModels.
	
]

{ #category : #actions }
MVSContext >> importSt [
	MPImportSTCommand new execute.
	self mooseModel: MooseModel root allModels
]

{ #category : #initialization }
MVSContext >> initListeners [
	listeners := OrderedCollection new
]

{ #category : #initialization }
MVSContext >> initMooseModel [
	mooseModel := MooseModel root allModels
]

{ #category : #initialization }
MVSContext >> initialize [
	super initialize.
	self initListeners.
	self initMooseModel.
	isOpenResultNewWindow := false
]

{ #category : #accessing }
MVSContext >> isOpenResultNewWindow [
	^ isOpenResultNewWindow
]

{ #category : #accessing }
MVSContext >> isOpenResultNewWindow: aBoolean [
	isOpenResultNewWindow := aBoolean
]

{ #category : #accessing }
MVSContext >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MVSContext >> mooseModel: aMooseModel [
	mooseModel := aMooseModel.
	self notifyAll.
	
]

{ #category : #'as yet unclassified' }
MVSContext >> mooseModelSize [
	^ mooseModel size asString
]

{ #category : #accessing }
MVSContext >> mvsError [
	^ mvsError
]

{ #category : #'as yet unclassified' }
MVSContext >> mvsError: anObject [
	mvsError := anObject.
	self notifyError
]

{ #category : #'as yet unclassified' }
MVSContext >> notifyAll [
	listeners ifEmpty: [ ^ self ].
	^ listeners do: [ :listener | listener update ]
]

{ #category : #'as yet unclassified' }
MVSContext >> notifyError [
 errorListener update
]

{ #category : #adding }
MVSContext >> removeListener: aListener [
	listeners ifEmpty: [ ^ self ].
	(listeners includes: aListener)
		ifTrue: [ listeners remove: aListener ].
	^ listeners
]
