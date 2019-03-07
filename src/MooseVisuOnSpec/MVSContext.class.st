Class {
	#name : #MVSContext,
	#superclass : #Object,
	#instVars : [
		'listeners',
		'mooseModel',
		'focus',
		'isOpenResultNewWindow',
		'errorListener',
		'mvsError',
		'drawers',
		'history'
	],
	#category : #'MooseVisuOnSpec-Context'
}

{ #category : #adding }
MVSContext >> addListener: aListener [
	listeners add: aListener
]

{ #category : #accessing }
MVSContext >> drawers [
	^ drawers
]

{ #category : #accessing }
MVSContext >> drawers: aCollection [
	drawers := aCollection
]

{ #category : #accessing }
MVSContext >> errorListener [
	^ errorListener
]

{ #category : #accessing }
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

{ #category : #utilities }
MVSContext >> focusSourceText [
	^ focus sourceText
]

{ #category : #accessing }
MVSContext >> history [
	^ history
]

{ #category : #accessing }
MVSContext >> history: anObject [
	history := anObject
]

{ #category : #utilities }
MVSContext >> importMSE [
	MVSMSELoader importModel.
	self mooseModel: MooseModel root allModels.
	
]

{ #category : #utilities }
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

{ #category : #utilities }
MVSContext >> mooseModelSize [
	^ mooseModel size asString
]

{ #category : #accessing }
MVSContext >> mvsError [
	^ mvsError
]

{ #category : #'api-errors' }
MVSContext >> mvsError: anObject [
	mvsError := anObject.
	self notifyError
]

{ #category : #actions }
MVSContext >> notifyAll [
	listeners ifEmpty: [ ^ self ].
	^ listeners do: [ :listener | listener update ]
]

{ #category : #'api-errors' }
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

{ #category : #'api-events' }
MVSContext >> whenDrillDown: aModel [
	history updatePast.
	^ self mooseModel: aModel
]
