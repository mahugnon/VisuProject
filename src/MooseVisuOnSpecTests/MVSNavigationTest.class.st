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
	self
		assert:
			mainPresenter mooseView mooseModelPresenter listItems
				isEmpty 
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenFutureIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter context mooseModel: #(0 8 7).
	presenter mvsMenuBar  prev.
	presenter mvsMenuBar  next.
	self assert: presenter mvsMenuBar mvsHistory hasNext equals: false.
	self assert: presenter mvsMenuBar mvsHistory past top equals: #(0 1 2 3 4) sorted.
	self assert: presenter mooseView mooseModelPresenter  listItems equals: #(0 8 7) sorted
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenListViewItemsNotUpdatedAnPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter prev.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false
]

{ #category : #testing }
MVSNavigationTest >> testNavigationWhenPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	presenter prev.
	self assert: presenter history hasPast equals: false.
	self assert: presenter history future top equals: #(0 8 7) sorted.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4) sorted
]

{ #category : #testing }
MVSNavigationTest >> testNextNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasNext  equals: false
]

{ #category : #testing }
MVSNavigationTest >> testPastNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasPast equals: true.
]

{ #category : #tests }
MVSNavigationTest >> testUpdateListView [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter updateListViewItems: #(1 2 3).
	self assert: mainPresenter listView listItems equals: #(1 2 3)
]

{ #category : #tests }
MVSNavigationTest >> testWhenUpdateMainPresenterListViewWithEmptyIsEmpty [
	| mainPresenter |
	mainPresenter := MVSMainPresenter new.
	mainPresenter updateListViewItems: #().
	self assert: mainPresenter listView listItems equals: #()
]

{ #category : #testing }
MVSNavigationTest >> testWithEmptyHistoryHasNextButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter nextButton enabled
]

{ #category : #testing }
MVSNavigationTest >> testWithEmptyHistoryHasPreviousButtonDisabled [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self deny: presenter previousButton enabled
]
