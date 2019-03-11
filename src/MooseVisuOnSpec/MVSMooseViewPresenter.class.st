"
I'm the component responsable of managing the mooseModel
"
Class {
	#name : #MVSMooseViewPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'mooseModels'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSMooseViewPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #mooseModels;
		yourself
]

{ #category : #creation }
MVSMooseViewPresenter >> contextMenuForMooseModel [
	| menuItemPresenters |
	menuItemPresenters := self modelAdapter mvsContextMenu.
	menuItemPresenters isEmpty
		ifTrue: [ ^ self ].
	mooseModels
		menu: [ MenuPresenter new
				addGroup:
						[ :group | menuItemPresenters do: [ :each | group addMenuItem: each ] ];
				buildWithSpecAsPopup ]
]

{ #category : #initialization }
MVSMooseViewPresenter >> createPresenter [
	mooseModels := self instantiate: FastTablePresenter.
	mooseModels
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
	mooseModels
		handlesDoubleClick: true;
		autoDeselect: true;
		whenSelectedItemChanged: [ :item | 
			item isNotNil
				ifTrue: [ context focus: item.
					self contextMenuForMooseModel ] ];
		doubleClickAction: [ :item | 
		 context focus:(mooseModels listElementAt: mooseModels selectedIndex) . 
			self doubleClickActionOnModel ]
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
MVSMooseViewPresenter >> mooseModels [
	^ mooseModels
]

{ #category : #action }
MVSMooseViewPresenter >> populatePresenterWith: aCollection [
	^ mooseModels items: aCollection
]

{ #category : #initialization }
MVSMooseViewPresenter >> subscribeToContext: aContext [
	super subscribeToContext: aContext.
	self populatePresenterWith: context mooseModel .

]

{ #category : #'model updates' }
MVSMooseViewPresenter >> update [
	mooseModels items: context mooseModel
]
