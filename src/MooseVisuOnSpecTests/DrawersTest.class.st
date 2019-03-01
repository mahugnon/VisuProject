Class {
	#name : #DrawersTest,
	#superclass : #TestCase,
	#category : #MooseVisuOnSpecTests
}

{ #category : #tests }
DrawersTest >> testGetDrawersForFamixClass [
	| col |
	col := OrderedCollection new
		add: MVSFMClassInheritanceTreePresenter;
		yourself.

	self
		assert:
			((MVSDrawerManager new drawersFor: FAMIXClass new)
				sort: [ :a :b | a name < b name ])
		equals: (col sort: [ :a :b | a name < b name ])
]
