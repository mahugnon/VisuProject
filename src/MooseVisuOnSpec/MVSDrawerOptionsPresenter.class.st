"
I am a Modal to allow user to select a draw beyond different options
"
Class {
	#name : #MVSDrawerOptionsPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'typeLabel',
		'selectedDrawer',
		'drawerList',
		'buttonOk'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSDrawerOptionsPresenter class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :r1 | r1 add: #typeLabel ] origin: 0 @ 0 corner: 1 @ 0.2;
		newRow: [ :r2 | r2 add: #drawerList ] origin: 0 @ 0.2 corner: 1 @ 0.4;
		add: #buttonOk height: 30;
		yourself
]

{ #category : #specs }
MVSDrawerOptionsPresenter class >> openInContext: aContext [
	| widget |
	widget := self new context: aContext.
	widget openWithSpec.
	widget window modalRelativeTo: World
]

{ #category : #specs }
MVSDrawerOptionsPresenter class >> runMe [
<example>
MVSDrawerOptionsPresenter new openWithSpec 
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> buttonOk [
	^ buttonOk
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> context: aContext [
	context := aContext.
	self drawerList items: context drawers
]

{ #category : #api }
MVSDrawerOptionsPresenter >> drawerList [
	^ drawerList
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initButtonOk [
	buttonOk := self newButton.
	buttonOk label: 'Draw'
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initDrawerList [
	drawerList := self newDropList.
	"Select a drawer for ' , config type printString."
	drawerList 
		whenSelectedItemChanged: [ :item | selectedDrawer := item ]
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initTypeLabel [
	typeLabel := self newLabel.
	"typeLabel label: text"
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initializePresenter [
	buttonOk
		action: [ self window close.
			selectedDrawer drawOn: context focus ]
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initializeWidgets [
	self initDrawerList.
	self initTypeLabel.
	self initButtonOk.
	self focusOrder
		add: typeLabel;
		add: drawerList;
		add: buttonOk
]

{ #category : #api }
MVSDrawerOptionsPresenter >> title [ 
^'Drawing options'
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> typeLabel [
	^ typeLabel
]
