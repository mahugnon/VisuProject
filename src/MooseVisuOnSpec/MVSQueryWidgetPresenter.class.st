"
testing query stuff
"
Class {
	#name : #MVSQueryWidgetPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'textField',
		'label',
		'model'
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

{ #category : #initialization }
MVSQueryWidgetPresenter >> createQueryTextField [
	textField := self newTextInput.
	textField
		autoAccept: true;
		beForCode;
		ghostText: 'Write an each query please';
		bindKeyCombination: Character cr
		toAction: [ "CR, the enter key"
		
			self performQuery ]
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> filter [
	^ model
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> filter: anObject [
	model := anObject
]

{ #category : #initialization }
MVSQueryWidgetPresenter >> initContext [
	model := MVSFilterManager new
]

{ #category : #initialization }
MVSQueryWidgetPresenter >> initializeWidgets [
	self initContext.
	self createQueryTextField.
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

{ #category : #actions }
MVSQueryWidgetPresenter >> performQuery [
	[ context mooseModel: (self performFilterOn: context mooseModel) ]
		on: Exception
		do: [ :exception | context mvsError: exception ]
]

{ #category : #accessing }
MVSQueryWidgetPresenter >> textField [
	^ textField
]

{ #category : #testing }
MVSQueryWidgetPresenter >> type: aCharacter [ 
	
	textField type: aCharacter
]

{ #category : #'api actions' }
MVSQueryWidgetPresenter >> whenFilterAccepted: aBlock [
	self textField bindKeyCombination: Character cr toAction: aBlock	"CR, the enter key"
]
