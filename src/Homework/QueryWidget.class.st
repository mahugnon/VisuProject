"
testing query stuff
"
Class {
	#name : #QueryWidget,
	#superclass : #ComposablePresenter,
	#instVars : [
		'filtre',
		'textField',
		'label'
	],
	#category : #'Homework-core'
}

{ #category : #specs }
QueryWidget class >> defaultSpec [
	^ SpecRowLayout composed
	
				add: #label origin: 0 @ 0 corner: 0.1 @ 0.1;
				add: #textField origin: 0.1 @ 0 corner: 1 @ 0.01 ;
		yourself
]

{ #category : #specs }
QueryWidget class >> runMe [ 
<script>
QueryWidget new openWithSpec 
]

{ #category : #initialization }
QueryWidget >> createLabel [
	label := self newLabel.
	label label: 'Query :'
]

{ #category : #accessing }
QueryWidget >> filtre [
	^ filtre
]

{ #category : #accessing }
QueryWidget >> filtre: anObject [
	filtre := anObject
]

{ #category : #initialization }
QueryWidget >> initializeWidgets [
	filtre := FilterManager new.
	textField := self newTextInput.
	self createLabel.
	
	self focusOrder add: textField
]

{ #category : #accessing }
QueryWidget >> label [
	^ label
]

{ #category : #'as yet unclassified' }
QueryWidget >> performFilterOn: aListView [
	^aListView items: (self filtre executeQueryWith: textField text on: aListView listItems )
]

{ #category : #accessing }
QueryWidget >> textField [
	^ textField
]
