"
I test the main presenter functionalities
"
Class {
	#name : #MVSTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCurrent'
	],
	#category : #'MooseVisuOnSpec-Tests'
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
MooseModel resetRoot .
MooseModel root addAll: rootCurrent 

	
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
