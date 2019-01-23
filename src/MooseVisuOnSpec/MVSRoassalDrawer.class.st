"
Responsible for drawing a Roassal view in the HWMainPresenter

It knows the list of elements that the HWMainPresenter is showing, and the element in this list that is selected.
It is responsible to show this element in some way
"
Class {
	#name : #MVSRoassalDrawer,
	#superclass : #RoassalModel,
	#instVars : [
		'elements',
		'selected',
		'name'
	],
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #drawing }
MVSRoassalDrawer >> drawOnRoassalView: aView [
	self subclassResponsibility
]

{ #category : #accessing }
MVSRoassalDrawer >> elements [
	^ elements
]

{ #category : #accessing }
MVSRoassalDrawer >> elements: anObject [
	elements := anObject
]

{ #category : #api }
MVSRoassalDrawer >> extent [
	^ 800 @ 800
]

{ #category : #initialize }
MVSRoassalDrawer >> initialize [ 
super initialize .
self script: [ :view :canvas | self drawOnRoassalView: view ]

]

{ #category : #accessing }
MVSRoassalDrawer >> selected [
	^ selected
]

{ #category : #accessing }
MVSRoassalDrawer >> selected: anObject [
	selected := anObject
]

{ #category : #api }
MVSRoassalDrawer >> title [
	^ self className,' with ', selected asString 
]
