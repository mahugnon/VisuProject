"
My I store user config 
"
Class {
	#name : #MVSDrawConfig,
	#superclass : #Object,
	#instVars : [
		'type',
		'selectedDrawer',
		'applicableDrawers',
		'zoom',
		'center'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #accessing }
MVSDrawConfig >> applicableDrawers [
	^self
		getDrawers.
	
]

{ #category : #accessing }
MVSDrawConfig >> center [
	^ center
]

{ #category : #accessing }
MVSDrawConfig >> center: anObject [
	center := anObject
]

{ #category : #utilities }
MVSDrawConfig >> getDrawers [
	^MVSDrawerManager
		new
		drawersFor: type
]

{ #category : #accessing }
MVSDrawConfig >> selectedDrawer [
	^ selectedDrawer
]

{ #category : #accessing }
MVSDrawConfig >> selectedDrawer: anObject [
	selectedDrawer := anObject
]

{ #category : #accessing }
MVSDrawConfig >> type [
	^ type
]

{ #category : #accessing }
MVSDrawConfig >> type: anObject [
	type := anObject
]

{ #category : #accessing }
MVSDrawConfig >> zoom [
	^ zoom
]

{ #category : #accessing }
MVSDrawConfig >> zoom: anObject [
	zoom := anObject
]
