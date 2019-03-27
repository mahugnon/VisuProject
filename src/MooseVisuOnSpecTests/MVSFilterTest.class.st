"
Test moose query execution on the model
"
Class {
	#name : #MVSFilterTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCurrent',
		'testModel'
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
MVSFilterTest >> createFamix: aClass named: aString owner: ownerBlock [
	| fmx |
	fmx := aClass new
		name: aString;
		isStub: false;
		mooseModel: testModel;
		yourself.
	ownerBlock value: fmx.
	^ fmx
]

{ #category : #'testing-utilities' }
MVSFilterTest >> createTestingModel [
	| pckg clazz mth |
	testModel := MooseModel new
		name: ' testmodel';
		yourself.
	pckg := self
		createFamix: FAMIXPackage
		named: 'TestMokePackage'
		owner: [ :x |  ].
	clazz := self
		createFamix: FAMIXClass
		named: 'TestClass1'
		owner: [ :c | c parentPackage: pckg ].
	clazz hierarchyNestingLevel: 2.
	#('TestClass2' 'TestClass3' 'ModelClass4' 'TestClass4' 'TestClass6' 'TestClass7' 'TestClass8' 'TestClass9')
		do: [ :each | 
			| sub |
			sub := self
				createFamix: FAMIXClass
				named: each
				owner: [ :c | c parentPackage: pckg ].
			self inherit: sub from: clazz ].
	mth := self
		createFamix: FAMIXMethod
		named: 'testMthd1_1'
		owner: [ :m | m parentType: clazz ].
	clazz := testModel entityNamed: 'TestClass3'.
	mth := self
		createFamix: FAMIXMethod
		named: 'testMthd3_1'
		owner: [ :m | m parentType: clazz ].
	MooseModel root add: testModel
]

{ #category : #'testing-utilities' }
MVSFilterTest >> inherit: sub from: supr [
	| inh |
	inh := FAMIXInheritance new
		mooseModel: testModel ;
		yourself.
	sub addSuperInheritance: inh.
	supr addSubInheritance: inh
]

{ #category : #testing }
MVSFilterTest >> modelForTest [
	^ (MooseModel root at: 1) allModelClasses
]

{ #category : #running }
MVSFilterTest >> setUp [
	super setUp.
	rootCurrent := MooseModel root.
	MooseModel resetRoot .
	self createTestingModel
	"MooseModel root add: rootCurrent"
]

{ #category : #'testing-utilities' }
MVSFilterTest >> tearDown [
	MooseModel resetRoot.
	MooseModel root addAll: rootCurrent.
	MVSMainPresenter closeOpenWindow.
	super tearDown
]

{ #category : #'testing-drilling' }
MVSFilterTest >> testDrillInMooseModelDoesNotShowClickedModelInList [
	| presenter selectedItem |
	presenter := MVSMainPresenter withElements: MooseModel root.
	selectedItem := MooseModel root at: 1.
	presenter mooseView mooseModels setSelectedItem: selectedItem.
	presenter simulateDoubleClick.
	self
		deny: (presenter mooseView mooseModels listItems includes: selectedItem)
]

{ #category : #'testing-drilling' }
MVSFilterTest >> testDrillInMooseModelShowsPragmas [
	| presenter list selectedItem |
	
	presenter := MVSMainPresenter withElements:  MooseModel root.
	list := presenter mooseView mooseModels listItems.
	
	selectedItem := MooseModel root at: 1.
	presenter mooseView mooseModels setSelectedItem: selectedItem.
	presenter simulateDoubleClick.
	self assert: (presenter mooseView mooseModels listItems allSatisfy: [ :each | 
		each mooseModel = selectedItem or: [ each mooseModel isNil ] ])
]

{ #category : #'testing-queryExecution' }
MVSFilterTest >> testExecuteCorrectFilterTextReturnsFilteredCollection [
	"Je permet de test filtre d'une liste "

	| testingModel filterManager |
	filterManager := MVSFilterManager new.
	testingModel := self modelForTest.
	self
		assert: (filterManager executeQueryWith: self correctQuery on: testingModel ) size
		equals: 1
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
	presenter := MVSMainPresenter withElements:  self modelForTest.
	presenter mvsQueryPresenter textField text: 'Object new'.
	presenter mvsQueryPresenter type: 13.
	self assert: presenter mooseView mooseModels listItems size equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithCorrectFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: self correctQuery.
	presenter mvsQueryPresenter type: 13.
	self assert: presenter mooseView mooseModels listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithCorrectFilterWithFloat [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField
		text: self correctQueryWithFloat.
	presenter mvsQueryPresenter type: 13.
	self assert: presenter mooseView mooseModels listItems size equals: 1
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithEmptyFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter type: 13.
	self
		assert: presenter mooseView mooseModels listItems asSet
		equals: self modelForTest asSet
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithExceptionExpressionDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: 'Error signal'.
	presenter mvsQueryPresenter type: 13.
	self
		assert: presenter mooseView mooseModels listItems size
		equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithExceptionExpressionErrorReporterShowsError [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField
		text: 'self error: ''test error'''.
	presenter mvsQueryPresenter type: 13.
	self
		assert: presenter errorReporter message
		equals: 'Error: test error'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithFalseFilterWorks [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '1=2'.
	presenter mvsQueryPresenter type: 13.
	self assert: presenter mooseView mooseModels  listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithIncorrectSyntaxFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '{'.
	presenter mvsQueryPresenter type: 13.
	self
		assert: presenter mooseView mooseModels listItems size
		equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithNonBooleanExpressionShowsError [
	| presenter |
	presenter := MVSMainPresenter withElements:  self modelForTest.
	presenter mvsQueryPresenter textField text: 'Object new'.
	presenter mvsQueryPresenter type: 13.
	self assert: presenter errorReporter message equals: 'MessageNotUnderstood: Object>>ifTrue:'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSequenceEndingWithFalseIsEmpty [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '1+3 . false'.
	presenter mvsQueryPresenter type: Character cr.
	self assert: presenter mooseView mooseModels listItems isEmpty
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSequenceEndingWithTrueDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '1+3 . true'.
	presenter mvsQueryPresenter type: Character cr.
	self
		assert: presenter mooseView mooseModels listItems size
		equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithSyntaxShowsErrorInErrorReporter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '}|'.
	presenter mvsQueryPresenter type: Character cr.
	self
		assert: presenter errorReporter message
		equals: 'SyntaxErrorNotification: '']'' expected'
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithTrueFilterWorks [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField text: '1=1'.
	presenter mvsQueryPresenter type: Character cr.
	self
		assert: presenter mooseView mooseModels listItems size
		equals: self modelForTest size
]

{ #category : #'testing-filter-interaction' }
MVSFilterTest >> testMainPresenterWithWrongFilterDoesNotFilter [
	| presenter |
	presenter := MVSMainPresenter withElements: self modelForTest.
	presenter mvsQueryPresenter textField
		text: 'whatever it doe snot compile'.
	presenter mvsQueryPresenter type: Character cr.
	self
		assert: presenter mooseView mooseModels listItems asSet
		equals: self modelForTest asSet
]

{ #category : #tests }
MVSFilterTest >> testOpenInNewWindowWhenOptionIsChecked [
	| presenter numberOfOpenMainPresenterWindow|
	presenter := MVSMainPresenter withElements:MooseModel root .
	presenter openResultNewWindowCheckBox state: true.
	presenter mooseView mooseModels setSelectedItem: (MooseModel root at: 1).
	numberOfOpenMainPresenterWindow := MVSMainPresenter countNumberOfSelfWindowOpen .
	presenter simulateDoubleClick.
	self assert: (numberOfOpenMainPresenterWindow <MVSMainPresenter countNumberOfSelfWindowOpen )
	
]
