"
I hold the history of the model during user interaction.
- When asked I can give the pass state and the next state 
"
Class {
	#name : #History,
	#superclass : #Object,
	#instVars : [
		'past',
		'future'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #'as yet unclassified' }
History class >> create [
	^ self new
]

{ #category : #'as yet unclassified' }
History class >> create: aCollection [
	|history|
	history:= self
		new.
		^history initializeHistory: aCollection;
		yourself
]

{ #category : #adding }
History >> addToFuture:anObject [
future push:anObject.
]

{ #category : #adding }
History >> addToPast:anObject [
past push: anObject .
]

{ #category : #accessing }
History >> future [
	^ future
]

{ #category : #'action - testing' }
History >> hasNext [
	^ future isNotEmpty 
]

{ #category : #'action - testing' }
History >> hasPast [
	^ past isNotEmpty 
]

{ #category : #initialization }
History >> initialize [
	past := Stack new.
	future := Stack new
]

{ #category : #initialization }
History >> initializeHistory: aCollection [
	past push: aCollection.
	future push: aCollection
]

{ #category : #accessing }
History >> next [
	| next |
	next := future top.
	future pop.
	^ next
]

{ #category : #accessing }
History >> past [
	^ past
]

{ #category : #accessing }
History >> previous [
	| previous |
	previous := past top.
	
	past pop.
	^ previous
]
