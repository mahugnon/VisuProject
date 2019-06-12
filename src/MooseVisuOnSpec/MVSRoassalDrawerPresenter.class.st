"
Responsible for drawing a Roassal view in the HWMainPresenter

It knows the list of elements that the HWMainPresenter is showing, and the element in this list that is selected.
It is responsible to show this element in some way
"
Class {
	#name : #MVSRoassalDrawerPresenter,
	#superclass : #RoassalModel,
	#instVars : [
		'elements',
		'selected'
	],
	#category : #'MooseVisuOnSpec-VisualPresenters'
}

{ #category : #drawing }
MVSRoassalDrawerPresenter class >> drawOn: aModel [
	self new
		selected: aModel;
		openWithSpec
]

{ #category : #'drawing - helpers' }
MVSRoassalDrawerPresenter >> drawOnRoassalView: aView [
	self subclassResponsibility
]

{ #category : #accessing }
MVSRoassalDrawerPresenter >> elements [
	^ elements
]

{ #category : #accessing }
MVSRoassalDrawerPresenter >> elements: anObject [
	elements := anObject
]

{ #category : #api }
MVSRoassalDrawerPresenter >> extent [
	^ 800 @ 800
]

{ #category : #initialization }
MVSRoassalDrawerPresenter >> initialize [
	super initialize.
	self script: [ :view :canvas | self drawOnRoassalView: view ]
]

{ #category : #accessing }
MVSRoassalDrawerPresenter >> selected [
	^ selected
]

{ #category : #accessing }
MVSRoassalDrawerPresenter >> selected: anObject [
	selected := anObject
]

{ #category : #api }
MVSRoassalDrawerPresenter >> title [
	^ self className , ' with ' , selected asString
]
