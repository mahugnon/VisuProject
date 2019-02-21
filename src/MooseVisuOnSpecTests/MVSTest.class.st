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

{ #category : #testing }
MVSTest >> correctQuery [
	^ 'each hierarchyNestingLevel=2'
]

{ #category : #testing }
MVSTest >> correctQueryWithFloat [
	^ 'each hierarchyNestingLevel=2.0'
]

{ #category : #'testing-utilities' }
MVSTest >> createTestingMSE [
	| model importer package |
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
	package := MCPackage named: 'TestMokePackage'.
	importer addFromPackageNamed: package name;
	 run.
	model name: 'TestMokePackage'.
	^ model
]

{ #category : #utilities }
MVSTest >> createTestingModel [
	| maClass |
	#('ModelClass1' 'ModelClass2' 'ModelClass3' 'ModelClass7' 'ModelClass4' 'ModelClass5' 'ModelClass6')
		do: [ :each | 
			Object
				subclass: each
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'TestMokePackage' ].
	maClass := Object
		subclass: 'MVSTestingClass'
		instanceVariableNames: 'inst1 inst2'
		classVariableNames: ''
		package: 'TestMokePackage'.
	(RBCreateAccessorsForVariableRefactoring
		variable: 'inst1'
		class: maClass
		classVariable: false) execute.
	(RBCreateAccessorsForVariableRefactoring
		variable: 'inst2'
		class: maClass
		classVariable: false) execute.
	maClass
		subclass: 'MVSSubTestingClass'
		instanceVariableNames: 'inst3 inst4'
		classVariableNames: ''
		package: 'TestMokePackage'
]

{ #category : #testing }
MVSTest >> modelForTest [
	^ (MooseModel root at: 1) allModelClasses
]

{ #category : #'testing-utilities' }
MVSTest >> mooseVisuProjectPackages [
	^ RPackage organizer packages select: [ :each | each name matchesRegex: 'MooseVisu.*' ]
]

{ #category : #'testing-utilities' }
MVSTest >> setUp [
	super setUp.
	self createTestingModel.
	rootCurrent := MooseModel root.
	MooseModel resetRoot.
	MooseModel root add: self createTestingMSE
]

{ #category : #'testing-utilities' }
MVSTest >> tearDown [
	super tearDown.
	MooseModel resetRoot.
	MooseModel root addAll: rootCurrent.
	MVSMainPresenter closeOfSelfWindowOpen.
	(MCPackage named: 'TestMokePackage') unload. 
]

{ #category : #testing }
MVSTest >> testAddingElementsToHistoryEnablesPreviousButton [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).

	self assert: presenter previousButton enabled
]

{ #category : #'testing-drilling' }
MVSTest >> testDrillInMooseModelDoesNotShowClickedModelInList [
	| presenter list selectedItem |
	presenter := MVSMainPresenter new.
	presenter listView items: MooseModel root.
	list := presenter listView listItems.
	selectedItem := MooseModel root at: 1.
	presenter listView setSelectedItem: selectedItem.
	presenter simulateDoubleClick.
	self deny: (presenter listView listItems includes: selectedItem)
]

{ #category : #'testing-drilling' }
MVSTest >> testDrillInMooseModelShowsPragmas [
	| presenter list selectedItem |
	
	presenter := MVSMainPresenter new.
	presenter listView items: MooseModel root.
	list := presenter listView listItems.
	
	selectedItem := MooseModel root at: 1.
	presenter listView setSelectedItem: selectedItem.
	presenter simulateDoubleClick.
	self assert: (presenter listView listItems allSatisfy: [ :each | 
		each mooseModel = selectedItem or: [ each mooseModel isNil ] ])
]

{ #category : #'testing-queryExecution' }
MVSTest >> testExecuteCorrectFilterTextReturnsFilteredCollection [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := self modelForTest.
	self assert: (filterManager executeQueryWith: self correctQuery on: testModel) size equals: 1
]

{ #category : #'testing-queryExecution' }
MVSTest >> testExecuteFilterWithIncorrectDotDoesNotFilter [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := self modelForTest.
	self assert: (filterManager executeQueryWith: 'true.true' on: testModel) size equals: 9
]

{ #category : #testing }
MVSTest >> testInitNavigation [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false.
]

{ #category : #tests }
MVSTest >> testMainPresenterListViewIsEmptyWhenNoModel [
|mainPresenter|
mainPresenter :=MVSMainPresenter new.
self assert: mainPresenter listView listItems equals: #()
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithArbitraryExpressionDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Object new'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithCorrectFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest .
	presenter queryWidget textField text: self correctQuery.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithCorrectFilterWithFloat [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: self correctQueryWithFloat.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithEmptyFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems asSet equals: self modelForTest asSet
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithExceptionExpressionDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Error signal'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithExceptionExpressionErrorReporterShowsError [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'self error: ''test error'''.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'Error: test error'
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithFalseFilterWorks [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1=2'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithIncorrectSyntaxFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '{'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithNonBooleanExpressionShowsError [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Object new'.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'MessageNotUnderstood: Object>>ifTrue:'
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithSequenceEndingWithFalseIsEmpty [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1+3 . false'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithSequenceEndingWithTrueDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1+3 . true'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithSyntaxShowsErrorInErrorReporter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '}|'.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'SyntaxErrorNotification: '']'' expected'
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithTrueFilterWorks [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1=1'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSTest >> testMainPresenterWithWrongFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'whatever it doe snot compile'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems asSet equals: self modelForTest asSet
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

{ #category : #testing }
MVSTest >> testWithEmptyHistoryHasNextButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter nextButton enabled
]

{ #category : #testing }
MVSTest >> testWithEmptyHistoryHasPreviousButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter previousButton enabled
]
