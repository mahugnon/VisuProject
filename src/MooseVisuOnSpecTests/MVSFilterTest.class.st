"
Test moose query execution on the model
"
Class {
	#name : #MVSFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCurrent'
	],
	#category : #MooseVisuOnSpecTests
}

{ #category : #testing }
MVSFilterTest >> correctQuery [
	^ 'each hierarchyNestingLevel=2'
]

{ #category : #testing }
MVSFilterTest >> correctQueryWithFloat [
	^ 'each hierarchyNestingLevel=2.0'
]

{ #category : #'testing-utilities' }
MVSFilterTest >> createTestingMSE [
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

{ #category : #'testing-utilities' }
MVSFilterTest >> createTestingModel [
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
MVSFilterTest >> modelForTest [
	^ (MooseModel root at: 1) allModelClasses
]

{ #category : #running }
MVSFilterTest >> setUp [
	
	super setUp.
	self createTestingModel.
	rootCurrent := MooseModel root.
	MooseModel resetRoot.
	MooseModel root add: self createTestingMSE
]

{ #category : #running }
MVSFilterTest >> tearDown [
	super tearDown.
	MooseModel resetRoot.
	MooseModel root addAll: rootCurrent.
	MVSMainPresenter closeOfSelfWindowOpen.
	(MCPackage named: 'TestMokePackage') unload. 
]

{ #category : #'testing-drilling' }
MVSFilterTest >> testDrillInMooseModelDoesNotShowClickedModelInList [
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
MVSFilterTest >> testDrillInMooseModelShowsPragmas [
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
MVSFilterTest >> testExecuteCorrectFilterTextReturnsFilteredCollection [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := self modelForTest.
	self assert: (filterManager executeQueryWith: self correctQuery on: testModel) size equals: 1
]

{ #category : #'testing-queryExecution' }
MVSFilterTest >> testExecuteFilterWithIncorrectDotDoesNotFilter [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := self modelForTest.
	self assert: (filterManager executeQueryWith: 'true.true' on: testModel) size equals: 9
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithArbitraryExpressionDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Object new'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithCorrectFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest .
	presenter queryWidget textField text: self correctQuery.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithCorrectFilterWithFloat [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: self correctQueryWithFloat.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithEmptyFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems asSet equals: self modelForTest asSet
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithExceptionExpressionDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Error signal'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithExceptionExpressionErrorReporterShowsError [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'self error: ''test error'''.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'Error: test error'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithFalseFilterWorks [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1=2'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithIncorrectSyntaxFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '{'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithNonBooleanExpressionShowsError [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'Object new'.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'MessageNotUnderstood: Object>>ifTrue:'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSequenceEndingWithFalseIsEmpty [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1+3 . false'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSequenceEndingWithTrueDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1+3 . true'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSyntaxShowsErrorInErrorReporter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '}|'.
	presenter queryWidget type: 13.
	self assert: presenter errorReporter message equals: 'SyntaxErrorNotification: '']'' expected'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithTrueFilterWorks [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: '1=1'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithWrongFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter new.
	presenter listView items: self modelForTest.
	presenter queryWidget textField text: 'whatever it doe snot compile'.
	presenter queryWidget type: 13.
	self assert: presenter listView listItems asSet equals: self modelForTest asSet
]

{ #category : #tests }
MVSFilterTest >> testOpenInNewWindowWhenOptionIsChecked [
	| presenter numberOfOpenMainPresenterWindow|
	presenter := MVSMainPresenter new.
	presenter openResultNewWindowCheckBox state: true.
	presenter listView items: MooseModel root.
	presenter listView setSelectedItem: (MooseModel root at: 1).
	numberOfOpenMainPresenterWindow := MVSMainPresenter countNumberOfSelfWindowOpen .
	presenter simulateDoubleClick.
	self assert: (numberOfOpenMainPresenterWindow <MVSMainPresenter countNumberOfSelfWindowOpen )
	
]
