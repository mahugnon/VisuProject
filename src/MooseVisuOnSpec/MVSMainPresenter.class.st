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
		'openResultNewWindowCheckBox',
		'errorReporter',
		'modelSizePresenter',
		'mvsQueryPresenter',
		'mvsMenuBar'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #'testing-utilities' }
MVSMainPresenter class >> closeOpenWindow [
	^ self
		allInstancesDo: [ :each | 
			each window isNotNil
				ifTrue: [ each window close ] ]
]

{ #category : #'testing-utilities' }
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
								add: #mvsMenuBar height: self toolbarHeight;
								add: #modelSizePresenter height: 30;
								add: #mvsQueryPresenter height: self toolbarHeight;
								add: #openResultNewWindowCheckBox height: 30;
								add: #mooseView;
								add: #errorReporter height: 30 ] ] ];
		yourself
]

{ #category : #example }
MVSMainPresenter class >> runMeWithClass [
	<example>
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

{ #category : #accessing }
MVSMainPresenter >> errorReporter [
	^ errorReporter
]

{ #category : #api }
MVSMainPresenter >> extent [
	^ 800 @ 650
]

{ #category : #initialization }
MVSMainPresenter >> initContextWith: aCollection [
	
	context mooseModel: aCollection
]

{ #category : #initialization }
MVSMainPresenter >> initializeWidgets [
	self subscribeToContext: MVSContext new.
	self createModelSizePresenter.
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
MVSMainPresenter >> mvsQueryPresenter [
	^ mvsQueryPresenter
]

{ #category : #accessing }
MVSMainPresenter >> openResultNewWindowCheckBox [
	^ openResultNewWindowCheckBox
]

{ #category : #'as yet unclassified' }
MVSMainPresenter >> simulateDoubleClick [
	self mooseView mooseModels
		doubleClick: self mooseView mooseModels doubleClickAction
]

{ #category : #api }
MVSMainPresenter >> title [ 
^'Visualization'.
]
