"
testing query stuff
"
Class {
	#name : #QueryManager,
	#superclass : #ComposablePresenter,
	#instVars : [
		'model',
		'filtre',
		'textField',
		'list'
	],
	#category : #QueryManager
}

{ #category : #specs }
QueryManager class >> defaultSpec [
	^ SpecRowLayout composed
		add: #textField;
		add:#list;
		yourself
]

{ #category : #specs }
QueryManager class >> runMe [ 
<script>
QueryManager new openWithSpec 
]

{ #category : #accessing }
QueryManager >> filtre [
	^ filtre
]

{ #category : #accessing }
QueryManager >> filtre: anObject [
	filtre := anObject
]

{ #category : #initialization }
QueryManager >> initializeWidgets [
	filtre := FilterManager new.
	textField := self newTextInput.
	list := self newList.
	textField
		autoAccept: true;
		beForCode;
	
		bindKeyCombination: 13
			toAction: [ self loadMSE.
			self list items: (self filtre executeQueryWith: textField text on: model allModelClasses) ].
	self focusOrder add: textField
]

{ #category : #accessing }
QueryManager >> list [
	^ list
]

{ #category : #utilities }
QueryManager >> loadMSE [
	self model: MSELoader new loadMSE.

]

{ #category : #accessing }
QueryManager >> model [
	^ model
]

{ #category : #accessing }
QueryManager >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
QueryManager >> performFilter [

	
	
]

{ #category : #accessing }
QueryManager >> textField [
	^ textField
]
