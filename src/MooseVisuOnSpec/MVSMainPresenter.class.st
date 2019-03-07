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
		'history',
		'openResultNewWindowCheckBox',
		'errorReporter',
		'modelSizePresenter',
		'mvsQueryPresenter',
		'mvsMenuBar'
	],
	#category : #'MooseVisuOnSpec-Core'
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
								add: #mvsMenuBar height: self toolbarHeight;
								add: #modelSizePresenter height: 30;
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
		initContextWith: aCollection;
		yourself
]

{ #category : #initialization }
MVSMainPresenter >> createErrorReporter [
	errorReporter := self instantiate: MVSErrorReportPresenter.
	errorReporter subscribeTo: context.
	
]

{ #category : #initialization }
MVSMainPresenter >> createHistory [
	history := MVSHistory create
]

{ #category : #accessing }
MVSMainPresenter >> createModelSizePresenter [
	modelSizePresenter := MVSSizePresenter new.
	modelSizePresenter subscribeToContext: context
]

{ #category : #initialization }
MVSMainPresenter >> createMooseView [
	mooseView := self instantiate: MVSMooseViewPresenter.
	mooseView subscribeToContext: context
]

{ #category : #initialization }
MVSMainPresenter >> createMvsMenuBar [
	mvsMenuBar := self instantiate: MVSMenuPresenter.
	mvsMenuBar subscribeToContext: context.
	
]

{ #category : #initialization }
MVSMainPresenter >> createMvsQueryPresenter [
	mvsQueryPresenter  := self instantiate: MVSQueryWidgetPresenter.
	mvsQueryPresenter subscribeToContext: context .
	
]

{ #category : #initialization }
MVSMainPresenter >> createOpenResultNewWindowCheckBox [
	openResultNewWindowCheckBox := (self
		instantiate: MVSOpenInNewWindowOptionPresenter)
		label: 'Open result in new window'.
	openResultNewWindowCheckBox subscribeToContext: context
]

{ #category : #'model - updating' }
MVSMainPresenter >> enableNavigationButtonAt: anIndex withValue: aBoolean [

	"If the widget does not exist, we will modify the spec objects"
	| navigationMenuGroup buttonMorph |
	navigationMenuGroup := mvsMenuBar menuGroups second.
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

{ #category : #initialization }
MVSMainPresenter >> initContextWith: aCollection [
	
	context mooseModel: aCollection
]

{ #category : #initialization }
MVSMainPresenter >> initializePresenter [
	"self executeTextQueryOnCR."

	"self updateNavigationButtons"
	"	self openResultNewWindowCheckBoxEvent."
]

{ #category : #initialization }
MVSMainPresenter >> initializeWidgets [
	self subscribeToContext: MVSContext new.
	self createModelSizePresenter.
	self createHistory.
	self createMooseView.
	self createErrorReporter.
	self createMvsQueryPresenter.
	self createOpenResultNewWindowCheckBox.
	self createMvsMenuBar.
	self focusOrder
		add: mvsMenuBar;
		add: mooseView
]

{ #category : #accessing }
MVSMainPresenter >> modelSizePresenter [
	^ modelSizePresenter
]

{ #category : #accessing }
MVSMainPresenter >> mooseView [
	^ mooseView
]

{ #category : #accessing }
MVSMainPresenter >> mvsMenuBar [
	^ mvsMenuBar
]

{ #category : #accessing }
MVSMainPresenter >> openResultNewWindowCheckBox [
	^ openResultNewWindowCheckBox
]

{ #category : #actions }
MVSMainPresenter >> openResultNewWindowCheckBoxEvent [
	
]

{ #category : #navigation }
MVSMainPresenter >> prev [
	history hasPast
		ifFalse: [ ^ self ].
	self updateFutureWith: context mooseModel.
	context mooseModel: history previous
]

{ #category : #'menu-accessing' }
MVSMainPresenter >> previousButton [
	
	^ self navigationMenuGroup first
]

{ #category : #accessing }
MVSMainPresenter >> queryWidget [
	^ mvsQueryPresenter
]

{ #category : #simulating }
MVSMainPresenter >> simulateDoubleClick [
self mooseView doubleClick: self mooseView doubleClickAction
]

{ #category : #api }
MVSMainPresenter >> title [ 
^'Visualization'.
]
