Class {
	#name : #MVSFilterTest,
	#superclass : #TestCase,
	#category : #'MooseVisuOnSpec-tests'
}

{ #category : #'event testing' }
MVSFilterTest >> testFilter [
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
