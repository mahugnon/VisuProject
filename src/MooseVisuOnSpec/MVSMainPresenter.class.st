"
REsponsible for opening a window with a list of elements on the left and a Roassal diagram on the right.
Selecting an elements in the list on the left will trigger a refresh of the roassal view on the right

[[[
			(HWMainPresenter withDrawer: HWDrawerSubclassesWithForceLayout) openWithSpec 
]]]

I'm able to performe choice making depending on what is selected.
Exemple:
-runMe
- Select item and right click
	.if entity is a method the only methods visualisation are enabled.
"
Class {
	#name : #MVSMainPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listView',
		'menu',
		'queryWidget',
		'drawerOptions',
		'history',
		'labelNumberListElt',
		'openResultNewWindowCheckBox',
		'newSelf'
	],
	#category : #'MooseVisuOnSpec-core'
}

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
								add: #labelNumberListElt height: 30;
								add: #queryWidget height: self toolbarHeight;
								add: #openResultNewWindowCheckBox height: 30;
								add: #listView ] ] ];
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
	(self
		withDrawer: MVSDrawerSubclassesWithForceLayout
		elements: MooseModel root) openWithSpec
]

{ #category : #example }
MVSMainPresenter class >> runMeWithSelectors [
	<script>
	(MVSMainPresenter withDrawer: MVSDrawerMethodsImplementors elements: Object allSelectors)
		openWithSpec
]

{ #category : #'instance creation' }
MVSMainPresenter class >> withDrawer: aDrawerClass elements: aCollection [
	^ self basicNew
		initialize;
		initListViewItems: aCollection;
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
	tempPresenter listView
		menu: [ :aMenu | 
			MenuPresenter new
				addGroup:
						[ :group | menuItemPresenters do: [ :each | group addMenuItem: each ] ];
				buildWithSpecAsPopup ].
	^ tempPresenter
]

{ #category : #initialization }
MVSMainPresenter >> createHistory [
	history := MVSHistory create
]

{ #category : #initialization }
MVSMainPresenter >> createOpenResultNewWindowCheckBox [
	openResultNewWindowCheckBox := self newCheckBox
	label: 'Open result in new window'
	
]

{ #category : #initialization }
MVSMainPresenter >> createQueryWidget [
	queryWidget := self instantiate: MVSQueryWidget.
	
]

{ #category : #accessing }
MVSMainPresenter >> currentConfig [
	^ self drawerOptions config
]

{ #category : #accessing }
MVSMainPresenter >> drawerOptions [
	^ drawerOptions
]

{ #category : #accessing }
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

{ #category : #actions }
MVSMainPresenter >> executeTextQueryOnCR [
	self queryWidget textField
		autoAccept: true;
		beForCode;
		ghostText: 'Write an each query please';
		bindKeyCombination: 13
			toAction: [ self updateListViewItems: (queryWidget performFilterOn: listView listItems ) ]
]

{ #category : #api }
MVSMainPresenter >> extent [
	^ 800 @ 650
]

{ #category : #accessing }
MVSMainPresenter >> history [
	^ history
]

{ #category : #initialization }
MVSMainPresenter >> initHistory: aCollection [
	history := MVSHistory create
]

{ #category : #initialization }
MVSMainPresenter >> initListViewItems: aCollection [
	listView
		items: aCollection;
		displayBlock: [ :item | 
			item asString
				copyReplaceAll: 'famixt' with: 'famix' ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a asString < b asString ].
	self createHistory.
	self updateNumberOfModelElt
]

{ #category : #initialization }
MVSMainPresenter >> initializePresenter [
	self itemSelectedEventOn: listView.
	self executeTextQueryOnCR.
	self openResultNewWindowCheckBoxEvent.
]

{ #category : #initialization }
MVSMainPresenter >> initializeWidgets [
	listView := self instantiate: FastTablePresenter.
	drawerOptions := MVSDrawerOptions new.
	self createQueryWidget.
	self createOpenResultNewWindowCheckBox.
	menu := self menuBarFor: self.
	labelNumberListElt := self newLabel.
	self initListViewItems: #().
	self focusOrder
		add: menu;
		add: listView
]

{ #category : #testing }
MVSMainPresenter >> isOpenResultNewWindow [
^openResultNewWindowCheckBox state
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
						contextMenuOn: self ] ]
]

{ #category : #accessing }
MVSMainPresenter >> labelNumberListElt [
	^ labelNumberListElt
]

{ #category : #accessing }
MVSMainPresenter >> listView [
	^ listView
]

{ #category : #'model - updating' }
MVSMainPresenter >> listViewMenu: aBlock [
	^ self listView menu: aBlock 
]

{ #category : #actions }
MVSMainPresenter >> loadImportedModel [
	
	self initListViewItems: MSELoader loadMSE
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
						action: [ self loadImportedModel ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import Smalltalk';
						icon: MooseIcons mooseImportSmalltalk;
						action: [ self inform: 'Import Smalltalk' ] ] ];
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

{ #category : #navigation }
MVSMainPresenter >> next [
	history hasNext
		ifFalse: [ ^ self ].
	self updatePastWith:  listView listItems.
	listView items: self history next.
	self updateNumberOfModelElt

	"
self history hasFuture ifFalse: [^ self].
self history next.
self eltList: self history currentList
"
]

{ #category : #actions }
MVSMainPresenter >> openResultInNewWindow: aCollection [
	newSelf initListViewItems: aCollection .

	newSelf 	openWithSpec.
	
]

{ #category : #accessing }
MVSMainPresenter >> openResultNewWindowCheckBox [
^openResultNewWindowCheckBox
]

{ #category : #actions }
MVSMainPresenter >> openResultNewWindowCheckBoxEvent [
 openResultNewWindowCheckBox activationAction:  [
	newSelf :=self class withDrawer:nil  elements:#()   ]
]

{ #category : #navigation }
MVSMainPresenter >> prev [
	history hasPast
		ifFalse: [ ^ self ].
	self updateFutureWith:  listView listItems.
	self listView items: history previous.
	self updateNumberOfModelElt
]

{ #category : #accessing }
MVSMainPresenter >> queryWidget [
	^ queryWidget
]

{ #category : #accessing }
MVSMainPresenter >> selected [
	^ listView selectedItem
]

{ #category : #api }
MVSMainPresenter >> title [ 
^'Visualization'.
]

{ #category : #actions }
MVSMainPresenter >> updateFutureWith: item [
	history addToFuture: item
]

{ #category : #'model - updating' }
MVSMainPresenter >> updateListViewItems: aCollection [
	
	history addToPast: listView listItems.
	listView items: aCollection.
	self updateNumberOfModelElt
]

{ #category : #'model - updating' }
MVSMainPresenter >> updateNumberOfModelElt [
	labelNumberListElt
		label: 'Number of items ' , ' :  ' , listView listItems size asString;
		emphasis: #bold
]

{ #category : #actions }
MVSMainPresenter >> updatePastWith:item [
	history addToPast: item
]
