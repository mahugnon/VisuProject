"
I am a Modal to allow user to select a draw beyond different options
"
Class {
	#name : #MVSDrawerOptions,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'typeLabel',
		'selectedDrawer',
		'drawerList',
		'config',
		'buttonOk'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #specs }
MVSDrawerOptions class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :r1 | r1 add: #typeLabel ] origin: 0 @ 0 corner: 1 @ 0.2;
		newRow: [ :r2 | r2 add: #drawerList ] origin: 0 @ 0.2 corner: 1 @ 0.4;
		add: #buttonOk height: 30;
		yourself
]

{ #category : #specs }
MVSDrawerOptions class >> runMe [
<script>
MVSDrawerOptions new openWithSpec 
]

{ #category : #accessing }
MVSDrawerOptions >> buttonOk [
	^ buttonOk
]

{ #category : #accessing }
MVSDrawerOptions >> config [
	^ config
]

{ #category : #accessing }
MVSDrawerOptions >> config: anObject [
	config := anObject
]

{ #category : #api }
MVSDrawerOptions >> drawerList [
	^ drawerList
]

{ #category : #accessing }
MVSDrawerOptions >> drawerList: anObject [
	drawerList := anObject
]

{ #category : #initialization }
MVSDrawerOptions >> initButtonOk [
	buttonOk := self newButton.
	buttonOk label: 'Draw'
]

{ #category : #initialization }
MVSDrawerOptions >> initConfig [
	config := self instantiateDrawConfig
]

{ #category : #initialization }
MVSDrawerOptions >> initConfigWith: aType [
	config := self instantiateDrawConfigWith: aType
]

{ #category : #initialization }
MVSDrawerOptions >> initDrawerList [
	drawerList := self newDropList.
	"Select a drawer for ' , config type printString."
	self drawerList
		items: self config getDrawers asOrderedCollection;
		whenSelectedItemChanged: [ :item | config selectedDrawer: item ]
]

{ #category : #initialization }
MVSDrawerOptions >> initTypeLabel [
	typeLabel := self newLabel.
	"typeLabel label: text"
]

{ #category : #initialization }
MVSDrawerOptions >> initializePresenter [
	buttonOk
		action: [ self window close.
			self config selectedDrawer
				new
				selected: config type;
				openWithSpec ]
]

{ #category : #initialization }
MVSDrawerOptions >> initializeWidgets [
	self initConfig.
	self initDrawerList.
	self initTypeLabel.
	self initButtonOk.
	self focusOrder
		add: typeLabel;
		add: drawerList;
		add: buttonOk
]

{ #category : #initialization }
MVSDrawerOptions >> instantiateDrawConfig [
	^ MVSDrawConfig new 
]

{ #category : #initialization }
MVSDrawerOptions >> instantiateDrawConfigWith: aType [
	^ MVSDrawConfig new type: aType
]

{ #category : #accessing }
MVSDrawerOptions >> selectedDrawer [
	^ selectedDrawer
]

{ #category : #api }
MVSDrawerOptions >> title [ 
^'Drawing options'
]

{ #category : #accessing }
MVSDrawerOptions >> typeLabel [
	^ typeLabel
]

{ #category : #accessing }
MVSDrawerOptions >> typeLabel: anObject [
	typeLabel := anObject
]
