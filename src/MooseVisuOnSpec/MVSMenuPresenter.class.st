Class {
	#name : #MVSMenuPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'menu',
		'mvsHistory'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSMenuPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #menu;
		yourself
]

{ #category : #specs }
MVSMenuPresenter class >> runMe [ 
<script>
self new openWithSpec 
]

{ #category : #'model - updating' }
MVSMenuPresenter >> enableNavigationButtonAt: anIndex withValue: aBoolean [
	"If the widget does not exist, we will modify the spec objects"

	| navigationMenuGroup buttonMorph |
	navigationMenuGroup := menu menuGroups second.
	buttonMorph := navigationMenuGroup menuItems at: anIndex.
	buttonMorph enabled: aBoolean.
	self widget
		ifNotNil: [ | dockingBarMorph |
			dockingBarMorph := self widget widget submorphs first .
			((dockingBarMorph submorphs last: 2) at: anIndex) enabled: aBoolean ]
]

{ #category : #'model - updating' }
MVSMenuPresenter >> enableNextButton: aBoolean [
	self enableNavigationButtonAt: 2 withValue: aBoolean
]

{ #category : #'model - updating' }
MVSMenuPresenter >> enablePreviousButton: aBoolean [
	self enableNavigationButtonAt: 1 withValue: aBoolean
]

{ #category : #initialization }
MVSMenuPresenter >> initialize [
	super initialize.
	mvsHistory := MVSHistory new
]

{ #category : #initialization }
MVSMenuPresenter >> initializeWidgets [
	menu := self menuBarFor: self.
	
]

{ #category : #accessing }
MVSMenuPresenter >> menu [
	^ menu
]

{ #category : #initialization }
MVSMenuPresenter >> menuBarFor: aPresenter [
	| aMenu |
	aMenu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import model from MSE file';
						icon: MooseIcons mooseImportMse;
						action: [ context importMSE ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import Smalltalk';
						icon: MooseIcons mooseImportSmalltalk;
						action: [ context importSt ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Previous';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ self prev ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Next';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ self next ] ] ].
	aMenu applyTo: aPresenter.
	^ aMenu
]

{ #category : #accessing }
MVSMenuPresenter >> mvsHistory [
	^ mvsHistory
]

{ #category : #'model - updating' }
MVSMenuPresenter >> navigationMenuGroup [
	"Ugly method, but there is no easy way to access a menu group"

	"menu menuGroups second => Does not work because the spec menu object cannot interact with the real menu, to for example, disable it"

	"To be able to update the menu dynamically we have to get the morphs.
	This is bad code, please do not replicate"

	| dockingBarMorph |
	"If the widget does not exist, we will modify the spec objects"
	self widget
		ifNil: [ | navigationMenuGroup |
			navigationMenuGroup := menu menuGroups second.
			^ {navigationMenuGroup menuItems first.
			navigationMenuGroup menuItems second} ].
	dockingBarMorph := self widget widget submorphs first submorphs first
		submorphs first findA: ToolDockingBarMorph.
	^ dockingBarMorph submorphs last: 2
]

{ #category : #accessing }
MVSMenuPresenter >> next [
	mvsHistory hasNext
		ifFalse: [ ^ self ].
	mvsHistory updatePast.
	context mooseModel:  mvsHistory  next


	"
self history hasFuture ifFalse: [^ self].
self history next.
self eltList: self history currentList
"
]

{ #category : #'model - updating' }
MVSMenuPresenter >> nextButton [
	^ self navigationMenuGroup second
]

{ #category : #navigation }
MVSMenuPresenter >> prev [
	mvsHistory hasPast
		ifFalse: [ ^ self ].
	mvsHistory updateFuture  .
	context mooseModel: mvsHistory previous
]

{ #category : #'model - updating' }
MVSMenuPresenter >> previousButton [
	^ self navigationMenuGroup first
]

{ #category : #initialization }
MVSMenuPresenter >> subscribeToContext: aContext [
	aContext addListener: self.
	context := aContext.
	mvsHistory subscribeToContext: context
]

{ #category : #'model updates' }
MVSMenuPresenter >> update [ 
self updateNavigationButtons
]

{ #category : #'model - updating' }
MVSMenuPresenter >> updateNavigationButtons [
	self enableNextButton: mvsHistory  hasNext.
	self enablePreviousButton: mvsHistory  hasPast
]
