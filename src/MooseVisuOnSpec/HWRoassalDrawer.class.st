"
Responsible for drawing a Roassal view in the HWMainPresenter

It knows the list of elements that the HWMainPresenter is showing, and the element in this list that is selected.
It is responsible to show this element in some way
"
Class {
	#name : #HWRoassalDrawer,
	#superclass : #RoassalModel,
	#instVars : [
		'elements',
		'selected',
		'name'
	],
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #drawing }
HWRoassalDrawer >> drawOnRoassalView: aView [
	self subclassResponsibility
]

{ #category : #accessing }
HWRoassalDrawer >> elements [
	^ elements
]

{ #category : #accessing }
HWRoassalDrawer >> elements: anObject [
	elements := anObject
]

{ #category : #api }
HWRoassalDrawer >> extent [
	^ 800 @ 800
]

{ #category : #initialize }
HWRoassalDrawer >> initialize [ 
super initialize .
self script: [ :view :canvas | self drawOnRoassalView: view ]

]

{ #category : #accessing }
HWRoassalDrawer >> selected [
	^ selected
]

{ #category : #accessing }
HWRoassalDrawer >> selected: anObject [
	selected := anObject
]

{ #category : #api }
HWRoassalDrawer >> title [
	^ self className,' with ', selected asString 
]
