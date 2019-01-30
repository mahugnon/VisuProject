"
I am in charge of drawing a selector implemetors
"
Class {
	#name : #MVSDrawerMethodsImplementorsPresenter,
	#superclass : #MVSRoassalDrawerPresenter,
	#category : #'MooseVisuOnSpec-VisualPresenters'
}

{ #category : #drawing }
MVSDrawerMethodsImplementorsPresenter >> drawOnRoassalView: aView [
	| shape |
	shape := RTBox new
		size: 50;
		color: Color gray trans.
	elements := shape elementsOn: self selected senders.
	aView addAll: elements.
	elements @ RTPopup @ RTMVSElInteraction.
	RTFlowLayout on: elements
]
