"
I hold the history of the model during user interaction.
- When asked I can give the pass state and the next state 
"
Class {
	#name : #MVSHistory,
	#superclass : #Object,
	#instVars : [
		'past',
		'future',
		'context'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #'initailize-release' }
MVSHistory class >> create [
	^ self new
]

{ #category : #accessing }
MVSHistory >> context [
	^ context
]

{ #category : #accessing }
MVSHistory >> context: aContext [
	context := aContext
]

{ #category : #acccessing }
MVSHistory >> future [
	^ future
]

{ #category : #'action - testing' }
MVSHistory >> hasNext [
	^ future isNotEmpty 
]

{ #category : #'action - testing' }
MVSHistory >> hasPast [
	^ past isNotEmpty 
]

{ #category : #initialization }
MVSHistory >> initialize [
	past := Stack new.
	future := Stack new
]

{ #category : #initialization }
MVSHistory >> initializeHistory: aCollection [
	past push: aCollection.
	future push: aCollection
]

{ #category : #accessing }
MVSHistory >> next [
	| next |
	next := future top.
	future pop.
	^ next
]

{ #category : #accesing }
MVSHistory >> past [
	^ past
]

{ #category : #accessing }
MVSHistory >> previous [
	| previous |
	previous := past top.
	
	past pop.
	^ previous
]

{ #category : #initialization }
MVSHistory >> subscribeToContext: aContext [
	context := aContext.
	aContext history: self
]

{ #category : #initialization }
MVSHistory >> unSubscribeToContext [
	context removeListener: self.
	context := nil
]

{ #category : #adding }
MVSHistory >> updateFuture [
	future push: context mooseModel
]

{ #category : #adding }
MVSHistory >> updatePast [
	past push: context mooseModel
]
