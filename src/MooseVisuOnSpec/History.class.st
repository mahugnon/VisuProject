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
History class >> create: aCollection [
	|history|
	history:= self
		new.
		^history initializeHistory: aCollection;
		yourself
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
	^ future size>1
]

{ #category : #'action - testing' }
History >> hasPast [
^past size>1 
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
	
	self addToPast: future top.
	future pop.
	^ future top
]

{ #category : #accessing }
History >> past [
	^ past
]

{ #category : #accessing }
History >> previous [
	
	future push: past top.
	past pop.
	^ past top
]
