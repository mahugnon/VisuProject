"
I'm the component responsable of managing the mooseModel
"
Class {
	#name : #MVSMooseViewPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'mooseModelPresenter'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSMooseViewPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #mooseModelPresenter;
		yourself
]

{ #category : #'as yet unclassified' }
MVSMooseViewPresenter >> contextMenu [
^self modelAdapter mvsContetMenu
]

{ #category : #initialization }
MVSMooseViewPresenter >> createPresenter [
	mooseModelPresenter := self instantiate: FastTablePresenter.
	mooseModelPresenter
		displayBlock: [ :item | 
			item class = MooseModel
				ifTrue: [ item name ]
				ifFalse: [ item asString copyReplaceAll: 'famixt' with: 'famix' ] ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a asString < b asString ]
]

{ #category : #'as yet unclassified' }
MVSMooseViewPresenter >> doubleClickActionOnModel [
	^ self modelAdapter mvsDoubleClickOn: self
]

{ #category : #initialization }
MVSMooseViewPresenter >> initializePresenter [
	mooseModelPresenter
		handlesDoubleClick: true;
		whenSelectedItemChanged: [ :item | context focus: item ];
		doubleClickAction: [ :item | self doubleClickActionOnModel ];
		menu: [ self modelAdapter contextMenu ]
]

{ #category : #initialization }
MVSMooseViewPresenter >> initializeWidgets [
	self createPresenter
]

{ #category : #utilities }
MVSMooseViewPresenter >> modelAdapter [
	^( MVSAbstractAdapter adapterFor: context focusName)
	 context: context;yourself 
	
]

{ #category : #initialization }
MVSMooseViewPresenter >> mooseModelPresenter [
	^ mooseModelPresenter
]

{ #category : #'as yet unclassified' }
MVSMooseViewPresenter >> populatePresenterWith: aCollection [
	^ mooseModelPresenter items: aCollection
]

{ #category : #initialization }
MVSMooseViewPresenter >> subscribeToContext: aContext [
	super subscribeToContext: aContext.
	self populatePresenterWith: context mooseModel .

]

{ #category : #'model updates' }
MVSMooseViewPresenter >> update [
	mooseModelPresenter items: context mooseModel
]
