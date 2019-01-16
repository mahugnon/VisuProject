Class {
	#name : #ModelHolder,
	#superclass : #Object,
	#instVars : [
		'model',
		'current'
	],
	#category : #'Homework-version2'
}

{ #category : #accessing }
ModelHolder >> current [
	^ current
]

{ #category : #accessing }
ModelHolder >> current: anObject [
	current := anObject
]

{ #category : #accessing }
ModelHolder >> model [
	^ model
]

{ #category : #accessing }
ModelHolder >> model: anObject [
	model := anObject
]
