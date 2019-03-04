Class {
	#name : #MVSContext,
	#superclass : #Object,
	#instVars : [
		'listeners'
	],
	#category : #'MooseVisuOnSpec-Context'
}

{ #category : #adding }
MVSContext >> addListener: aListener [
	listeners add: aListener
]

{ #category : #initialization }
MVSContext >> initialize [
super initialize.
listeners := OrderedCollection new.

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
