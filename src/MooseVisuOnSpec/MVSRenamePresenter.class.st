"
I allow one to rename 
"
Class {
	#name : #MVSRenamePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'textField',
		'buttonOK'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #initialization }
MVSRenamePresenter >> initializeWidgets [
	textField := self newTextInput .
	buttonOK :=self newButton label: 'Ok'.
	self focusOrder
	add: textField ;
	add:buttonOK .
]
