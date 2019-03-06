Class {
	#name : #MVSContext,
	#superclass : #Object,
	#instVars : [
		'listeners',
		'mooseModel',
		'focus'
	],
	#category : #'MooseVisuOnSpec-Context'
}

{ #category : #adding }
MVSContext >> addListener: aListener [
	listeners add: aListener
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
MVSContext >> importMSE [
	MVSMSELoader importModel.
	mooseModel := MooseModel root allModels.
	self notifyAll
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
	self initMooseModel
]

{ #category : #accessing }
MVSContext >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MVSContext >> mooseModel: aMooseModel [
	mooseModel := aMooseModel.
	self notifyAll
]

{ #category : #'as yet unclassified' }
MVSContext >> notifyAll [
	listeners ifEmpty: [ ^ self ].
	^ listeners do: [ :listener | listener update ]
]

{ #category : #adding }
MVSContext >> removeListener: aListener [
	listeners ifEmpty: [ ^ self ].
	(listeners includes: aListener)
		ifTrue: [ listeners remove: aListener ].
	^ listeners
]
