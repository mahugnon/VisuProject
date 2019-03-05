"
REsponsible for opening a window with a list of elements on the left and a Roassal diagram on the right.
Selecting an elements in the list on the left will trigger a refresh of the roassal view on the right

[[[
			(MVSMainPresenter withDrawer: HWDrawerSubclassesWithForceLayout) openWithSpec 
]]]

I'm able to performe choice making depending on what is selected.
Exemple:
-runMe
- Select item and right click
	.if entity is a method the only methods visualisation are enabled.
"
Class {
	#name : #MVSMainPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'mooseView',
		'menu',
		'queryWidget',
		'drawerOptions',
		'history',
		'labelNumberListElt',
		'openResultNewWindowCheckBox',
		'logHolder',
		'errorReporter'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSMainPresenter class >> closeOfSelfWindowOpen [
	^ self
		allInstancesDo: [ :each | 
			each window isNotNil
				ifTrue: [ each window close ] ]
]

{ #category : #specs }
MVSMainPresenter class >> countNumberOfSelfWindowOpen [
	^ (self allInstances select: [ :each | each window notNil ]) size
]

{ #category : #specs }
MVSMainPresenter class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :tcol | 
			tcol
				newRow: [ :trow | 
					trow
						newColumn: [ :left | 
							left
								add: #menu height: self toolbarHeight;
								add: #labelNumberListElement height: 30;
								add: #queryWidget height: self toolbarHeight;
								add: #openResultNewWindowCheckBox height: 30;
								add: #mooseView;
								add: #errorReporter height: 30 ] ] ];
		yourself
]

{ #category : #example }
MVSMainPresenter class >> runMeWithClass [
	<script>
	| col |
	col := OrderedCollection new.
	col add: #put.
	col
		add: IceTipMergePatchMorph;
		add: OrderedCollection.
	(self withElements: MooseModel root) openWithSpec
]

{ #category : #'instance creation' }
MVSMainPresenter class >> withElements: aCollection [
	^ self basicNew
		initialize;
		initMooseView: aCollection;
		yourself
]

{ #category : #'build items' }
MVSMainPresenter >> buildContextMenuWith: menuItemPresenters [
	| tempPresenter |
	menuItemPresenters isEmpty
		ifTrue: [ ^ self ].
	tempPresenter := self isOpenResultNewWindow
		ifTrue: [ newSelf ]
		ifFalse: [ self ].
	tempPresenter mooseView menu:
			[ MenuPresenter
				new addGroup: [ :group | 
					menuItemPresenters
						do: [ :each |  group addMenuItem: each ] ];
					buildWithSpecAsPopup ].
	^ tempPresenter
]

{ #category : #initialization }
MVSMainPresenter >> createErrorReporter [
	errorReporter := self instantiate: MVSErrorReportPresenter
]

{ #category : #initialization }
MVSMainPresenter >> createHistory [
	history := MVSHistory create
]

{ #category : #initialization }
MVSMainPresenter >> createMooseView [
	mooseView := self instantiate: MVSMooseViewPresenter.
	mooseView subscribeToContext: context
]

{ #category : #initialization }
MVSMainPresenter >> createOpenResultNewWindowCheckBox [
	openResultNewWindowCheckBox := (self instantiate: MVSOpenInNewWindowOptionPresenter )
		label: 'Open result in new window'
]

{ #category : #initialization }
MVSMainPresenter >> createQueryWidget [
	queryWidget := self instantiate: MVSQueryWidgetPresenter.
	
]

{ #category : #'accessing model' }
MVSMainPresenter >> currentConfig [
	^ self drawerOptions config
]

{ #category : #'accessing model' }
MVSMainPresenter >> drawerOptions [
	^ drawerOptions
]

{ #category : #'accessing model' }
MVSMainPresenter >> drawerOptions: anObject [
	drawerOptions := anObject
]

{ #category : #actions }
MVSMainPresenter >> drawerOptionsOn: item [
	self drawerOptions
		initConfigWith: item;
		initDrawerList.
	self drawerOptions typeLabel label: item printString.
	self drawerOptions openWithSpec.
	self drawerOptions window modalRelativeTo: World
]

{ #category : #'model - updating' }
MVSMainPresenter >> enableNavigationButtonAt: anIndex withValue: aBoolean [

	"If the widget does not exist, we will modify the spec objects"
	| navigationMenuGroup buttonMorph |
	navigationMenuGroup := menu menuGroups second.
	buttonMorph := navigationMenuGroup menuItems at: anIndex.
	buttonMorph enabled: aBoolean.

	self widget ifNotNil: [	| dockingBarMorph |
		dockingBarMorph := self widget widget submorphs first submorphs first submorphs first findA: ToolDockingBarMorph.
		((dockingBarMorph submorphs last: 2) at: anIndex) enabled: aBoolean ]
]

{ #category : #'model - updating' }
MVSMainPresenter >> enableNextButton: aBoolean [

	self enableNavigationButtonAt: 2 withValue: aBoolean
]

{ #category : #'model - updating' }
MVSMainPresenter >> enablePreviousButton: aBoolean [

	self enableNavigationButtonAt: 1 withValue: aBoolean
]

{ #category : #accessing }
MVSMainPresenter >> errorReporter [
	
	^ errorReporter
]

{ #category : #actions }
MVSMainPresenter >> executeTextQueryOnCR [
	self queryWidget whenFilterAccepted: [ self performQuery ]
]

{ #category : #api }
MVSMainPresenter >> extent [
	^ 800 @ 650
]

{ #category : #'accessing model' }
MVSMainPresenter >> history [
	^ history
]

{ #category : #actions }
MVSMainPresenter >> importSt [
	| root |
	MPImportSTCommand new execute.
	root := MooseModel root.
	^ (self class withElements: (root at: root size) mvsGroupEntitycache ) openWithSpec
]

{ #category : #initialization }
MVSMainPresenter >> initContext [
	self subscribeToContext: MVSContext new
]

{ #category : #initialization }
MVSMainPresenter >> initMooseView [
	"self createHistory.
	self updateNavigationButtons.
	self updateNumberOfModelElement"
]

{ #category : #initialization }
MVSMainPresenter >> initializePresenter [
	| listView |
	mooseView itemSelectedEvent.
	self executeTextQueryOnCR.
	"	self openResultNewWindowCheckBoxEvent."
	listView
		doubleClickAction: [ :item | listView selectedItem mvsDoubleClick: self ]
]

{ #category : #initialization }
MVSMainPresenter >> initializeWidgets [
	self initContext.
	self createMooseView.
	self createErrorReporter.
	drawerOptions := MVSDrawerOptionsPresenter new.
	self createQueryWidget.
	self createOpenResultNewWindowCheckBox.
	menu := self menuBarFor: self.
	labelNumberListElt := self newLabel.
	self initMooseView.
	self focusOrder
		add: menu;
		add: mooseView 
]

{ #category : #testing }
MVSMainPresenter >> isOpenResultNewWindow [
	^ openResultNewWindowCheckBox state
]

{ #category : #initialization }
MVSMainPresenter >> itemSelectedEventOn: aListView [
	^ aListView
		whenSelectedItemChanged:
			[ :item | 
			item
				notNil
				ifTrue:
					[ item
						mvscontextMenuOn: self ] ]
]

{ #category : #'writing - class' }
MVSMainPresenter >> itemSourceCode: anObject [
	MVSSourceTextPresenter  new
		sourceCode: anObject sourceText;
		openWithSpec
]

{ #category : #accessing }
MVSMainPresenter >> labelNumberListElement [
	^ labelNumberListElt
]

{ #category : #actions }
MVSMainPresenter >> loadImportedModel [
	MVSMSELoader importModel.
	self initMooseView: MooseModel root allModels
]

{ #category : #accessing }
MVSMainPresenter >> logHolder [
^logHolder
]

{ #category : #accessing }
MVSMainPresenter >> menu [
	^ menu
]

{ #category : #accessing }
MVSMainPresenter >> menu: anObject [
	menu := anObject
]

{ #category : #initialization }
MVSMainPresenter >> menuBarFor: aPresenter [
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
						action: [ self importSt ] ] ];
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
MVSMainPresenter >> mooseView [
	^ listView
]

{ #category : #'model - updating' }
MVSMainPresenter >> mooseViewMenu: aBlock [
	^ self mooseView menu: aBlock 
]

{ #category : #'menu-accessing' }
MVSMainPresenter >> navigationMenuGroup [
	
	"Ugly method, but there is no easy way to access a menu group"
	"menu menuGroups second => Does not work because the spec menu object cannot interact with the real menu, to for example, disable it"
	"To be able to update the menu dynamically we have to get the morphs.
	This is bad code, please do not replicate"
	| dockingBarMorph |
	
	"If the widget does not exist, we will modify the spec objects"
	self widget ifNil: [ | navigationMenuGroup |
		navigationMenuGroup := menu menuGroups second.
		^ { navigationMenuGroup menuItems first . navigationMenuGroup menuItems second }
		 ].
	
	dockingBarMorph := self widget widget submorphs first submorphs first submorphs first findA: ToolDockingBarMorph.
	^ dockingBarMorph submorphs last: 2
]

{ #category : #navigation }
MVSMainPresenter >> next [
	history hasNext
		ifFalse: [ ^ self ].
	self updatePastWith: listView listItems.
	listView items: self history next.
	self updateNavigationButtons.
	self updateNumberOfModelElement

	"
self history hasFuture ifFalse: [^ self].
self history next.
self eltList: self history currentList
"
]

{ #category : #'menu-accessing' }
MVSMainPresenter >> nextButton [
	^ self navigationMenuGroup second
]

{ #category : #actions }
MVSMainPresenter >> openResultInNewWindow: aCollection [
	newSelf initMooseView: aCollection.
	newSelf openWithSpec.
	
]

{ #category : #accessing }
MVSMainPresenter >> openResultNewWindowCheckBox [
	^ openResultNewWindowCheckBox
]

{ #category : #actions }
MVSMainPresenter >> openResultNewWindowCheckBoxEvent [
	
]

{ #category : #actions }
MVSMainPresenter >> performQuery [
	| newListItems |
	[ newListItems := queryWidget performFilterOn: listView listItems.
	self updateListViewItems: newListItems ]
		on: Exception
		do: [ :exception | errorReporter logError: exception ]
]

{ #category : #navigation }
MVSMainPresenter >> prev [
	history hasPast
		ifFalse: [ ^ self ].
	self updateFutureWith: listView listItems.
	self mooseView items: history previous.
	self updateNavigationButtons.
	self updateNumberOfModelElement
]

{ #category : #'menu-accessing' }
MVSMainPresenter >> previousButton [
	
	^ self navigationMenuGroup first
]

{ #category : #accessing }
MVSMainPresenter >> queryWidget [
	^ queryWidget
]

{ #category : #accessing }
MVSMainPresenter >> selected [
	^ listView selectedItem
]

{ #category : #simulating }
MVSMainPresenter >> simulateDoubleClick [
self mooseView doubleClick: self mooseView doubleClickAction
]

{ #category : #api }
MVSMainPresenter >> title [ 
^'Visualization'.
]

{ #category : #initialization }
MVSMainPresenter >> upadate [
	
]

{ #category : #actions }
MVSMainPresenter >> updateFutureWith: item [
	history addToFuture: item
]

{ #category : #'model - updating' }
MVSMainPresenter >> updateListViewItems: aCollection [
	history addToPast: listView listItems.
	listView items: aCollection.
	self updateNavigationButtons.
	self updateNumberOfModelElement
]

{ #category : #'model - updating' }
MVSMainPresenter >> updateNavigationButtons [
	self enableNextButton: history hasNext.
	self enablePreviousButton: history hasPast.
]

{ #category : #'model - updating' }
MVSMainPresenter >> updateNumberOfModelElement [
	labelNumberListElt
		label: 'Number of items ' , ' :  ' , listView listItems size asString;
		emphasis: #bold
]

{ #category : #actions }
MVSMainPresenter >> updatePastWith:item [
	history addToPast: item
]
