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

{ #category : #creation }
MVSMooseViewPresenter >> contextMenuForMooseModel [
	| menuItemPresenters |
	menuItemPresenters := self modelAdapter mvsContextMenu.
	menuItemPresenters isEmpty
		ifTrue: [ ^ self ].
	mooseModelPresenter
		menu: [ MenuPresenter new
				addGroup:
						[ :group | menuItemPresenters do: [ :each | group addMenuItem: each ] ];
				buildWithSpecAsPopup ]
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

{ #category : #'api-events' }
MVSMooseViewPresenter >> doubleClickActionOnModel [
	^ self modelAdapter mvsDoubleClickOn: self
]

{ #category : #initialization }
MVSMooseViewPresenter >> initializePresenter [
	mooseModelPresenter
		handlesDoubleClick: true;
		autoDeselect: true;
		whenSelectedItemChanged: [ :item | context focus: item .
			self contextMenuForMooseModel];
		doubleClickAction: [ :item | self doubleClickActionOnModel ].
	
]

{ #category : #initialization }
MVSMooseViewPresenter >> initializeWidgets [
	self createPresenter
]

{ #category : #utilities }
MVSMooseViewPresenter >> modelAdapter [
	^ (MVSAbstractAdapter adapterFor: context focus)
		context: context;
		yourself
]

{ #category : #initialization }
MVSMooseViewPresenter >> mooseModelPresenter [
	^ mooseModelPresenter
]

{ #category : #action }
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
