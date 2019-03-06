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
		'config',
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
MVSDrawerOptionsPresenter class >> runMe [
<script>
MVSDrawerOptionsPresenter new openWithSpec 
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> buttonOk [
	^ buttonOk
]

{ #category : #api }
MVSDrawerOptionsPresenter >> drawerList [
	^ drawerList
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> drawerList: anObject [
	drawerList := anObject
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
	self drawerList
		items: self config getDrawers asOrderedCollection;
		whenSelectedItemChanged: [ :item | config selectedDrawer: item ]
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
			self config selectedDrawer
				new
				selected: config type;
				openWithSpec ]
]

{ #category : #initialization }
MVSDrawerOptionsPresenter >> initializeWidgets [
	self initConfig.
	self initDrawerList.
	self initTypeLabel.
	self initButtonOk.
	self focusOrder
		add: typeLabel;
		add: drawerList;
		add: buttonOk
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> selectedDrawer [
	^ selectedDrawer
]

{ #category : #api }
MVSDrawerOptionsPresenter >> title [ 
^'Drawing options'
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> typeLabel [
	^ typeLabel
]

{ #category : #accessing }
MVSDrawerOptionsPresenter >> typeLabel: anObject [
	typeLabel := anObject
]
