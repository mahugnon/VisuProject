"
testing query stuff
"
Class {
	#name : #QueryWidget,
	#superclass : #ComposablePresenter,
	#instVars : [
		'modelHolder',
		'filtre',
		'textField',
		'label'
	],
	#category : #QueryManager
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
	modelHolder := ModelHolder new.
	
	self focusOrder add: textField
]

{ #category : #accessing }
QueryWidget >> label [
	^ label
]

{ #category : #utilities }
QueryWidget >> loadMSE [
	self modelHolder model push: MSELoader new loadMSE.
	self modelHolder current push: self modelHolder model top
]

{ #category : #accessing }
QueryWidget >> modelHolder [
	^ modelHolder 
]

{ #category : #accessing }
QueryWidget >> modelHolder: anObject [
	modelHolder  := anObject
]

{ #category : #'as yet unclassified' }
QueryWidget >> performFilter [
	^ self
		filtre
		executeQueryWith:
			textField
				text
		on:
			modelHolder
				current top
]

{ #category : #accessing }
QueryWidget >> textField [
	^ textField
]
