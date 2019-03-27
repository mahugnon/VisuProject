"
I test the main presenter functionalities
"
Class {
	#name : #MVSNavigationTest,
	#superclass : #TestCase,
	#instVars : [
		'rootCurrent'
	],
	#category : #MooseVisuOnSpecTests
}

{ #category : #testing }
MVSNavigationTest >> testAddingElementsToHistoryEnablesPreviousButton [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context whenDrillDown:  #(0 8 7).
	self assert: presenter mvsMenuBar  previousButton enabled
]

{ #category : #testing }
MVSNavigationTest >> testInitNavigation [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self assert: presenter mvsMenuBar mvsHistory  hasPast equals: false.
	self assert: presenter mvsMenuBar mvsHistory hasPast equals: false
]

{ #category : #tests }
MVSNavigationTest >> testMainPresenterListViewIsEmptyWhenNoModel [
	| mainPresenter |
	MooseModel resetRoot.
	mainPresenter := MVSMainPresenter new.
	self assert: mainPresenter mooseView mooseModels listItems isEmpty
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenFutureIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context whenDrillDown: #(0 8 7).
	presenter mvsMenuBar prev.
	presenter mvsMenuBar next.
	self assert: presenter mvsMenuBar mvsHistory hasNext equals: false.
	self
		assert: presenter mvsMenuBar mvsHistory past top
		equals: #(0 1 2 3 4) sorted.
	self
		assert: presenter mooseView mooseModels listItems sorted
		equals: #(0 8 7) sorted
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenListViewItemsNotUpdatedAnPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter mvsMenuBar prev.
	self
		assert: presenter mooseView mooseModels listItems
		equals: #(0 1 2 3 4).
	self assert: presenter context history hasPast equals: false.
	self assert: presenter context history hasPast equals: false
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context whenDrillDown: #(0 8 7).
	presenter mvsMenuBar prev.
	self assert: presenter context history hasPast equals: false.
	self
		assert: presenter context history future top sorted
		equals: #(0 8 7) sorted.
	self
		assert: presenter mooseView mooseModels listItems sorted
		equals: #(0 1 2 3 4) sorted
]

{ #category : #testing }
MVSNavigationTest >> testNextNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context whenDrillDown: #(0 8 7).
	self assert: presenter context history hasNext equals: false
]

{ #category : #testing }
MVSNavigationTest >> testPastNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context whenDrillDown: #(0 8 7).
	self assert: presenter context history hasPast equals: true
]

{ #category : #tests }
MVSNavigationTest >> testUpdateListView [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter context whenDrillDown: #(1 2 3).
	self
		assert: mainPresenter mooseView mooseModels  listItems sorted
		equals: #(1 2 3)
]

{ #category : #tests }
MVSNavigationTest >> testWhenUpdateMainPresenterListViewWithEmptyIsEmpty [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter context whenDrillDown: #().
	self assert: mainPresenter mooseView mooseModels listItems isEmpty
]

{ #category : #testing }
MVSNavigationTest >> testWithEmptyHistoryHasNextButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter mvsMenuBar nextButton enabled
]

{ #category : #testing }
MVSNavigationTest >> testWithEmptyHistoryHasPreviousButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter mvsMenuBar previousButton enabled
]
