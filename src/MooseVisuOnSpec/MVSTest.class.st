"
I test the main presenter functionalities
"
Class {
	#name : #MVSTest,
	#superclass : #TestCase,
	#category : #'MooseVisuOnSpec-Tests'
}

{ #category : #'event testing' }
MVSTest >> testFilter [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := MVSFilterManager new.
	testModel := (MooseModel root at: 2) allModelClasses.
	self
		assert:
			(filterManager executeQueryWith: 'each isAnnotatedWith: ''Deprecated''' on: testModel)
				size
		equals: 25
]

{ #category : #'event testing' }
MVSTest >> testInitNavigation [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false.
]

{ #category : #'event testing' }
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

{ #category : #'event testing' }
MVSTest >> testNavigationWhenListViewItemsNotUpdatedAnPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter prev.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4).
	self assert: presenter history hasPast equals: false.
	self assert: presenter history hasPast equals: false
]

{ #category : #'event testing' }
MVSTest >> testNavigationWhenPreviousIsPress [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	presenter prev.
	self assert: presenter history hasPast equals: false.
	self assert: presenter history future top equals: #(0 8 7) sorted.
	self assert: presenter listView listItems  equals: #(0 1 2 3 4) sorted
]

{ #category : #'event testing' }
MVSTest >> testNextNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasNext  equals: false
]

{ #category : #'event testing' }
MVSTest >> testPastNavigationwhenUpdateListViewItems [
	| presenter |
	presenter := MVSMainPresenter withElements: #(0 1 2 3 4).
	presenter updateListViewItems: #(0 8 7).
	self assert: presenter history hasPast equals: true.
]
