Class {
	#name : #WidgetClassListTest,
	#superclass : #TestCase,
	#category : #'Homework-tests'
}

{ #category : #'event testing' }
WidgetClassListTest >> testFilter [
	"Je permet de test filtre d'une liste "

	| testModel filterManager |
	filterManager := FilterManager new.
	testModel := (MooseModel root at: 2) allModelClasses.
	self
		assert:
			(filterManager executeQueryWith: 'each isAnnotatedWith: ''Deprecated''' on: testModel)
				size
		equals: 25
]
