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
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #specs }
QueryWidget class >> defaultSpec [
	^ SpecRowLayout composed
		add: #label origin: 0 @ 0 corner: 0.1 @ 0.1;
		add: #textField origin: 0.1 @ 1 corner: 1 @ 0.07;
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
	label label: 'Query :';
	emphasis: #bold
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

{ #category : #'api actions' }
QueryWidget >> performFilterOn: aCollection [
	^ (self filtre executeQueryWith: textField text on: aCollection )
]

{ #category : #accessing }
QueryWidget >> textField [
	^ textField
]
