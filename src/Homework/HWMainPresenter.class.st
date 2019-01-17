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
		'eltsWidget',
		'diagram',
		'menu',
		'queryWidget',
		'drawerOptions'
	],
	#category : #'Homework-version1'
}

{ #category : #specs }
HWMainPresenter class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :r | r add: #menu ] height: self toolbarHeight;
		newRow:
			[ :r | 
			r
				newColumn: [ :c | c add: #eltsWidget ] left: 0 right: 0.7;
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
								add: #eltsWidget left: 0 right: 0.6 ]
						width: 400.
					trow
						newColumn: [ :right | 
							right
								add: #queryWidget origin: 0 @ 0 corner: 1 @ 0.09;
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
	(self withDrawer: HWDrawerSubclassesWithForceLayout elements: MooseModel root allModels) openWithSpec
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
		eltList: aCollection;
		yourself
]

{ #category : #actions }
HWMainPresenter >> actionButtonOkClick [
	| elt drawer |
	drawer := self currentConfig selectedDrawer.
	elt := self eltsWidget eltList selectedItem.
	drawer isNotNil
		ifFalse: [ ^ self ].
	drawer selected: elt.
	self needRebuild: false.
	self drawOnViewWith: drawer.
	self buildWithSpecLayout: self class drawSpec.
	self eltsWidget eltList setSelectedItem: elt.
	self drawerOptions window close
]

{ #category : #initialization }
HWMainPresenter >> contextMenu [
	self flag: 'TODO: should depend on the item selected => double-dispatch somewhere'.
	^ self eltList
		menu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | group addMenuItem: self visualizationMenuItem ];
				addGroup: [ :group | group addMenuItem: self openMenuItem ];
				buildWithSpecAsPopup ]
]

{ #category : #initialization }
HWMainPresenter >> createQueryWidget [
	queryWidget := self instantiate: QueryWidget.
	queryWidget textField disable
]

{ #category : #accessing }
HWMainPresenter >> currentConfig [
	^ self drawerOptions config
]

{ #category : #initialization }
HWMainPresenter >> defaultView [
	| cm |
	cm := self newLabel.
	cm label: 'Right click on an element from the list and choose visualization please.'.
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

{ #category : #api }
HWMainPresenter >> eltList [
	^self eltsWidget eltList
]

{ #category : #api }
HWMainPresenter >> eltList: aCollection [
	
	self eltsWidget eltList: aCollection
]

{ #category : #accessing }
HWMainPresenter >> eltsWidget [
	^ eltsWidget
]

{ #category : #actions }
HWMainPresenter >> executeTextQueryOnCR [
	self queryWidget textField
		autoAccept: true;
		beForCode;
		ghostText: 'Write an each query please';
		bindKeyCombination: 13 toAction: [self eltList:  self queryWidget performFilter ]
]

{ #category : #api }
HWMainPresenter >> extent [
	^ 800 @ 650
]

{ #category : #initialization }
HWMainPresenter >> initializePresenter [
	self drawerOptions buttonOk action: [ self actionButtonOkClick ].
	self executeTextQueryOnCR
]

{ #category : #initialization }
HWMainPresenter >> initializeWidgets [
	eltsWidget := self instantiate: ListWidget.
	drawerOptions := DrawerOptions new.
	self contextMenu.
	self createQueryWidget.
	menu := self menuBarFor: self.
	self eltList: #().
	diagram := self defaultView.
	self focusOrder
		add: menu;
		add: eltsWidget;
		add: diagram
]

{ #category : #actions }
HWMainPresenter >> loadImportedModel [
	self queryWidget loadMSE.
	self eltList: self updateListViewListWithCurrent .
	self eltsWidget model: self updateListViewListWithCurrent.
	self queryWidget textField enable
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
						name: 'File';
						icon: (self iconNamed: #openIcon) ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Open file';
						icon: (self iconNamed: #openIcon);
						action: [ self loadImportedModel ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save File';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self inform: 'Save File' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Print file';
						icon: (self iconNamed: #smallPrintIcon);
						action: [ self inform: 'Print file' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Undo';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ self prev ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Redo';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ self next ] ] ].
				
	
	aMenu applyTo: aPresenter.
	^ aMenu
]

{ #category : #navigation }
HWMainPresenter >> next [
	self queryWidget modelHolder model size = 1
		ifTrue: [ ^ self ].
	self queryWidget modelHolder current push: self queryWidget modelHolder model top.
	self queryWidget modelHolder model pop.
	self eltList: self updateListViewListWithModel.
	
"
self history hasFuture ifFalse: [^ self].
self history next.
self eltList: self history currentList
"
]

{ #category : #actions }
HWMainPresenter >> openMenuItem [
	"Serve to refactor adding an item to my context menu. Goal: avoid having brain method. Thus I reduce the LOC of initializeWidgets  "

	^ MenuItemPresenter new
		name: 'Open';
		action: [ self queryWidget modelHolder current
				push: self eltsWidget eltList selectedItem.
			self eltsWidget eltList: self updateListViewListWithCurrent ];
		yourself
]

{ #category : #navigation }
HWMainPresenter >> prev [
	self queryWidget modelHolder current size = 1
		ifTrue:  [ ^ self ].
	self queryWidget modelHolder model push: self queryWidget modelHolder current top.
	self queryWidget modelHolder current pop.
	self eltList: self updateListViewListWithCurrent
]

{ #category : #accessing }
HWMainPresenter >> queryWidget [
	^ queryWidget
]

{ #category : #api }
HWMainPresenter >> title [ 
^'Visualization'.
]

{ #category : #utilities }
HWMainPresenter >> updateListViewListWithCurrent [
	^ self queryWidget modelHolder current top
]

{ #category : #utilities }
HWMainPresenter >> updateListViewListWithModel [
	^ self queryWidget modelHolder model top
]

{ #category : #initialization }
HWMainPresenter >> visualizationMenuItem [
	"Serve to refactor adding an item to my context menu. Goal: avoid having brain method. Thus I reduce the LOC of initializeWidgets  "

	^ MenuItemPresenter new
		name: 'Visualize';
		action: [ 
			self visualizeOptionsOn: (self eltsWidget eltList  selectedItem)];
		yourself
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

{ #category : #initialization }
HWMainPresenter >> withDrawer: aDrawerClass [
	^self basicNew
		withDrawer: aDrawerClass new;
		initialize ;
		yourself
]

{ #category : #initialization }
HWMainPresenter >> withDrawer: aDrawerClass elements: aCollection [
	^ self basicNew
		initialize;
		eltList: aCollection;
		yourself
]
