Class {
	#name : #DrawersTest,
	#superclass : #TestCase,
	#category : #MooseVisuOnSpecTests
}

{ #category : #tests }
DrawersTest >> testFamixClassAdapter [
	self
		assert: (MVSAbstractAdapter adapterFor: FAMIXClass new) class
		equals: MVSFAMIXClassAdapter
]

{ #category : #tests }
DrawersTest >> testGetDrawersForFamixClass [
	| col |
	col := OrderedCollection new
		add: MVSFMClassInheritanceTreePresenter;
		yourself.
	self
		assert:
			((MVSAbstractAdapter adapterFor: FAMIXClass new) drawers
				sort: [ :a :b | a name < b name ])
		equals: (col sort: [ :a :b | a name < b name ])
]
