"
testing query stuff
"
Class {
	#name : #MVSQueryWidget,
	#superclass : #ComposablePresenter,
	#instVars : [
		'filtre',
		'textField',
		'label'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #specs }
MVSQueryWidget class >> defaultSpec [
	^ SpecRowLayout composed
		add: #label origin: 0 @ 0 corner: 0.1 @ 0.1;
		add: #textField origin: 0.1 @ 1 corner: 1 @ 0.07;
		yourself
]

{ #category : #specs }
MVSQueryWidget class >> runMe [ 
<script>
MVSQueryWidget new openWithSpec 
]

{ #category : #initialization }
MVSQueryWidget >> createLabel [
	label := self newLabel.
	label label: 'Query :';
	emphasis: #bold
]

{ #category : #accessing }
MVSQueryWidget >> filtre [
	^ filtre
]

{ #category : #accessing }
MVSQueryWidget >> filtre: anObject [
	filtre := anObject
]

{ #category : #initialization }
MVSQueryWidget >> initializeWidgets [
	filtre := MVSFilterManager new.
	textField := self newTextInput.
	self createLabel.
	
	self focusOrder add: textField
]

{ #category : #accessing }
MVSQueryWidget >> label [
	^ label
]

{ #category : #'api actions' }
MVSQueryWidget >> performFilterOn: aCollection [
	^ (self filtre executeQueryWith: textField text on: aCollection )
]

{ #category : #accessing }
MVSQueryWidget >> textField [
	^ textField
]
