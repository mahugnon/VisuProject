"
I hold the history of the model during user interaction.
- When asked I can give the pass state and the next state 
"
Class {
	#name : #MVSHistory,
	#superclass : #Object,
	#instVars : [
		'past',
		'future'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #'initailize-release' }
MVSHistory class >> create [
	^ self new
]

{ #category : #adding }
MVSHistory >> addToFuture:anObject [
future push:anObject.
]

{ #category : #adding }
MVSHistory >> addToPast:anObject [
past push: anObject .
]

{ #category : #accessing }
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

{ #category : #accessing }
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
