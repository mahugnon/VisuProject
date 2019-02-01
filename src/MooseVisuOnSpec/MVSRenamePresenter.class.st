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

{ #category : #specs }
MVSRenamePresenter class >> defaultSpec [
	^ SpecColumnLayout composed
		add: #textField height: self toolbarHeight;
		add: #buttonOK height:30;
		yourself 
]

{ #category : #specs }
MVSRenamePresenter class >> runMe [
<script>
self new openWithSpec 
]

{ #category : #accessing }
MVSRenamePresenter >> buttonOK [
	^ buttonOK
]

{ #category : #api }
MVSRenamePresenter >> extent [
	^ 300 @ 250
]

{ #category : #initialization }
MVSRenamePresenter >> initializeWidgets [
	textField := self newTextInput .
	buttonOK :=self newButton label: 'Ok'.
	self focusOrder
	add: textField ;
	add:buttonOK .
]

{ #category : #accessing }
MVSRenamePresenter >> textField [
	^ textField
]

{ #category : #api }
MVSRenamePresenter >> title [ 
^'Rename'
]
