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
	#name : #HWMainPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'listView',
		'diagram',
		'menu',
		'queryWidget',
		'drawerOptions',
		'history',
		'labelNumberListElt',
		'windowOptionCheckBox',
		'typeOfIteractionCheckBox'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #specs }
HWMainPresenter class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :r | r add: #menu ] height: self toolbarHeight;
		newRow:
			[ :r | 
			r
				newColumn: [ :c | c add: #listView ] left: 0 right: 0.7;
				newColumn: [ :c | 
					c
						add: #queryWidget origin: 0 @ 0 corner: 1 @ 0.09;
						add: #diagram ]
					right: 0 ] yourself
]

{ #category : #specs }
HWMainPresenter class >> drawSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :tcol | 
			tcol
				newRow: [ :trow | 
					trow
						newColumn: [ :left | 
							left
								add: #menu height: self toolbarHeight;
								add: #labelNumberListElt height: 30;
								newRow: [ :r | r add: #windowOptionCheckBox;
									add:#typeOfIteractionCheckBox  ] height: 30;
								add: #listView ]
						width: 400.
					trow
						newColumn: [ :right | 
							right
								add: #queryWidget height: self toolbarHeight;
								add: #diagram ] ] ];
		yourself
]

{ #category : #example }
HWMainPresenter class >> runMeWithClass [
	<script>
	| col |
	col := OrderedCollection new.
	col add: #put.
	col
		add: IceTipMergePatchMorph;
		add: OrderedCollection.
	(self
		withDrawer: HWDrawerSubclassesWithForceLayout
		elements: MooseModel root) openWithSpec
]

{ #category : #example }
HWMainPresenter class >> runMeWithSelectors [
	<script>
	(HWMainPresenter withDrawer: HWDrawerMethodsImplementors elements: Object allSelectors)
		openWithSpec
]

{ #category : #'instance creation' }
HWMainPresenter class >> withDrawer: aDrawerClass elements: aCollection [
	^ self basicNew
		initialize;
		initListViewItems: aCollection;
		yourself
]

{ #category : #initialization }
HWMainPresenter >> CreateWindowOptionCheckBox [
	windowOptionCheckBox := self newCheckBox.
	windowOptionCheckBox label: 'Result open in window';
	help:'If checked the result is displayed in an extenal window'
]

{ #category : #actions }
HWMainPresenter >> actionButtonOkClick [
	| elt drawer |
	drawer := self currentConfig selectedDrawer.
	elt := listView selectedItem.
	drawer isNotNil
		ifFalse: [ ^ self ].
	self drawerOptions window close.
	drawer selected: elt.
	self needRebuild: false.
	self drawOnViewWith: drawer.
	self buildWithSpecLayout: self class drawSpec.
	self listView setSelectedItem: elt.
	
]

{ #category : #initialization }
HWMainPresenter >> createQueryWidget [
	queryWidget := self instantiate: QueryWidget.
	
]

{ #category : #initialization }
HWMainPresenter >> createTypeOfIteractionCheckBox [
	typeOfIteractionCheckBox := self newCheckBox.
	typeOfIteractionCheckBox enabled: false.
	typeOfIteractionCheckBox
		label: 'Continious interaction';
		help: 'If checked the window is duplicated'
]

{ #category : #accessing }
HWMainPresenter >> currentConfig [
	^ self drawerOptions config
]

{ #category : #initialization }
HWMainPresenter >> defaultView [
	| cm |
	cm := self newLabel.
	cm label: 'Right click on an element from the list and choose visualization please.';
	emphasis: #bold.
	^ cm
]

{ #category : #accessing }
HWMainPresenter >> diagram [
	^ diagram
]

{ #category : #accessing }
HWMainPresenter >> diagram: anObject [
	diagram := anObject
]

{ #category : #actions }
HWMainPresenter >> disableTypeOfIteractionCheckBox [
	typeOfIteractionCheckBox enabled: false
]

{ #category : #actions }
HWMainPresenter >> drawOnViewWith: aDrawerInstance [
	diagram := self instantiate: RoassalModel.
	diagram
		script: [ :view :canvas | 
			aDrawerInstance drawOnRoassalView: view.
			 ]
]

{ #category : #accessing }
HWMainPresenter >> drawerOptions [
	^ drawerOptions
]

{ #category : #accessing }
HWMainPresenter >> drawerOptions: anObject [
	drawerOptions := anObject
]

{ #category : #actions }
HWMainPresenter >> enableTypeOfIteractionCheckBox [
	typeOfIteractionCheckBox enabled: true
]

{ #category : #actions }
HWMainPresenter >> executeTextQueryOnCR [
	self queryWidget textField
		autoAccept: true;
		beForCode;
		ghostText: 'Write an each query please';
		bindKeyCombination: 13
			toAction: [ self updateListViewItems: (queryWidget performFilterOn: listView listItems ) ]
]

{ #category : #api }
HWMainPresenter >> extent [
	^ 800 @ 650
]

{ #category : #accessing }
HWMainPresenter >> history [
	^ history
]

{ #category : #initialization }
HWMainPresenter >> initHistory:aCollection [
history := History create: aCollection .
]

{ #category : #initialization }
HWMainPresenter >> initListViewItems: aCollection [
	listView
		items: aCollection;
		displayBlock: [ :item | item displayString ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a asString < b asString ].
	self initHistory: aCollection.
	self updateNumberOfModelElt
]

{ #category : #initialization }
HWMainPresenter >> initializePresenter [
	self drawerOptions buttonOk action: [ self actionButtonOkClick ].
	self itemSelectedEventOn: listView.
	self executeTextQueryOnCR.
	self windowOptionCheckBoxChangeColor
]

{ #category : #initialization }
HWMainPresenter >> initializeWidgets [
	listView := self instantiate: FastTablePresenter.
	drawerOptions := DrawerOptions new.
	self createQueryWidget.
	self CreateWindowOptionCheckBox.
	self createTypeOfIteractionCheckBox.
	menu := self menuBarFor: self.
	labelNumberListElt := self newLabel.
	self initListViewItems: #().
	diagram := self defaultView.
	self focusOrder
		add: menu;
		add: windowOptionCheckBox;
		add: listView;
		add: diagram
]

{ #category : #testing }
HWMainPresenter >> isContiniousInteraction [
	^ typeOfIteractionCheckBox  state
]

{ #category : #testing }
HWMainPresenter >> isNewWindow [
^windowOptionCheckBox state
]

{ #category : #initialization }
HWMainPresenter >> itemSelectedEventOn: aListView [
	^ aListView
		whenSelectedItemChanged: [ :item | 
			item notNil
				ifTrue: [ item contextMenuWith: self isNewWindow On: self ] ]
]

{ #category : #accessing }
HWMainPresenter >> labelNumberListElt [
	^ labelNumberListElt
]

{ #category : #accessing }
HWMainPresenter >> listView [
	^ listView
]

{ #category : #'model - updating' }
HWMainPresenter >> listViewMenu: aBlock [
	^ self listView menu: aBlock 
]

{ #category : #actions }
HWMainPresenter >> loadImportedModel [
	
	self initListViewItems: MSELoader loadMSE
]

{ #category : #accessing }
HWMainPresenter >> menu [
	^ menu
]

{ #category : #accessing }
HWMainPresenter >> menu: anObject [
	menu := anObject
]

{ #category : #initialization }
HWMainPresenter >> menuBarFor: aPresenter [
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
HWMainPresenter >> next [
	history hasNext 
		ifFalse: [ ^ self ].
	listView items: self history next.
	self updateNumberOfModelElt

	"
self history hasFuture ifFalse: [^ self].
self history next.
self eltList: self history currentList
"
]

{ #category : #actions }
HWMainPresenter >> openResultInNewWindow [
	| myList |

	self isContiniousInteraction
		ifTrue: [ myList := self class withDrawer: nil elements: listView listItems ]
		ifFalse: [ myList := self newList.
			myList items: listView listItems ].
	^ myList openWithSpec
]

{ #category : #navigation }
HWMainPresenter >> prev [
	history hasPast
		ifFalse: [ ^ self ].
	self listView items: history previous.
	self updateNumberOfModelElt
]

{ #category : #accessing }
HWMainPresenter >> queryWidget [
	^ queryWidget
]

{ #category : #accessing }
HWMainPresenter >> selected [
	^ listView selectedItem
]

{ #category : #api }
HWMainPresenter >> title [ 
^'Visualization'.
]

{ #category : #accessing }
HWMainPresenter >> typeOfIteractionCheckBox [
^typeOfIteractionCheckBox
]

{ #category : #'model - updating' }
HWMainPresenter >> updateListViewItems: aCollection [
	listView items: aCollection.
	history addToPast: aCollection.
	self updateNumberOfModelElt
]

{ #category : #'model - updating' }
HWMainPresenter >> updateNumberOfModelElt [
	labelNumberListElt
		label: 'Number of items ' , ' :  ' , listView listItems size asString;
		emphasis: #bold
]

{ #category : #actions }
HWMainPresenter >> updatePastWith:item [
	history addToPast: item
]

{ #category : #actions }
HWMainPresenter >> visualizeOptionsOn: item [
	self drawerOptions
		initConfigWith: item;
		initDrawerList.
	self drawerOptions typeLabel label: item printString.
	self drawerOptions openWithSpec.
	self drawerOptions window modalRelativeTo: World
]

{ #category : #accessing }
HWMainPresenter >> windowOptionCheckBox [
^windowOptionCheckBox
]

{ #category : #actions }
HWMainPresenter >> windowOptionCheckBoxChangeColor [
	windowOptionCheckBox
		whenActivatedDo: [ windowOptionCheckBox color: Color green.
			self enableTypeOfIteractionCheckBox  ].
	windowOptionCheckBox
		whenDeactivatedDo: [ windowOptionCheckBox color: Color veryVeryLightGray.
			self disableTypeOfIteractionCheckBox  ]
]
