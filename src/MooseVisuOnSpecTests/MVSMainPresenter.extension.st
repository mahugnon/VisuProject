Extension { #name : #MVSMainPresenter }

{ #category : #'*MooseVisuOnSpecTests' }
MVSMainPresenter class >> closeOpenWindow [
	^ self
		allInstancesDo: [ :each | 
			each window isNotNil
				ifTrue: [ each window close ] ]
]

{ #category : #'*MooseVisuOnSpecTests' }
MVSMainPresenter class >> countNumberOfSelfWindowOpen [
	^ (self allInstances select: [ :each | each window notNil ]) size
]

{ #category : #'*MooseVisuOnSpecTests' }
MVSMainPresenter >> simulateDoubleClick [
	self mooseView mooseModels
		doubleClick: self mooseView mooseModels doubleClickAction
]
