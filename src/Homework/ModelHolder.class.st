Class {
	#name : #ModelHolder,
	#superclass : #Object,
	#instVars : [
		'model',
		'current'
	],
	#category : #'Homework-core'
}

{ #category : #accessing }
ModelHolder >> current [
	^ current
]

{ #category : #accessing }
ModelHolder >> current: anObject [
	current := anObject
]

{ #category : #initialization }
ModelHolder >> initialize [ 
current:=Stack new .
model:=Stack new.
]

{ #category : #accessing }
ModelHolder >> model [
	^ model
]

{ #category : #accessing }
ModelHolder >> model: anObject [
	model := anObject
]
