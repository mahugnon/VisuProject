"
testing query stuff
"
Class {
	#name : #MVSQueryWidgetPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'filtre',
		'textField',
		'label'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSQueryWidgetPresenter class >> defaultSpec [
	^ SpecRowLayout composed
		add: #label origin: 0 @ 0 corner: 0.1 @ 0.1;
		add: #textField origin: 0.1 @ 1 corner: 1 @ 0.07;
		yourself
]

{ #category : #specs }
MVSQueryWidgetPresenter class >> runMe [ 
<script>
MVSQueryWidgetPresenter new openWithSpec 
]

{ #category : #initialization }
MVSQueryWidgetPresenter >> createLabel [
	label := self newLabel.
	label label: 'Query :';
	emphasis: #bold
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> filter [
	^ filtre
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> filter: anObject [
	filtre := anObject
]

{ #category : #initialization }
MVSQueryWidgetPresenter >> initializeWidgets [
	filtre := MVSFilterManager new.
	textField := self newTextInput.
	self createLabel.
	
	self focusOrder add: textField
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> label [
	^ label
]

{ #category : #'api actions' }
MVSQueryWidgetPresenter >> performFilterOn: aCollection [
	^ (self filter executeQueryWith: textField text on: aCollection )
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> textField [
	^ textField
]
