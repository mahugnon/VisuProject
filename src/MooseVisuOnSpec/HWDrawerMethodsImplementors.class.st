"
I am in charge of drawing a selector implemetors
"
Class {
	#name : #HWDrawerMethodsImplementors,
	#superclass : #HWRoassalDrawer,
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #drawing }
HWDrawerMethodsImplementors >> drawOnRoassalView: aView [
	| shape |
	shape := RTBox new
		size: 50;
		color: Color gray trans.
	elements := shape elementsOn: self selected senders.
	aView addAll: elements.
	elements @ RTPopup.
	RTFlowLayout on: elements.
	
]
