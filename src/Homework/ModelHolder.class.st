Class {
	#name : #ModelHolder,
	#superclass : #Object,
	#instVars : [
		'model',
		'current'
	],
	#category : #'Homework-version2'
}

{ #category : #navigation }
ModelHolder >> allModelClasses [ 
^model allModelClasses 
]

{ #category : #navigation }
ModelHolder >> allNameSpaces [ 
^model allNameSpaces 
]

{ #category : #navigation }
ModelHolder >> allPackages [ 
^model allPackages 
]

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
