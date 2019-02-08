"
I test the main presenter functionalities
"
Class {
	#name : #MVSTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCurrent'
	],
	#category : #MooseVisuOnSpecTests
}

{ #category : #'testing-utilities' }
MVSTest >> createTestingMSE [
	| model importer packages |
	model := MooseModel new.
	importer := MoosePharoImporterTask new model: model.
	importer factory: SmalltalkCompatibilityMetamodelFactory.
	importer
		importingContext:
			(MooseImportingContext new
				mergeClassAndMetaclass;
				importClass;
				importPackage;
				importInheritance;
				yourself).
	packages := self mooseVisuProjectPackages.
	packages do: [ :each | importer addFromPackageNamed: each name ].
	importer run.
	 model name: 'MooseVisuProjectModel'.
		^model
]

{ #category : #'testing-utilities' }
MVSTest >> mooseVisuProjectPackages [
	^ RPackage organizer packages select: [ :each | each name matchesRegex: 'MooseVisu.*' ]
]

{ #category : #'testing-utilities' }
MVSTest >> setUp [
	super setUp.
	rootCurrent := MooseModel root.
	MooseModel resetRoot.
	MooseModel root add: self createTestingMSE.
]

{ #category : #'testing-utilities' }
MVSTest >> tearDown [
	super tearDown.
	MooseModel resetRoot.
	MooseModel root addAll: rootCurrent.
	MVSMainPresenter closeOfSelfWindowOpen 
]

{ #category : #testing }
MVSTest >> testFilter [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := (MooseModel root at: 1) allModelClasses.
	self
		assert:
			(filterManager executeQueryWith: 'each hierarchyNestingLevel=2' on: testModel) size
		equals: 6
]

{ #category : #testing }
MVSTest >> testInitNavigation [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false.
]

{ #category : #testing }
MVSTest >> testMainPresenterListViewChangeWhenDoubleClick [
	| presenter list |
	presenter := MVSMainPresenter new.
	presenter listView items: MooseModel root.
	list := presenter listView listItems.
	presenter listView setSelectedItem: (MooseModel root at: 1).
	presenter simulateDoubleClick .
	self assert: list ~= presenter listView listItems
]

{ #category : #tests }
MVSTest >> testMainPresenterListViewIsEmptyWhenNoModel [
|mainPresenter|
mainPresenter :=MVSMainPresenter new.
self assert: mainPresenter listView listItems equals: #()
]

{ #category : #testing }
MVSTest >> testNavigationWhenFutureIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	presenter prev.
	presenter next.
	self assert: presenter history hasNext equals: false.
	self assert: presenter history past top equals: #(0 1 2 3 4) sorted.
	self assert: presenter listView listItems equals: #(0 8 7) sorted
]

{ #category : #testing }
MVSTest >> testNavigationWhenListViewItemsNotUpdatedAnPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter prev.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false
]

{ #category : #testing }
MVSTest >> testNavigationWhenPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	presenter prev.
	self assert: presenter history hasPast equals: false.
	self assert: presenter history future top equals: #(0 8 7) sorted.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4) sorted
]

{ #category : #testing }
MVSTest >> testNextNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasNext  equals: false
]

{ #category : #tests }
MVSTest >> testOpenInNewWindowWhenOptionIsChecked [
	| presenter numberOfOpenMainPresenterWindow|
	presenter := MVSMainPresenter new.
	presenter openResultNewWindowCheckBox state: true.
	presenter listView items: MooseModel root.
	presenter listView setSelectedItem: (MooseModel root at: 1).
	numberOfOpenMainPresenterWindow := MVSMainPresenter countNumberOfSelfWindowOpen .
	presenter simulateDoubleClick.
	self assert: (numberOfOpenMainPresenterWindow <MVSMainPresenter countNumberOfSelfWindowOpen )
	
]

{ #category : #testing }
MVSTest >> testPastNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasPast equals: true.
]

{ #category : #testing }
MVSTest >> testSecondSolution [

'ChrysalConfigurationForXXTest >> setUp [
	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / ''toto.mse'')
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsOfTotoMse ]
	
'
]

{ #category : #tests }
MVSTest >> testUpdateListView [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter updateListViewItems: #(1 2 3).
	self assert: mainPresenter listView listItems equals: #(1 2 3)
]

{ #category : #tests }
MVSTest >> testWhenUpdateMainPresenterListViewWithEmptyIsEmpty [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter updateListViewItems: #().
	self assert: mainPresenter listView listItems equals: #()
]
