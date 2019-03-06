Class {
	#name : #MVSMooseViewPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'presenter'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSMooseViewPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #presenter;
		yourself
]

{ #category : #initialization }
MVSMooseViewPresenter >> createPresenter [
	presenter := self instantiate: FastTablePresenter.
	presenter
		displayBlock: [ :item | 
			item class = MooseModel
				ifTrue: [ item name ]
				ifFalse: [ item asString copyReplaceAll: 'famixt' with: 'famix' ] ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a asString < b asString ]
]

{ #category : #initialization }
MVSMooseViewPresenter >> initializeWidgets [
	self createPresenter
]

{ #category : #'as yet unclassified' }
MVSMooseViewPresenter >> populatePresenterWith: aCollection [
	^ presenter items: aCollection
]

{ #category : #initialization }
MVSMooseViewPresenter >> presenter [
	^ presenter
]

{ #category : #initialization }
MVSMooseViewPresenter >> subscribeToContext: aContext [
	super subscribeToContext: aContext.
	self populatePresenterWith: context mooseModel .

]
